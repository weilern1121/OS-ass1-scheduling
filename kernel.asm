
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
80100041:	ba 60 86 10 80       	mov    $0x80108660,%edx
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
8010005c:	e8 cf 57 00 00       	call   80105830 <initlock>

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
80100082:	b8 67 86 10 80       	mov    $0x80108667,%eax
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
8010009b:	e8 60 56 00 00       	call   80105700 <initsleeplock>
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
801000e6:	e8 a5 58 00 00       	call   80105990 <acquire>

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
80100161:	e8 ca 58 00 00       	call   80105a30 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 cf 55 00 00       	call   80105740 <acquiresleep>
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
8010018e:	c7 04 24 6e 86 10 80 	movl   $0x8010866e,(%esp)
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
801001b0:	e8 2b 56 00 00       	call   801057e0 <holdingsleep>
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
801001c9:	c7 04 24 7f 86 10 80 	movl   $0x8010867f,(%esp)
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
801001f1:	e8 ea 55 00 00       	call   801057e0 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5a                	je     80100254 <brelse+0x74>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 9e 55 00 00       	call   801057a0 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 20 d6 10 80 	movl   $0x8010d620,(%esp)
80100209:	e8 82 57 00 00       	call   80105990 <acquire>
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
8010024f:	e9 dc 57 00 00       	jmp    80105a30 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100254:	c7 04 24 86 86 10 80 	movl   $0x80108686,(%esp)
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
8010027e:	e8 0d 57 00 00       	call   80105990 <acquire>
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
801002ac:	e8 6f 40 00 00       	call   80104320 <sleep>

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
801002f3:	e8 38 57 00 00       	call   80105a30 <release>
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
8010030f:	e8 1c 57 00 00       	call   80105a30 <release>
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
8010035c:	c7 04 24 8d 86 10 80 	movl   $0x8010868d,(%esp)
80100363:	89 44 24 04          	mov    %eax,0x4(%esp)
80100367:	e8 d4 02 00 00       	call   80100640 <cprintf>
  cprintf(s);
8010036c:	8b 45 08             	mov    0x8(%ebp),%eax
8010036f:	89 04 24             	mov    %eax,(%esp)
80100372:	e8 c9 02 00 00       	call   80100640 <cprintf>
  cprintf("\n");
80100377:	c7 04 24 ed 8d 10 80 	movl   $0x80108ded,(%esp)
8010037e:	e8 bd 02 00 00       	call   80100640 <cprintf>
  getcallerpcs(&s, pcs);
80100383:	8d 45 08             	lea    0x8(%ebp),%eax
80100386:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010038a:	89 04 24             	mov    %eax,(%esp)
8010038d:	e8 be 54 00 00       	call   80105850 <getcallerpcs>
80100392:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003a0:	8b 03                	mov    (%ebx),%eax
801003a2:	83 c3 04             	add    $0x4,%ebx
801003a5:	c7 04 24 a1 86 10 80 	movl   $0x801086a1,(%esp)
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
801003f9:	e8 f2 6d 00 00       	call   801071f0 <uartputc>
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
801004a7:	e8 44 6d 00 00       	call   801071f0 <uartputc>
801004ac:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004b3:	e8 38 6d 00 00       	call   801071f0 <uartputc>
801004b8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004bf:	e8 2c 6d 00 00       	call   801071f0 <uartputc>
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
801004e5:	e8 56 56 00 00       	call   80105b40 <memmove>
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
8010050d:	e8 6e 55 00 00       	call   80105a80 <memset>
80100512:	89 f1                	mov    %esi,%ecx
80100514:	c6 45 d8 07          	movb   $0x7,-0x28(%ebp)
80100518:	e9 56 ff ff ff       	jmp    80100473 <consputc+0xa3>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010051d:	c7 04 24 a5 86 10 80 	movl   $0x801086a5,(%esp)
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
80100591:	0f b6 92 d0 86 10 80 	movzbl -0x7fef7930(%edx),%edx
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
801005fe:	e8 8d 53 00 00       	call   80105990 <acquire>
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
80100624:	e8 07 54 00 00       	call   80105a30 <release>
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
801006e6:	e8 45 53 00 00       	call   80105a30 <release>
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
80100758:	b8 b8 86 10 80       	mov    $0x801086b8,%eax
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
8010078f:	e8 fc 51 00 00       	call   80105990 <acquire>
80100794:	e9 c0 fe ff ff       	jmp    80100659 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
80100799:	c7 04 24 bf 86 10 80 	movl   $0x801086bf,(%esp)
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
801007c4:	e8 c7 51 00 00       	call   80105990 <acquire>
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
80100827:	e8 04 52 00 00       	call   80105a30 <release>
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
801008b9:	e8 62 3c 00 00       	call   80104520 <wakeup>
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
8010092e:	e9 bd 3c 00 00       	jmp    801045f0 <procdump>
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
80100961:	b8 c8 86 10 80       	mov    $0x801086c8,%eax
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
80100976:	e8 b5 4e 00 00       	call   80105830 <initlock>

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
80100a44:	e8 47 79 00 00       	call   80108390 <setupkvm>
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
80100af1:	e8 ea 76 00 00       	call   801081e0 <allocuvm>
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
80100b32:	e8 e9 75 00 00       	call   80108120 <loaduvm>
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
80100b49:	e8 c2 77 00 00       	call   80108310 <freevm>
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
80100b8c:	e8 4f 76 00 00       	call   801081e0 <allocuvm>
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
80100ba0:	e8 6b 77 00 00       	call   80108310 <freevm>
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
80100bb4:	c7 04 24 e1 86 10 80 	movl   $0x801086e1,(%esp)
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
80100be1:	e8 5a 78 00 00       	call   80108440 <clearpteu>
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
80100c10:	e8 9b 50 00 00       	call   80105cb0 <strlen>
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
80100c25:	e8 86 50 00 00       	call   80105cb0 <strlen>
80100c2a:	40                   	inc    %eax
80100c2b:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c32:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c35:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c39:	89 34 24             	mov    %esi,(%esp)
80100c3c:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c40:	e8 6b 79 00 00       	call   801085b0 <copyout>
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
80100cb0:	e8 fb 78 00 00       	call   801085b0 <copyout>
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
80100cf9:	e8 72 4f 00 00       	call   80105c70 <safestrcpy>

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
80100d25:	e8 66 72 00 00       	call   80107f90 <switchuvm>
  freevm(oldpgdir);
80100d2a:	89 3c 24             	mov    %edi,(%esp)
80100d2d:	e8 de 75 00 00       	call   80108310 <freevm>
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
80100d41:	b8 ed 86 10 80       	mov    $0x801086ed,%eax
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
80100d56:	e8 d5 4a 00 00       	call   80105830 <initlock>
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
80100d73:	e8 18 4c 00 00       	call   80105990 <acquire>
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
80100da0:	e8 8b 4c 00 00       	call   80105a30 <release>
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
80100db7:	e8 74 4c 00 00       	call   80105a30 <release>
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
80100de1:	e8 aa 4b 00 00       	call   80105990 <acquire>
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
80100df8:	e8 33 4c 00 00       	call   80105a30 <release>
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
80100e05:	c7 04 24 f4 86 10 80 	movl   $0x801086f4,(%esp)
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
80100e39:	e8 52 4b 00 00       	call   80105990 <acquire>
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
80100e64:	e9 c7 4b 00 00       	jmp    80105a30 <release>
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
80100e8f:	e8 9c 4b 00 00       	call   80105a30 <release>

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
80100ee9:	c7 04 24 fc 86 10 80 	movl   $0x801086fc,(%esp)
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
80100fe7:	c7 04 24 06 87 10 80 	movl   $0x80108706,(%esp)
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
80101101:	c7 04 24 0f 87 10 80 	movl   $0x8010870f,(%esp)
80101108:	e8 33 f2 ff ff       	call   80100340 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
8010110d:	c7 04 24 15 87 10 80 	movl   $0x80108715,(%esp)
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
801011b8:	c7 04 24 1f 87 10 80 	movl   $0x8010871f,(%esp)
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
8010120e:	e8 6d 48 00 00       	call   80105a80 <memset>
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
8010124c:	e8 3f 47 00 00       	call   80105990 <acquire>

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
8010128f:	e8 9c 47 00 00       	call   80105a30 <release>
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
801012de:	e8 4d 47 00 00       	call   80105a30 <release>

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
801012ed:	c7 04 24 35 87 10 80 	movl   $0x80108735,(%esp)
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
801013bf:	c7 04 24 45 87 10 80 	movl   $0x80108745,(%esp)
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
80101408:	e8 33 47 00 00       	call   80105b40 <memmove>
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
80101497:	c7 04 24 58 87 10 80 	movl   $0x80108758,(%esp)
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
801014b1:	b9 6b 87 10 80       	mov    $0x8010876b,%ecx
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
801014cc:	e8 5f 43 00 00       	call   80105830 <initlock>
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
801014e0:	ba 72 87 10 80       	mov    $0x80108772,%edx
801014e5:	89 1c 24             	mov    %ebx,(%esp)
801014e8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014ee:	89 54 24 04          	mov    %edx,0x4(%esp)
801014f2:	e8 09 42 00 00       	call   80105700 <initsleeplock>
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
80101518:	c7 04 24 d8 87 10 80 	movl   $0x801087d8,(%esp)
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
801015f3:	e8 88 44 00 00       	call   80105a80 <memset>
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
80101621:	c7 04 24 78 87 10 80 	movl   $0x80108778,(%esp)
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
801016a2:	e8 99 44 00 00       	call   80105b40 <memmove>
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
801016d1:	e8 ba 42 00 00       	call   80105990 <acquire>
  ip->ref++;
801016d6:	ff 43 08             	incl   0x8(%ebx)
  release(&icache.lock);
801016d9:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
801016e0:	e8 4b 43 00 00       	call   80105a30 <release>
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
80101714:	e8 27 40 00 00       	call   80105740 <acquiresleep>

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
80101796:	e8 a5 43 00 00       	call   80105b40 <memmove>
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
801017b5:	c7 04 24 90 87 10 80 	movl   $0x80108790,(%esp)
801017bc:	e8 7f eb ff ff       	call   80100340 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
801017c1:	c7 04 24 8a 87 10 80 	movl   $0x8010878a,(%esp)
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
801017e9:	e8 f2 3f 00 00       	call   801057e0 <holdingsleep>
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
80101805:	e9 96 3f 00 00       	jmp    801057a0 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
8010180a:	c7 04 24 9f 87 10 80 	movl   $0x8010879f,(%esp)
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
80101838:	e8 03 3f 00 00       	call   80105740 <acquiresleep>
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
8010184e:	e8 4d 3f 00 00       	call   801057a0 <releasesleep>

  acquire(&icache.lock);
80101853:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
8010185a:	e8 31 41 00 00       	call   80105990 <acquire>
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
80101875:	e9 b6 41 00 00       	jmp    80105a30 <release>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
80101880:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101887:	e8 04 41 00 00       	call   80105990 <acquire>
    int r = ip->ref;
8010188c:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
8010188f:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101896:	e8 95 41 00 00       	call   80105a30 <release>
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
80101a82:	e8 b9 40 00 00       	call   80105b40 <memmove>
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
80101b92:	e8 a9 3f 00 00       	call   80105b40 <memmove>
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
80101c3c:	e8 6f 3f 00 00       	call   80105bb0 <strncmp>
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
80101cbb:	e8 f0 3e 00 00       	call   80105bb0 <strncmp>
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
80101cf2:	c7 04 24 b9 87 10 80 	movl   $0x801087b9,(%esp)
80101cf9:	e8 42 e6 ff ff       	call   80100340 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101cfe:	c7 04 24 a7 87 10 80 	movl   $0x801087a7,(%esp)
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
80101d38:	e8 53 3c 00 00       	call   80105990 <acquire>
  ip->ref++;
80101d3d:	ff 46 08             	incl   0x8(%esi)
  release(&icache.lock);
80101d40:	c7 04 24 40 2a 11 80 	movl   $0x80112a40,(%esp)
80101d47:	e8 e4 3c 00 00       	call   80105a30 <release>
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
80101dac:	e8 8f 3d 00 00       	call   80105b40 <memmove>
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
80101e31:	e8 0a 3d 00 00       	call   80105b40 <memmove>
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
80101f33:	e8 d8 3c 00 00       	call   80105c10 <strncpy>
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
80101f76:	c7 04 24 c8 87 10 80 	movl   $0x801087c8,(%esp)
80101f7d:	e8 be e3 ff ff       	call   80100340 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101f82:	c7 04 24 ea 8e 10 80 	movl   $0x80108eea,(%esp)
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
8010207a:	c7 04 24 34 88 10 80 	movl   $0x80108834,(%esp)
80102081:	e8 ba e2 ff ff       	call   80100340 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80102086:	c7 04 24 2b 88 10 80 	movl   $0x8010882b,(%esp)
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
801020a1:	ba 46 88 10 80       	mov    $0x80108846,%edx
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
801020b6:	e8 75 37 00 00       	call   80105830 <initlock>
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
80102130:	e8 5b 38 00 00       	call   80105990 <acquire>

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
8010215c:	e8 bf 23 00 00       	call   80104520 <wakeup>

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
80102176:	e8 b5 38 00 00       	call   80105a30 <release>
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
801021d0:	e8 0b 36 00 00       	call   801057e0 <holdingsleep>
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
80102207:	e8 84 37 00 00       	call   80105990 <acquire>

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
8010224c:	e8 cf 20 00 00       	call   80104320 <sleep>
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
80102267:	e9 c4 37 00 00       	jmp    80105a30 <release>

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
8010227c:	c7 04 24 4a 88 10 80 	movl   $0x8010884a,(%esp)
80102283:	e8 b8 e0 ff ff       	call   80100340 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102288:	c7 04 24 75 88 10 80 	movl   $0x80108875,(%esp)
8010228f:	e8 ac e0 ff ff       	call   80100340 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102294:	c7 04 24 60 88 10 80 	movl   $0x80108860,(%esp)
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
801022e9:	c7 04 24 94 88 10 80 	movl   $0x80108894,(%esp)
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
801023d0:	e8 ab 36 00 00       	call   80105a80 <memset>

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
8010240c:	e9 1f 36 00 00       	jmp    80105a30 <release>
80102411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102418:	c7 04 24 a0 46 11 80 	movl   $0x801146a0,(%esp)
8010241f:	e8 6c 35 00 00       	call   80105990 <acquire>
80102424:	eb b8                	jmp    801023de <kfree+0x4e>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
80102426:	c7 04 24 c6 88 10 80 	movl   $0x801088c6,(%esp)
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
80102491:	b8 cc 88 10 80       	mov    $0x801088cc,%eax
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
801024ab:	e8 80 33 00 00       	call   80105830 <initlock>

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
8010259a:	e8 91 34 00 00       	call   80105a30 <release>
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
801025af:	e8 dc 33 00 00       	call   80105990 <acquire>
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
80102608:	0f b6 82 00 8a 10 80 	movzbl -0x7fef7600(%edx),%eax
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
80102635:	0f b6 82 00 8a 10 80 	movzbl -0x7fef7600(%edx),%eax
8010263c:	09 c1                	or     %eax,%ecx
8010263e:	0f b6 82 00 89 10 80 	movzbl -0x7fef7700(%edx),%eax
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
8010264f:	8b 04 85 e0 88 10 80 	mov    -0x7fef7720(,%eax,4),%eax
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
8010299c:	e8 3f 31 00 00       	call   80105ae0 <memcmp>
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
80102abc:	e8 7f 30 00 00       	call   80105b40 <memmove>
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
80102b61:	ba 00 8b 10 80       	mov    $0x80108b00,%edx
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
80102b7a:	e8 b1 2c 00 00       	call   80105830 <initlock>
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
80102c0d:	e8 7e 2d 00 00       	call   80105990 <acquire>
80102c12:	eb 19                	jmp    80102c2d <begin_op+0x2d>
80102c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c18:	b8 e0 46 11 80       	mov    $0x801146e0,%eax
80102c1d:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c21:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102c28:	e8 f3 16 00 00       	call   80104320 <sleep>
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
80102c5a:	e8 d1 2d 00 00       	call   80105a30 <release>
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
80102c80:	e8 0b 2d 00 00       	call   80105990 <acquire>
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
80102cba:	e8 71 2d 00 00       	call   80105a30 <release>
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
80102d1c:	e8 1f 2e 00 00       	call   80105b40 <memmove>
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
80102d5f:	e8 2c 2c 00 00       	call   80105990 <acquire>
    log.committing = 0;
80102d64:	31 c0                	xor    %eax,%eax
80102d66:	a3 20 47 11 80       	mov    %eax,0x80114720
    wakeup(&log);
80102d6b:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102d72:	e8 a9 17 00 00       	call   80104520 <wakeup>
    release(&log.lock);
80102d77:	c7 04 24 e0 46 11 80 	movl   $0x801146e0,(%esp)
80102d7e:	e8 ad 2c 00 00       	call   80105a30 <release>
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
80102d8b:	c7 04 24 04 8b 10 80 	movl   $0x80108b04,(%esp)
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
80102ddb:	e8 b0 2b 00 00       	call   80105990 <acquire>
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
80102e2b:	e9 00 2c 00 00       	jmp    80105a30 <release>
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
80102e48:	c7 04 24 13 8b 10 80 	movl   $0x80108b13,(%esp)
80102e4f:	e8 ec d4 ff ff       	call   80100340 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102e54:	c7 04 24 29 8b 10 80 	movl   $0x80108b29,(%esp)
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
80102e67:	e8 04 51 00 00       	call   80107f70 <switchkvm>
  seginit();
80102e6c:	e8 ff 4f 00 00       	call   80107e70 <seginit>
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
80102e82:	c7 04 24 44 8b 10 80 	movl   $0x80108b44,(%esp)
80102e89:	89 44 24 04          	mov    %eax,0x4(%esp)
80102e8d:	e8 ae d7 ff ff       	call   80100640 <cprintf>
  idtinit();       // load idt register
80102e92:	e8 59 3f 00 00       	call   80106df0 <idtinit>
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
80102eca:	c7 04 24 94 8b 10 80 	movl   $0x80108b94,(%esp)
80102ed1:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ed5:	e8 66 d7 ff ff       	call   80100640 <cprintf>
  scheduler();     // start running processes
80102eda:	e8 01 0f 00 00       	call   80103de0 <scheduler>
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
80102f04:	e8 17 55 00 00       	call   80108420 <kvmalloc>
  mpinit();        // detect other processors
80102f09:	e8 02 02 00 00       	call   80103110 <mpinit>
80102f0e:	66 90                	xchg   %ax,%ax
  lapicinit();     // interrupt controller
80102f10:	e8 ab f7 ff ff       	call   801026c0 <lapicinit>
  seginit();       // segment descriptors
80102f15:	e8 56 4f 00 00       	call   80107e70 <seginit>
  picinit();       // disable pic
80102f1a:	e8 c1 03 00 00       	call   801032e0 <picinit>
80102f1f:	90                   	nop
  ioapicinit();    // another interrupt controller
80102f20:	e8 7b f3 ff ff       	call   801022a0 <ioapicinit>
  consoleinit();   // console hardware
80102f25:	e8 36 da ff ff       	call   80100960 <consoleinit>
  uartinit();      // serial port
80102f2a:	e8 11 42 00 00       	call   80107140 <uartinit>
80102f2f:	90                   	nop
  pinit();         // process table
80102f30:	e8 6b 09 00 00       	call   801038a0 <pinit>
  tvinit();        // trap vectors
80102f35:	e8 16 3e 00 00       	call   80106d50 <tvinit>
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
80102f63:	e8 d8 2b 00 00       	call   80105b40 <memmove>

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
8010300e:	e8 4d 1c 00 00       	call   80104c60 <initSchedDS>
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
80103053:	e8 38 0a 00 00       	call   80103a90 <userinit>
}

static void
mpmainPioneer(void) //called by the "pioneer" cpu
{
  cprintf("\"pioneer\" cpu%d: starting %d\n", cpuid(), cpuid());
80103058:	e8 e3 08 00 00       	call   80103940 <cpuid>
8010305d:	89 c3                	mov    %eax,%ebx
8010305f:	e8 dc 08 00 00       	call   80103940 <cpuid>
80103064:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80103068:	c7 04 24 8a 8b 10 80 	movl   $0x80108b8a,(%esp)
8010306f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103073:	e8 c8 d5 ff ff       	call   80100640 <cprintf>
  idtinit();       // load idt register
80103078:	e8 73 3d 00 00       	call   80106df0 <idtinit>
  scheduler();     // start running processes
8010307d:	e8 5e 0d 00 00       	call   80103de0 <scheduler>
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
801030be:	ba a8 8b 10 80       	mov    $0x80108ba8,%edx
801030c3:	89 44 24 08          	mov    %eax,0x8(%esp)
801030c7:	89 54 24 04          	mov    %edx,0x4(%esp)
801030cb:	89 34 24             	mov    %esi,(%esp)
801030ce:	e8 0d 2a 00 00       	call   80105ae0 <memcmp>
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
80103174:	ba ad 8b 10 80       	mov    $0x80108bad,%edx
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
8010318a:	e8 51 29 00 00       	call   80105ae0 <memcmp>
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
8010320f:	ff 24 85 ec 8b 10 80 	jmp    *-0x7fef7414(,%eax,4)
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
801032b3:	c7 04 24 b2 8b 10 80 	movl   $0x80108bb2,(%esp)
801032ba:	e8 81 d0 ff ff       	call   80100340 <panic>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
801032bf:	c7 04 24 cc 8b 10 80 	movl   $0x80108bcc,(%esp)
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
80103368:	b8 00 8c 10 80       	mov    $0x80108c00,%eax
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
80103380:	e8 ab 24 00 00       	call   80105830 <initlock>
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
80103425:	e8 66 25 00 00       	call   80105990 <acquire>
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
8010343f:	e8 dc 10 00 00       	call   80104520 <wakeup>
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
80103464:	e9 c7 25 00 00       	jmp    80105a30 <release>
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
80103481:	e8 9a 10 00 00       	call   80104520 <wakeup>
80103486:	eb bc                	jmp    80103444 <pipeclose+0x34>
80103488:	90                   	nop
80103489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103490:	89 1c 24             	mov    %ebx,(%esp)
80103493:	e8 98 25 00 00       	call   80105a30 <release>
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
801034bf:	e8 cc 24 00 00       	call   80105990 <acquire>
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
8010350f:	e8 0c 10 00 00       	call   80104520 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103514:	89 7c 24 04          	mov    %edi,0x4(%esp)
80103518:	89 1c 24             	mov    %ebx,(%esp)
8010351b:	e8 00 0e 00 00       	call   80104320 <sleep>
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
80103543:	e8 e8 24 00 00       	call   80105a30 <release>
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
80103590:	e8 8b 0f 00 00       	call   80104520 <wakeup>
  release(&p->lock);
80103595:	89 3c 24             	mov    %edi,(%esp)
80103598:	e8 93 24 00 00       	call   80105a30 <release>
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
801035c2:	e8 c9 23 00 00       	call   80105990 <acquire>
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
801035f7:	e8 24 0d 00 00       	call   80104320 <sleep>
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
80103627:	e8 04 24 00 00       	call   80105a30 <release>
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
8010368b:	e8 90 0e 00 00       	call   80104520 <wakeup>
  release(&p->lock);
80103690:	89 1c 24             	mov    %ebx,(%esp)
80103693:	e8 98 23 00 00       	call   80105a30 <release>
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
801036d3:	e8 b8 22 00 00       	call   80105990 <acquire>
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
80103718:	e8 13 23 00 00       	call   80105a30 <release>

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
80103737:	ba 3f 6d 10 80       	mov    $0x80106d3f,%edx

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
80103754:	e8 27 23 00 00       	call   80105a80 <memset>
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
80103777:	e8 b4 22 00 00       	call   80105a30 <release>
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
8010379d:	e8 8e 22 00 00       	call   80105a30 <release>

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

801038a0 <pinit>:



void
pinit(void)
{
801038a0:	55                   	push   %ebp
    initlock(&ptable.lock, "ptable");
801038a1:	b8 05 8c 10 80       	mov    $0x80108c05,%eax



void
pinit(void)
{
801038a6:	89 e5                	mov    %esp,%ebp
801038a8:	83 ec 18             	sub    $0x18,%esp
    initlock(&ptable.lock, "ptable");
801038ab:	89 44 24 04          	mov    %eax,0x4(%esp)
801038af:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801038b6:	e8 75 1f 00 00       	call   80105830 <initlock>
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
8010391b:	c7 04 24 0c 8c 10 80 	movl   $0x80108c0c,(%esp)
80103922:	e8 19 ca ff ff       	call   80100340 <panic>
mycpu(void)
{
    int apicid, i;

    if(readeflags()&FL_IF)
        panic("mycpu called with interrupts enabled\n");
80103927:	c7 04 24 00 8d 10 80 	movl   $0x80108d00,(%esp)
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
80103967:	e8 34 1f 00 00       	call   801058a0 <pushcli>
    c = mycpu();
8010396c:	e8 4f ff ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80103971:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80103977:	e8 64 1f 00 00       	call   801058e0 <popcli>
    return p;
}
8010397c:	5a                   	pop    %edx
8010397d:	89 d8                	mov    %ebx,%eax
8010397f:	5b                   	pop    %ebx
80103980:	5d                   	pop    %ebp
80103981:	c3                   	ret    
80103982:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103990 <updateAccumulator>:

void
updateAccumulator (struct proc* p){
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	83 ec 08             	sub    $0x8,%esp
    //check if this is the only procces
    if(pq.isEmpty()&&rpholder.isEmpty()) //if the only process -> acc=0
80103996:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
8010399c:	85 c0                	test   %eax,%eax
8010399e:	74 0a                	je     801039aa <updateAccumulator+0x1a>
801039a0:	ff 15 c4 c5 10 80    	call   *0x8010c5c4
801039a6:	85 c0                	test   %eax,%eax
801039a8:	75 26                	jne    801039d0 <updateAccumulator+0x40>
801039aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        p->accumulator=0;
    else //there are more than 1 procces -> change acc value to min
        p->accumulator=getMinAccumulator();
801039b0:	e8 4b fe ff ff       	call   80103800 <getMinAccumulator>
801039b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
801039b8:	89 81 80 00 00 00    	mov    %eax,0x80(%ecx)
801039be:	89 91 84 00 00 00    	mov    %edx,0x84(%ecx)
}
801039c4:	c9                   	leave  
801039c5:	c3                   	ret    
801039c6:	8d 76 00             	lea    0x0(%esi),%esi
801039c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

void
updateAccumulator (struct proc* p){
    //check if this is the only procces
    if(pq.isEmpty()&&rpholder.isEmpty()) //if the only process -> acc=0
        p->accumulator=0;
801039d0:	8b 45 08             	mov    0x8(%ebp),%eax
801039d3:	31 d2                	xor    %edx,%edx
801039d5:	31 c9                	xor    %ecx,%ecx
801039d7:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
801039dd:	89 88 84 00 00 00    	mov    %ecx,0x84(%eax)
    else //there are more than 1 procces -> change acc value to min
        p->accumulator=getMinAccumulator();
}
801039e3:	c9                   	leave  
801039e4:	c3                   	ret    
801039e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801039f0 <pushToSpecificQueue>:

void
pushToSpecificQueue(struct proc* p) {
    switch (currpolicy) {
801039f0:	a1 04 c0 10 80       	mov    0x8010c004,%eax
    else //there are more than 1 procces -> change acc value to min
        p->accumulator=getMinAccumulator();
}

void
pushToSpecificQueue(struct proc* p) {
801039f5:	55                   	push   %ebp
801039f6:	89 e5                	mov    %esp,%ebp
801039f8:	8b 55 08             	mov    0x8(%ebp),%edx
    switch (currpolicy) {
801039fb:	83 f8 02             	cmp    $0x2,%eax
801039fe:	74 10                	je     80103a10 <pushToSpecificQueue+0x20>
80103a00:	83 f8 03             	cmp    $0x3,%eax
80103a03:	74 0b                	je     80103a10 <pushToSpecificQueue+0x20>
80103a05:	48                   	dec    %eax
80103a06:	74 18                	je     80103a20 <pushToSpecificQueue+0x30>
            pq.put(p);
            break;
        default:
            break;
    }
}
80103a08:	5d                   	pop    %ebp
80103a09:	c3                   	ret    
80103a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            //myproc()->accumulator += myproc()->priority;
            pq.put(p);
            break;
        case 3:    //priority queue addition
            //myproc()->accumulator += myproc()->priority;
            pq.put(p);
80103a10:	89 55 08             	mov    %edx,0x8(%ebp)
            break;
        default:
            break;
    }
}
80103a13:	5d                   	pop    %ebp
            //myproc()->accumulator += myproc()->priority;
            pq.put(p);
            break;
        case 3:    //priority queue addition
            //myproc()->accumulator += myproc()->priority;
            pq.put(p);
80103a14:	ff 25 e8 c5 10 80    	jmp    *0x8010c5e8
80103a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            break;
        default:
            break;
    }
}
80103a20:	5d                   	pop    %ebp

void
pushToSpecificQueue(struct proc* p) {
    switch (currpolicy) {
        case 1://roundrobin addition
            rrq.enqueue(p);
80103a21:	ff 25 d8 c5 10 80    	jmp    *0x8010c5d8
80103a27:	89 f6                	mov    %esi,%esi
80103a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a30 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	56                   	push   %esi
80103a34:	89 c6                	mov    %eax,%esi
80103a36:	53                   	push   %ebx
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a37:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80103a3c:	83 ec 10             	sub    $0x10,%esp
80103a3f:	eb 15                	jmp    80103a56 <wakeup1+0x26>
80103a41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a48:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80103a4e:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80103a54:	74 32                	je     80103a88 <wakeup1+0x58>
        if(p->state == SLEEPING && p->chan == chan){
80103a56:	8b 53 0c             	mov    0xc(%ebx),%edx
80103a59:	83 fa 02             	cmp    $0x2,%edx
80103a5c:	75 ea                	jne    80103a48 <wakeup1+0x18>
80103a5e:	39 73 20             	cmp    %esi,0x20(%ebx)
80103a61:	75 e5                	jne    80103a48 <wakeup1+0x18>
            //rrq.enqueue(p);
            //TODO- priority queue addition
            //p->accumulator+=p->priority;
            //pq.put(p);
            //update the accumulator field
            updateAccumulator(p);
80103a63:	89 1c 24             	mov    %ebx,(%esp)
{
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
        if(p->state == SLEEPING && p->chan == chan){
            p->state = RUNNABLE;
80103a66:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
            //rrq.enqueue(p);
            //TODO- priority queue addition
            //p->accumulator+=p->priority;
            //pq.put(p);
            //update the accumulator field
            updateAccumulator(p);
80103a6d:	e8 1e ff ff ff       	call   80103990 <updateAccumulator>
            pushToSpecificQueue(p);
80103a72:	89 1c 24             	mov    %ebx,(%esp)
static void
wakeup1(void *chan)
{
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a75:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
            //TODO- priority queue addition
            //p->accumulator+=p->priority;
            //pq.put(p);
            //update the accumulator field
            updateAccumulator(p);
            pushToSpecificQueue(p);
80103a7b:	e8 70 ff ff ff       	call   801039f0 <pushToSpecificQueue>
static void
wakeup1(void *chan)
{
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a80:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80103a86:	75 ce                	jne    80103a56 <wakeup1+0x26>
            //pq.put(p);
            //update the accumulator field
            updateAccumulator(p);
            pushToSpecificQueue(p);
        }
}
80103a88:	83 c4 10             	add    $0x10,%esp
80103a8b:	5b                   	pop    %ebx
80103a8c:	5e                   	pop    %esi
80103a8d:	5d                   	pop    %ebp
80103a8e:	c3                   	ret    
80103a8f:	90                   	nop

80103a90 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	53                   	push   %ebx
80103a94:	83 ec 14             	sub    $0x14,%esp
    struct proc *p;
    extern char _binary_initcode_start[], _binary_initcode_size[];

    p = allocproc();
80103a97:	e8 24 fc ff ff       	call   801036c0 <allocproc>
80103a9c:	89 c3                	mov    %eax,%ebx

    initproc = p;
80103a9e:	a3 c0 c5 10 80       	mov    %eax,0x8010c5c0
    if((p->pgdir = setupkvm()) == 0)
80103aa3:	e8 e8 48 00 00       	call   80108390 <setupkvm>
80103aa8:	85 c0                	test   %eax,%eax
80103aaa:	89 43 04             	mov    %eax,0x4(%ebx)
80103aad:	0f 84 38 01 00 00    	je     80103beb <userinit+0x15b>
        panic("userinit: out of memory?");
    inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103ab3:	b9 60 c4 10 80       	mov    $0x8010c460,%ecx
80103ab8:	ba 2c 00 00 00       	mov    $0x2c,%edx
80103abd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80103ac1:	89 54 24 08          	mov    %edx,0x8(%esp)
80103ac5:	89 04 24             	mov    %eax,(%esp)
80103ac8:	e8 c3 45 00 00       	call   80108090 <inituvm>
    p->sz = PGSIZE;
    memset(p->tf, 0, sizeof(*p->tf));
80103acd:	b8 4c 00 00 00       	mov    $0x4c,%eax

    initproc = p;
    if((p->pgdir = setupkvm()) == 0)
        panic("userinit: out of memory?");
    inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
    p->sz = PGSIZE;
80103ad2:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
    memset(p->tf, 0, sizeof(*p->tf));
80103ad8:	89 44 24 08          	mov    %eax,0x8(%esp)
80103adc:	31 c0                	xor    %eax,%eax
80103ade:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ae2:	8b 43 18             	mov    0x18(%ebx),%eax
80103ae5:	89 04 24             	mov    %eax,(%esp)
80103ae8:	e8 93 1f 00 00       	call   80105a80 <memset>
    p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103aed:	8b 43 18             	mov    0x18(%ebx),%eax
80103af0:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
    p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103af6:	8b 43 18             	mov    0x18(%ebx),%eax
80103af9:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
    p->tf->es = p->tf->ds;
80103aff:	8b 43 18             	mov    0x18(%ebx),%eax
80103b02:	8b 50 2c             	mov    0x2c(%eax),%edx
80103b05:	66 89 50 28          	mov    %dx,0x28(%eax)
    p->tf->ss = p->tf->ds;
80103b09:	8b 43 18             	mov    0x18(%ebx),%eax
80103b0c:	8b 50 2c             	mov    0x2c(%eax),%edx
80103b0f:	66 89 50 48          	mov    %dx,0x48(%eax)
    p->tf->eflags = FL_IF;
80103b13:	8b 43 18             	mov    0x18(%ebx),%eax
80103b16:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
    p->tf->esp = PGSIZE;
80103b1d:	8b 43 18             	mov    0x18(%ebx),%eax
80103b20:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
    p->tf->eip = 0;  // beginning of initcode.S
80103b27:	8b 43 18             	mov    0x18(%ebx),%eax
80103b2a:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

    safestrcpy(p->name, "initcode", sizeof(p->name));
80103b31:	b8 10 00 00 00       	mov    $0x10,%eax
80103b36:	89 44 24 08          	mov    %eax,0x8(%esp)
80103b3a:	b8 35 8c 10 80       	mov    $0x80108c35,%eax
80103b3f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b43:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b46:	89 04 24             	mov    %eax,(%esp)
80103b49:	e8 22 21 00 00       	call   80105c70 <safestrcpy>
    p->cwd = namei("/");
80103b4e:	c7 04 24 3e 8c 10 80 	movl   $0x80108c3e,(%esp)
80103b55:	e8 36 e4 ff ff       	call   80101f90 <namei>
80103b5a:	89 43 68             	mov    %eax,0x68(%ebx)

    // this assignment to p->state lets other cores
    // run this process. the acquire forces the above
    // writes to be visible, and the lock is also needed
    // because the assignment might not be atomic.
    acquire(&ptable.lock);
80103b5d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103b64:	e8 27 1e 00 00       	call   80105990 <acquire>

    p->state = RUNNABLE;
    //TODO- roundrobin addition
    //TODO- priority queue addition
    p->priority=5;
80103b69:	b8 05 00 00 00       	mov    $0x5,%eax
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
80103b6e:	31 d2                	xor    %edx,%edx
    acquire(&ptable.lock);

    p->state = RUNNABLE;
    //TODO- roundrobin addition
    //TODO- priority queue addition
    p->priority=5;
80103b70:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
80103b76:	31 c0                	xor    %eax,%eax
    p->accumulator=0;          //surely 0 because this is the first initialized process
80103b78:	31 c9                	xor    %ecx,%ecx
    // run this process. the acquire forces the above
    // writes to be visible, and the lock is also needed
    // because the assignment might not be atomic.
    acquire(&ptable.lock);

    p->state = RUNNABLE;
80103b7a:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
    //TODO- roundrobin addition
    //TODO- priority queue addition
    p->priority=5;
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
80103b81:	89 83 a0 00 00 00    	mov    %eax,0xa0(%ebx)
    p->accumulator=0;          //surely 0 because this is the first initialized process
80103b87:	31 c0                	xor    %eax,%eax
80103b89:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
    if(currpolicy==1)
80103b8f:	a1 04 c0 10 80       	mov    0x8010c004,%eax

    p->state = RUNNABLE;
    //TODO- roundrobin addition
    //TODO- priority queue addition
    p->priority=5;
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
80103b94:	89 93 a4 00 00 00    	mov    %edx,0xa4(%ebx)
    p->accumulator=0;          //surely 0 because this is the first initialized process
80103b9a:	89 8b 80 00 00 00    	mov    %ecx,0x80(%ebx)
    if(currpolicy==1)
80103ba0:	48                   	dec    %eax
80103ba1:	74 3d                	je     80103be0 <userinit+0x150>
        rrq.enqueue(p);
    if(currpolicy==2 || currpolicy==3)
80103ba3:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80103ba8:	83 f8 02             	cmp    $0x2,%eax
80103bab:	74 23                	je     80103bd0 <userinit+0x140>
80103bad:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80103bb2:	83 f8 03             	cmp    $0x3,%eax
80103bb5:	74 19                	je     80103bd0 <userinit+0x140>
        pq.put(p);

    release(&ptable.lock);
80103bb7:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103bbe:	e8 6d 1e 00 00       	call   80105a30 <release>
}
80103bc3:	83 c4 14             	add    $0x14,%esp
80103bc6:	5b                   	pop    %ebx
80103bc7:	5d                   	pop    %ebp
80103bc8:	c3                   	ret    
80103bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
    p->accumulator=0;          //surely 0 because this is the first initialized process
    if(currpolicy==1)
        rrq.enqueue(p);
    if(currpolicy==2 || currpolicy==3)
        pq.put(p);
80103bd0:	89 1c 24             	mov    %ebx,(%esp)
80103bd3:	ff 15 e8 c5 10 80    	call   *0x8010c5e8
80103bd9:	eb dc                	jmp    80103bb7 <userinit+0x127>
80103bdb:	90                   	nop
80103bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    //TODO- priority queue addition
    p->priority=5;
    p->RUNNABLE_wait_time=0;    //surely 0 because this is the first initialized process
    p->accumulator=0;          //surely 0 because this is the first initialized process
    if(currpolicy==1)
        rrq.enqueue(p);
80103be0:	89 1c 24             	mov    %ebx,(%esp)
80103be3:	ff 15 d8 c5 10 80    	call   *0x8010c5d8
80103be9:	eb b8                	jmp    80103ba3 <userinit+0x113>

    p = allocproc();

    initproc = p;
    if((p->pgdir = setupkvm()) == 0)
        panic("userinit: out of memory?");
80103beb:	c7 04 24 1c 8c 10 80 	movl   $0x80108c1c,(%esp)
80103bf2:	e8 49 c7 ff ff       	call   80100340 <panic>
80103bf7:	89 f6                	mov    %esi,%esi
80103bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c00 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103c00:	55                   	push   %ebp
80103c01:	89 e5                	mov    %esp,%ebp
80103c03:	56                   	push   %esi
80103c04:	53                   	push   %ebx
80103c05:	83 ec 10             	sub    $0x10,%esp
80103c08:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
80103c0b:	e8 90 1c 00 00       	call   801058a0 <pushcli>
    c = mycpu();
80103c10:	e8 ab fc ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80103c15:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80103c1b:	e8 c0 1c 00 00       	call   801058e0 <popcli>
{
    uint sz;
    struct proc *curproc = myproc();

    sz = curproc->sz;
    if(n > 0){
80103c20:	83 fe 00             	cmp    $0x0,%esi
growproc(int n)
{
    uint sz;
    struct proc *curproc = myproc();

    sz = curproc->sz;
80103c23:	8b 03                	mov    (%ebx),%eax
    if(n > 0){
80103c25:	7e 31                	jle    80103c58 <growproc+0x58>
        if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c27:	01 c6                	add    %eax,%esi
80103c29:	89 74 24 08          	mov    %esi,0x8(%esp)
80103c2d:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c31:	8b 43 04             	mov    0x4(%ebx),%eax
80103c34:	89 04 24             	mov    %eax,(%esp)
80103c37:	e8 a4 45 00 00       	call   801081e0 <allocuvm>
80103c3c:	85 c0                	test   %eax,%eax
80103c3e:	74 40                	je     80103c80 <growproc+0x80>
            return -1;
    } else if(n < 0){
        if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
            return -1;
    }
    curproc->sz = sz;
80103c40:	89 03                	mov    %eax,(%ebx)
    switchuvm(curproc);
80103c42:	89 1c 24             	mov    %ebx,(%esp)
80103c45:	e8 46 43 00 00       	call   80107f90 <switchuvm>
    return 0;
80103c4a:	31 c0                	xor    %eax,%eax
}
80103c4c:	83 c4 10             	add    $0x10,%esp
80103c4f:	5b                   	pop    %ebx
80103c50:	5e                   	pop    %esi
80103c51:	5d                   	pop    %ebp
80103c52:	c3                   	ret    
80103c53:	90                   	nop
80103c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    sz = curproc->sz;
    if(n > 0){
        if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
            return -1;
    } else if(n < 0){
80103c58:	74 e6                	je     80103c40 <growproc+0x40>
        if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103c5a:	01 c6                	add    %eax,%esi
80103c5c:	89 74 24 08          	mov    %esi,0x8(%esp)
80103c60:	89 44 24 04          	mov    %eax,0x4(%esp)
80103c64:	8b 43 04             	mov    0x4(%ebx),%eax
80103c67:	89 04 24             	mov    %eax,(%esp)
80103c6a:	e8 71 46 00 00       	call   801082e0 <deallocuvm>
80103c6f:	85 c0                	test   %eax,%eax
80103c71:	75 cd                	jne    80103c40 <growproc+0x40>
80103c73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    struct proc *curproc = myproc();

    sz = curproc->sz;
    if(n > 0){
        if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
            return -1;
80103c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c85:	eb c5                	jmp    80103c4c <growproc+0x4c>
80103c87:	89 f6                	mov    %esi,%esi
80103c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c90 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103c90:	55                   	push   %ebp
80103c91:	89 e5                	mov    %esp,%ebp
80103c93:	57                   	push   %edi
80103c94:	56                   	push   %esi
80103c95:	53                   	push   %ebx
80103c96:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
80103c99:	e8 02 1c 00 00       	call   801058a0 <pushcli>
    c = mycpu();
80103c9e:	e8 1d fc ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80103ca3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
80103ca9:	e8 32 1c 00 00       	call   801058e0 <popcli>
    int i, pid;
    struct proc *np;
    struct proc *curproc = myproc();

    // Allocate process.
    if((np = allocproc()) == 0){
80103cae:	e8 0d fa ff ff       	call   801036c0 <allocproc>
80103cb3:	85 c0                	test   %eax,%eax
80103cb5:	0f 84 f6 00 00 00    	je     80103db1 <fork+0x121>
80103cbb:	89 c7                	mov    %eax,%edi
        return -1;
    }

    // Copy process state from proc.
    if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103cbd:	8b 06                	mov    (%esi),%eax
80103cbf:	89 44 24 04          	mov    %eax,0x4(%esp)
80103cc3:	8b 46 04             	mov    0x4(%esi),%eax
80103cc6:	89 04 24             	mov    %eax,(%esp)
80103cc9:	e8 a2 47 00 00       	call   80108470 <copyuvm>
80103cce:	85 c0                	test   %eax,%eax
80103cd0:	89 47 04             	mov    %eax,0x4(%edi)
80103cd3:	0f 84 df 00 00 00    	je     80103db8 <fork+0x128>
        kfree(np->kstack);
        np->kstack = 0;
        np->state = UNUSED;
        return -1;
    }
    np->sz = curproc->sz;
80103cd9:	8b 06                	mov    (%esi),%eax
    np->parent = curproc;
80103cdb:	89 77 14             	mov    %esi,0x14(%edi)
    *np->tf = *curproc->tf;
80103cde:	8b 4f 18             	mov    0x18(%edi),%ecx
        kfree(np->kstack);
        np->kstack = 0;
        np->state = UNUSED;
        return -1;
    }
    np->sz = curproc->sz;
80103ce1:	89 07                	mov    %eax,(%edi)
    np->parent = curproc;
    *np->tf = *curproc->tf;
80103ce3:	31 c0                	xor    %eax,%eax
80103ce5:	8b 56 18             	mov    0x18(%esi),%edx
80103ce8:	8b 1c 02             	mov    (%edx,%eax,1),%ebx
80103ceb:	89 1c 01             	mov    %ebx,(%ecx,%eax,1)
80103cee:	83 c0 04             	add    $0x4,%eax
80103cf1:	83 f8 4c             	cmp    $0x4c,%eax
80103cf4:	72 f2                	jb     80103ce8 <fork+0x58>

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;
80103cf6:	8b 47 18             	mov    0x18(%edi),%eax

    for(i = 0; i < NOFILE; i++)
80103cf9:	31 db                	xor    %ebx,%ebx
    np->sz = curproc->sz;
    np->parent = curproc;
    *np->tf = *curproc->tf;

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;
80103cfb:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103d02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

    for(i = 0; i < NOFILE; i++)
        if(curproc->ofile[i])
80103d10:	8b 44 9e 28          	mov    0x28(%esi,%ebx,4),%eax
80103d14:	85 c0                	test   %eax,%eax
80103d16:	74 0c                	je     80103d24 <fork+0x94>
            np->ofile[i] = filedup(curproc->ofile[i]);
80103d18:	89 04 24             	mov    %eax,(%esp)
80103d1b:	e8 b0 d0 ff ff       	call   80100dd0 <filedup>
80103d20:	89 44 9f 28          	mov    %eax,0x28(%edi,%ebx,4)
    *np->tf = *curproc->tf;

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;

    for(i = 0; i < NOFILE; i++)
80103d24:	43                   	inc    %ebx
80103d25:	83 fb 10             	cmp    $0x10,%ebx
80103d28:	75 e6                	jne    80103d10 <fork+0x80>
        if(curproc->ofile[i])
            np->ofile[i] = filedup(curproc->ofile[i]);
    np->cwd = idup(curproc->cwd);
80103d2a:	8b 46 68             	mov    0x68(%esi),%eax

    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d2d:	83 c6 6c             	add    $0x6c,%esi
    np->tf->eax = 0;

    for(i = 0; i < NOFILE; i++)
        if(curproc->ofile[i])
            np->ofile[i] = filedup(curproc->ofile[i]);
    np->cwd = idup(curproc->cwd);
80103d30:	89 04 24             	mov    %eax,(%esp)
80103d33:	e8 88 d9 ff ff       	call   801016c0 <idup>
80103d38:	89 47 68             	mov    %eax,0x68(%edi)

    safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d3b:	b8 10 00 00 00       	mov    $0x10,%eax
80103d40:	89 44 24 08          	mov    %eax,0x8(%esp)
80103d44:	8d 47 6c             	lea    0x6c(%edi),%eax
80103d47:	89 74 24 04          	mov    %esi,0x4(%esp)
80103d4b:	89 04 24             	mov    %eax,(%esp)
80103d4e:	e8 1d 1f 00 00       	call   80105c70 <safestrcpy>

    pid = np->pid;
80103d53:	8b 5f 10             	mov    0x10(%edi),%ebx

    acquire(&ptable.lock);
80103d56:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103d5d:	e8 2e 1c 00 00       	call   80105990 <acquire>

    np->state = RUNNABLE;
    //TODO- roundrobin addition
    //rrq.enqueue(np);
    //TODO - priority addition
    np->priority=5;
80103d62:	ba 05 00 00 00       	mov    $0x5,%edx

    pid = np->pid;

    acquire(&ptable.lock);

    np->state = RUNNABLE;
80103d67:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
    //TODO- roundrobin addition
    //rrq.enqueue(np);
    //TODO - priority addition
    np->priority=5;
    np->RUNNABLE_wait_time=counter;
80103d6e:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax

    np->state = RUNNABLE;
    //TODO- roundrobin addition
    //rrq.enqueue(np);
    //TODO - priority addition
    np->priority=5;
80103d73:	89 97 88 00 00 00    	mov    %edx,0x88(%edi)
    np->RUNNABLE_wait_time=counter;
80103d79:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80103d7f:	89 87 a0 00 00 00    	mov    %eax,0xa0(%edi)
80103d85:	89 97 a4 00 00 00    	mov    %edx,0xa4(%edi)
    //update the accumulator value
    updateAccumulator(np);
80103d8b:	89 3c 24             	mov    %edi,(%esp)
80103d8e:	e8 fd fb ff ff       	call   80103990 <updateAccumulator>
    //add np (i.e currproc) to the priority queue
    //pq.put(np);
    pushToSpecificQueue(np);
80103d93:	89 3c 24             	mov    %edi,(%esp)
80103d96:	e8 55 fc ff ff       	call   801039f0 <pushToSpecificQueue>

    release(&ptable.lock);
80103d9b:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103da2:	e8 89 1c 00 00       	call   80105a30 <release>

    return pid;
80103da7:	89 d8                	mov    %ebx,%eax
}
80103da9:	83 c4 1c             	add    $0x1c,%esp
80103dac:	5b                   	pop    %ebx
80103dad:	5e                   	pop    %esi
80103dae:	5f                   	pop    %edi
80103daf:	5d                   	pop    %ebp
80103db0:	c3                   	ret    
    struct proc *np;
    struct proc *curproc = myproc();

    // Allocate process.
    if((np = allocproc()) == 0){
        return -1;
80103db1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103db6:	eb f1                	jmp    80103da9 <fork+0x119>
    }

    // Copy process state from proc.
    if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
        kfree(np->kstack);
80103db8:	8b 47 08             	mov    0x8(%edi),%eax
80103dbb:	89 04 24             	mov    %eax,(%esp)
80103dbe:	e8 cd e5 ff ff       	call   80102390 <kfree>
        np->kstack = 0;
        np->state = UNUSED;
        return -1;
80103dc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Copy process state from proc.
    if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
        kfree(np->kstack);
        np->kstack = 0;
80103dc8:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
        np->state = UNUSED;
80103dcf:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
        return -1;
80103dd6:	eb d1                	jmp    80103da9 <fork+0x119>
80103dd8:	90                   	nop
80103dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103de0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103de0:	55                   	push   %ebp
80103de1:	89 e5                	mov    %esp,%ebp
80103de3:	57                   	push   %edi
80103de4:	56                   	push   %esi
    struct proc *p;
    struct cpu *c = mycpu();
    struct proc *max_p=ptable.proc; //just a dummy initialized value to compiled
    c->proc = 0;
80103de5:	31 f6                	xor    %esi,%esi
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103de7:	53                   	push   %ebx
80103de8:	83 ec 2c             	sub    $0x2c,%esp
    struct proc *p;
    struct cpu *c = mycpu();
80103deb:	e8 d0 fa ff ff       	call   801038c0 <mycpu>
    struct proc *max_p=ptable.proc; //just a dummy initialized value to compiled
80103df0:	c7 45 e4 b4 4d 11 80 	movl   $0x80114db4,-0x1c(%ebp)
    c->proc = 0;
80103df7:	89 b0 ac 00 00 00    	mov    %esi,0xac(%eax)
//      via swtch back to the scheduler.
void
scheduler(void)
{
    struct proc *p;
    struct cpu *c = mycpu();
80103dfd:	89 c7                	mov    %eax,%edi
80103dff:	8d 70 04             	lea    0x4(%eax),%esi
80103e02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103e10:	fb                   	sti    

    for(;;){
        // Enable interrupts on this processor.
        sti();
        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
80103e11:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103e18:	e8 73 1b 00 00       	call   80105990 <acquire>

        counter++;
80103e1d:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80103e22:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80103e28:	83 c0 01             	add    $0x1,%eax
80103e2b:	83 d2 00             	adc    $0x0,%edx
80103e2e:	a3 b8 c5 10 80       	mov    %eax,0x8010c5b8
80103e33:	89 15 bc c5 10 80    	mov    %edx,0x8010c5bc

        //policies cases - depends on the global variable currpolicy
        switch (currpolicy) {
80103e39:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80103e3e:	83 f8 02             	cmp    $0x2,%eax
80103e41:	0f 84 a1 00 00 00    	je     80103ee8 <scheduler+0x108>
80103e47:	83 f8 03             	cmp    $0x3,%eax
80103e4a:	0f 84 30 01 00 00    	je     80103f80 <scheduler+0x1a0>
80103e50:	48                   	dec    %eax
80103e51:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
80103e56:	75 16                	jne    80103e6e <scheduler+0x8e>
80103e58:	e9 f3 00 00 00       	jmp    80103f50 <scheduler+0x170>
80103e5d:	8d 76 00             	lea    0x0(%esi),%esi
                }
                break;


            default: //default case is what we got with the xv6
                for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103e60:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80103e66:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80103e6c:	74 62                	je     80103ed0 <scheduler+0xf0>
                    if (p->state != RUNNABLE)
80103e6e:	8b 43 0c             	mov    0xc(%ebx),%eax
80103e71:	83 f8 03             	cmp    $0x3,%eax
80103e74:	75 ea                	jne    80103e60 <scheduler+0x80>
                        continue;

                    // Switch to chosen process.  It is the process's job
                    // to release ptable.lock and then reacquire it
                    // before jumping back to us.
                    c->proc = p;
80103e76:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
                    switchuvm(p);
80103e7c:	89 1c 24             	mov    %ebx,(%esp)
80103e7f:	e8 0c 41 00 00       	call   80107f90 <switchuvm>
                    p->state = RUNNING;
80103e84:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
                    //TODO - adittion to priority queue
                    rpholder.add(p);
80103e8b:	89 1c 24             	mov    %ebx,(%esp)
                }
                break;


            default: //default case is what we got with the xv6
                for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103e8e:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
                    // before jumping back to us.
                    c->proc = p;
                    switchuvm(p);
                    p->state = RUNNING;
                    //TODO - adittion to priority queue
                    rpholder.add(p);
80103e94:	ff 15 c8 c5 10 80    	call   *0x8010c5c8

                    swtch(&(c->scheduler), p->context);
80103e9a:	8b 83 74 ff ff ff    	mov    -0x8c(%ebx),%eax
80103ea0:	89 34 24             	mov    %esi,(%esp)
80103ea3:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ea7:	e8 1d 1e 00 00       	call   80105cc9 <swtch>
                    switchkvm();
80103eac:	e8 bf 40 00 00       	call   80107f70 <switchkvm>

                    // Process is done running for now.
                    // It should have changed its p->state before coming back.
                    c->proc = 0;
80103eb1:	31 c0                	xor    %eax,%eax
                }
                break;


            default: //default case is what we got with the xv6
                for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103eb3:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
                    swtch(&(c->scheduler), p->context);
                    switchkvm();

                    // Process is done running for now.
                    // It should have changed its p->state before coming back.
                    c->proc = 0;
80103eb9:	89 87 ac 00 00 00    	mov    %eax,0xac(%edi)
                }
                break;


            default: //default case is what we got with the xv6
                for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103ebf:	75 ad                	jne    80103e6e <scheduler+0x8e>
80103ec1:	eb 0d                	jmp    80103ed0 <scheduler+0xf0>
80103ec3:	90                   	nop
80103ec4:	90                   	nop
80103ec5:	90                   	nop
80103ec6:	90                   	nop
80103ec7:	90                   	nop
80103ec8:	90                   	nop
80103ec9:	90                   	nop
80103eca:	90                   	nop
80103ecb:	90                   	nop
80103ecc:	90                   	nop
80103ecd:	90                   	nop
80103ece:	90                   	nop
80103ecf:	90                   	nop
                    c->proc = 0;
                }
                break;

        }
        release(&ptable.lock);
80103ed0:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103ed7:	e8 54 1b 00 00       	call   80105a30 <release>
    }
80103edc:	e9 2f ff ff ff       	jmp    80103e10 <scheduler+0x30>
80103ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
                    }
                }
                break;

            case 2: //3.2 - priority scheduling
                if (!pq.isEmpty()) {
80103ee8:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80103eee:	85 c0                	test   %eax,%eax
80103ef0:	75 de                	jne    80103ed0 <scheduler+0xf0>
                    p = pq.extractMin();
80103ef2:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
                    if (p != null) {
80103ef8:	85 c0                	test   %eax,%eax
                }
                break;

            case 2: //3.2 - priority scheduling
                if (!pq.isEmpty()) {
                    p = pq.extractMin();
80103efa:	89 c3                	mov    %eax,%ebx
                    if (p != null) {
80103efc:	74 d2                	je     80103ed0 <scheduler+0xf0>
                        //cprintf("curr policy= %d,\n",currpolicy);

                        // Switch to chosen process.  It is the process's job
                        // to release ptable.lock and then reacquire it
                        // before jumping back to us.
                        c->proc = p;
80103efe:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
                        switchuvm(p);
80103f04:	89 1c 24             	mov    %ebx,(%esp)
80103f07:	e8 84 40 00 00       	call   80107f90 <switchuvm>
                        p->state = RUNNING;
80103f0c:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
                        switchuvm(p);
                        p->state = RUNNING;
                        //TODO - adittion to priority queue
                        //save the last time of running
                        p->RUNNABLE_wait_time=counter;
                        rpholder.add(p);
80103f13:	89 1c 24             	mov    %ebx,(%esp)
80103f16:	ff 15 c8 c5 10 80    	call   *0x8010c5c8


                        swtch(&(c->scheduler), p->context);
80103f1c:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f1f:	89 34 24             	mov    %esi,(%esp)
80103f22:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f26:	e8 9e 1d 00 00       	call   80105cc9 <swtch>
                        switchkvm();
80103f2b:	e8 40 40 00 00       	call   80107f70 <switchkvm>

                        // Process is done running for now.
                        // It should have changed its p->state before coming back.
                        c->proc = 0;
80103f30:	31 d2                	xor    %edx,%edx
80103f32:	89 97 ac 00 00 00    	mov    %edx,0xac(%edi)
                    c->proc = 0;
                }
                break;

        }
        release(&ptable.lock);
80103f38:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103f3f:	e8 ec 1a 00 00       	call   80105a30 <release>
80103f44:	e9 c7 fe ff ff       	jmp    80103e10 <scheduler+0x30>
80103f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        counter++;

        //policies cases - depends on the global variable currpolicy
        switch (currpolicy) {
            case 1: //round robin policy
                if (!rrq.isEmpty()) {
80103f50:	ff 15 d4 c5 10 80    	call   *0x8010c5d4
80103f56:	85 c0                	test   %eax,%eax
80103f58:	0f 85 72 ff ff ff    	jne    80103ed0 <scheduler+0xf0>
80103f5e:	66 90                	xchg   %ax,%ax
                    p = rrq.dequeue();
80103f60:	ff 15 dc c5 10 80    	call   *0x8010c5dc
                    if (p != null) {
80103f66:	85 c0                	test   %eax,%eax

        //policies cases - depends on the global variable currpolicy
        switch (currpolicy) {
            case 1: //round robin policy
                if (!rrq.isEmpty()) {
                    p = rrq.dequeue();
80103f68:	89 c3                	mov    %eax,%ebx
                    if (p != null) {
80103f6a:	75 92                	jne    80103efe <scheduler+0x11e>
                    c->proc = 0;
                }
                break;

        }
        release(&ptable.lock);
80103f6c:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80103f73:	e8 b8 1a 00 00       	call   80105a30 <release>
80103f78:	e9 93 fe ff ff       	jmp    80103e10 <scheduler+0x30>
80103f7d:	8d 76 00             	lea    0x0(%esi),%esi
                // TODO we must consider case where we want to add another int wating time
                // that counts time between running periods or just use the max total waiting time
                //of all process.

            case 3: //3.3 - priority scheduling
                if (!pq.isEmpty()) {
80103f80:	ff 15 e4 c5 10 80    	call   *0x8010c5e4
80103f86:	85 c0                	test   %eax,%eax
80103f88:	0f 85 42 ff ff ff    	jne    80103ed0 <scheduler+0xf0>
                    if( counter % 100 == 0)
80103f8e:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80103f93:	b9 64 00 00 00       	mov    $0x64,%ecx
80103f98:	31 db                	xor    %ebx,%ebx
80103f9a:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80103fa0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80103fa4:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80103fa8:	89 04 24             	mov    %eax,(%esp)
80103fab:	89 54 24 04          	mov    %edx,0x4(%esp)
80103faf:	e8 6c 16 00 00       	call   80105620 <__moddi3>
80103fb4:	09 c2                	or     %eax,%edx
80103fb6:	0f 85 b5 00 00 00    	jne    80104071 <scheduler+0x291>
                    {
                        //cprintf("counter= %d,\n",counter);
                        long long min = counter;
80103fbc:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
80103fc1:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80103fc7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
                        //find the process with max RUNNABLE waiting time
                        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103fca:	89 75 e0             	mov    %esi,-0x20(%ebp)
80103fcd:	89 7d e4             	mov    %edi,-0x1c(%ebp)
            case 3: //3.3 - priority scheduling
                if (!pq.isEmpty()) {
                    if( counter % 100 == 0)
                    {
                        //cprintf("counter= %d,\n",counter);
                        long long min = counter;
80103fd0:	89 d1                	mov    %edx,%ecx
80103fd2:	89 c2                	mov    %eax,%edx
                        //find the process with max RUNNABLE waiting time
                        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80103fd4:	89 df                	mov    %ebx,%edi
80103fd6:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80103fdb:	89 cb                	mov    %ecx,%ebx
80103fdd:	89 d1                	mov    %edx,%ecx
80103fdf:	eb 13                	jmp    80103ff4 <scheduler+0x214>
80103fe1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fe8:	05 a8 00 00 00       	add    $0xa8,%eax
80103fed:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
80103ff2:	74 30                	je     80104024 <scheduler+0x244>
                            if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
80103ff4:	8b 50 0c             	mov    0xc(%eax),%edx
80103ff7:	83 fa 03             	cmp    $0x3,%edx
80103ffa:	75 ec                	jne    80103fe8 <scheduler+0x208>
80103ffc:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104002:	8b b0 a0 00 00 00    	mov    0xa0(%eax),%esi
80104008:	39 da                	cmp    %ebx,%edx
8010400a:	7f dc                	jg     80103fe8 <scheduler+0x208>
8010400c:	7c 04                	jl     80104012 <scheduler+0x232>
8010400e:	39 ce                	cmp    %ecx,%esi
80104010:	73 d6                	jae    80103fe8 <scheduler+0x208>
80104012:	89 c7                	mov    %eax,%edi
                    if( counter % 100 == 0)
                    {
                        //cprintf("counter= %d,\n",counter);
                        long long min = counter;
                        //find the process with max RUNNABLE waiting time
                        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104014:	05 a8 00 00 00       	add    $0xa8,%eax
80104019:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
                            if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
8010401e:	89 f1                	mov    %esi,%ecx
80104020:	89 d3                	mov    %edx,%ebx
                    if( counter % 100 == 0)
                    {
                        //cprintf("counter= %d,\n",counter);
                        long long min = counter;
                        //find the process with max RUNNABLE waiting time
                        for (p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104022:	75 d0                	jne    80103ff4 <scheduler+0x214>
80104024:	89 fb                	mov    %edi,%ebx
80104026:	8b 75 e0             	mov    -0x20(%ebp),%esi
                            if ((p->state == RUNNABLE) && (p->RUNNABLE_wait_time < min)){
                                min = p->RUNNABLE_wait_time;
                                max_p = p;
                            }
                        }
                        pq.extractProc(max_p);
80104029:	89 1c 24             	mov    %ebx,(%esp)
8010402c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010402f:	ff 15 f8 c5 10 80    	call   *0x8010c5f8
80104035:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
                        p=max_p;
                    }
                    else {
                        p = pq.extractMin();
                    }
                    if (p != null) {
80104038:	85 db                	test   %ebx,%ebx
8010403a:	0f 84 90 fe ff ff    	je     80103ed0 <scheduler+0xf0>
                        //cprintf("curr policy= %d,\n",currpolicy);

                        // Switch to chosen process.  It is the process's job
                        // to release ptable.lock and then reacquire it
                        // before jumping back to us.
                        c->proc = p;
80104040:	89 9f ac 00 00 00    	mov    %ebx,0xac(%edi)
                        switchuvm(p);
80104046:	89 1c 24             	mov    %ebx,(%esp)
80104049:	e8 42 3f 00 00       	call   80107f90 <switchuvm>
                        p->state = RUNNING;
8010404e:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
                        //TODO - adittion to priority queue
                        //save the last time of running
                        p->RUNNABLE_wait_time=counter;
80104055:	a1 b8 c5 10 80       	mov    0x8010c5b8,%eax
8010405a:	8b 15 bc c5 10 80    	mov    0x8010c5bc,%edx
80104060:	89 83 a0 00 00 00    	mov    %eax,0xa0(%ebx)
80104066:	89 93 a4 00 00 00    	mov    %edx,0xa4(%ebx)
8010406c:	e9 a2 fe ff ff       	jmp    80103f13 <scheduler+0x133>
                        }
                        pq.extractProc(max_p);
                        p=max_p;
                    }
                    else {
                        p = pq.extractMin();
80104071:	ff 15 f0 c5 10 80    	call   *0x8010c5f0
80104077:	89 c3                	mov    %eax,%ebx
80104079:	eb bd                	jmp    80104038 <scheduler+0x258>
8010407b:	90                   	nop
8010407c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104080 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80104080:	55                   	push   %ebp
80104081:	89 e5                	mov    %esp,%ebp
80104083:	56                   	push   %esi
80104084:	53                   	push   %ebx
80104085:	83 ec 10             	sub    $0x10,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
80104088:	e8 13 18 00 00       	call   801058a0 <pushcli>
    c = mycpu();
8010408d:	e8 2e f8 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80104092:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80104098:	e8 43 18 00 00       	call   801058e0 <popcli>
sched(void)
{
    int intena;
    struct proc *p = myproc();

    if(!holding(&ptable.lock))
8010409d:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801040a4:	e8 a7 18 00 00       	call   80105950 <holding>
801040a9:	85 c0                	test   %eax,%eax
801040ab:	74 51                	je     801040fe <sched+0x7e>
        panic("sched ptable.lock");
    if(mycpu()->ncli != 1)
801040ad:	e8 0e f8 ff ff       	call   801038c0 <mycpu>
801040b2:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801040b9:	75 67                	jne    80104122 <sched+0xa2>
        panic("sched locks");
    if(p->state == RUNNING)
801040bb:	8b 43 0c             	mov    0xc(%ebx),%eax
801040be:	83 f8 04             	cmp    $0x4,%eax
801040c1:	74 53                	je     80104116 <sched+0x96>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801040c3:	9c                   	pushf  
801040c4:	58                   	pop    %eax
        panic("sched running");
    if(readeflags()&FL_IF)
801040c5:	f6 c4 02             	test   $0x2,%ah
801040c8:	75 40                	jne    8010410a <sched+0x8a>
        panic("sched interruptible");
    intena = mycpu()->intena;
801040ca:	e8 f1 f7 ff ff       	call   801038c0 <mycpu>
    swtch(&p->context, mycpu()->scheduler);
801040cf:	83 c3 1c             	add    $0x1c,%ebx
        panic("sched locks");
    if(p->state == RUNNING)
        panic("sched running");
    if(readeflags()&FL_IF)
        panic("sched interruptible");
    intena = mycpu()->intena;
801040d2:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
    swtch(&p->context, mycpu()->scheduler);
801040d8:	e8 e3 f7 ff ff       	call   801038c0 <mycpu>
801040dd:	8b 40 04             	mov    0x4(%eax),%eax
801040e0:	89 1c 24             	mov    %ebx,(%esp)
801040e3:	89 44 24 04          	mov    %eax,0x4(%esp)
801040e7:	e8 dd 1b 00 00       	call   80105cc9 <swtch>
    mycpu()->intena = intena;
801040ec:	e8 cf f7 ff ff       	call   801038c0 <mycpu>
801040f1:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801040f7:	83 c4 10             	add    $0x10,%esp
801040fa:	5b                   	pop    %ebx
801040fb:	5e                   	pop    %esi
801040fc:	5d                   	pop    %ebp
801040fd:	c3                   	ret    
{
    int intena;
    struct proc *p = myproc();

    if(!holding(&ptable.lock))
        panic("sched ptable.lock");
801040fe:	c7 04 24 40 8c 10 80 	movl   $0x80108c40,(%esp)
80104105:	e8 36 c2 ff ff       	call   80100340 <panic>
    if(mycpu()->ncli != 1)
        panic("sched locks");
    if(p->state == RUNNING)
        panic("sched running");
    if(readeflags()&FL_IF)
        panic("sched interruptible");
8010410a:	c7 04 24 6c 8c 10 80 	movl   $0x80108c6c,(%esp)
80104111:	e8 2a c2 ff ff       	call   80100340 <panic>
    if(!holding(&ptable.lock))
        panic("sched ptable.lock");
    if(mycpu()->ncli != 1)
        panic("sched locks");
    if(p->state == RUNNING)
        panic("sched running");
80104116:	c7 04 24 5e 8c 10 80 	movl   $0x80108c5e,(%esp)
8010411d:	e8 1e c2 ff ff       	call   80100340 <panic>
    struct proc *p = myproc();

    if(!holding(&ptable.lock))
        panic("sched ptable.lock");
    if(mycpu()->ncli != 1)
        panic("sched locks");
80104122:	c7 04 24 52 8c 10 80 	movl   $0x80108c52,(%esp)
80104129:	e8 12 c2 ff ff       	call   80100340 <panic>
8010412e:	66 90                	xchg   %ax,%ax

80104130 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(int status)
{
80104130:	55                   	push   %ebp
80104131:	89 e5                	mov    %esp,%ebp
80104133:	57                   	push   %edi
80104134:	56                   	push   %esi
80104135:	53                   	push   %ebx
80104136:	83 ec 1c             	sub    $0x1c,%esp
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
80104139:	e8 62 17 00 00       	call   801058a0 <pushcli>
    c = mycpu();
8010413e:	e8 7d f7 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80104143:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
80104149:	e8 92 17 00 00       	call   801058e0 <popcli>
    struct proc *p;
    int fd;

    //TODO - the addition
    //cprintf("**exit** status=  %d\t curproc->exit_status=  %d\n",status,curproc->exit_status);
    curproc->exit_status=status;
8010414e:	8b 45 08             	mov    0x8(%ebp),%eax

    if(curproc == initproc)
80104151:	39 35 c0 c5 10 80    	cmp    %esi,0x8010c5c0
80104157:	8d 5e 28             	lea    0x28(%esi),%ebx
    struct proc *p;
    int fd;

    //TODO - the addition
    //cprintf("**exit** status=  %d\t curproc->exit_status=  %d\n",status,curproc->exit_status);
    curproc->exit_status=status;
8010415a:	89 46 7c             	mov    %eax,0x7c(%esi)
8010415d:	8d 7e 68             	lea    0x68(%esi),%edi

    if(curproc == initproc)
80104160:	0f 84 b2 00 00 00    	je     80104218 <exit+0xe8>
80104166:	8d 76 00             	lea    0x0(%esi),%esi
80104169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        panic("init exiting");

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
        if(curproc->ofile[fd]){
80104170:	8b 03                	mov    (%ebx),%eax
80104172:	85 c0                	test   %eax,%eax
80104174:	74 0e                	je     80104184 <exit+0x54>
            fileclose(curproc->ofile[fd]);
80104176:	89 04 24             	mov    %eax,(%esp)
80104179:	e8 a2 cc ff ff       	call   80100e20 <fileclose>
            curproc->ofile[fd] = 0;
8010417e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104184:	83 c3 04             	add    $0x4,%ebx

    if(curproc == initproc)
        panic("init exiting");

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
80104187:	39 fb                	cmp    %edi,%ebx
80104189:	75 e5                	jne    80104170 <exit+0x40>
            fileclose(curproc->ofile[fd]);
            curproc->ofile[fd] = 0;
        }
    }

    begin_op();
8010418b:	e8 70 ea ff ff       	call   80102c00 <begin_op>
    iput(curproc->cwd);
80104190:	8b 46 68             	mov    0x68(%esi),%eax

    // Parent might be sleeping in wait().
    wakeup1(curproc->parent);

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104193:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
            curproc->ofile[fd] = 0;
        }
    }

    begin_op();
    iput(curproc->cwd);
80104198:	89 04 24             	mov    %eax,(%esp)
8010419b:	e8 80 d6 ff ff       	call   80101820 <iput>
    end_op();
801041a0:	e8 cb ea ff ff       	call   80102c70 <end_op>
    curproc->cwd = 0;
801041a5:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)

    acquire(&ptable.lock);
801041ac:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801041b3:	e8 d8 17 00 00       	call   80105990 <acquire>

    // Parent might be sleeping in wait().
    wakeup1(curproc->parent);
801041b8:	8b 46 14             	mov    0x14(%esi),%eax
801041bb:	e8 70 f8 ff ff       	call   80103a30 <wakeup1>
801041c0:	eb 14                	jmp    801041d6 <exit+0xa6>
801041c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041c8:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
801041ce:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
801041d4:	74 2a                	je     80104200 <exit+0xd0>
        if(p->parent == curproc){
801041d6:	39 73 14             	cmp    %esi,0x14(%ebx)
801041d9:	75 ed                	jne    801041c8 <exit+0x98>
            p->parent = initproc;
            if(p->state == ZOMBIE)
801041db:	8b 53 0c             	mov    0xc(%ebx),%edx
    wakeup1(curproc->parent);

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->parent == curproc){
            p->parent = initproc;
801041de:	a1 c0 c5 10 80       	mov    0x8010c5c0,%eax
            if(p->state == ZOMBIE)
801041e3:	83 fa 05             	cmp    $0x5,%edx
    wakeup1(curproc->parent);

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->parent == curproc){
            p->parent = initproc;
801041e6:	89 43 14             	mov    %eax,0x14(%ebx)
            if(p->state == ZOMBIE)
801041e9:	75 dd                	jne    801041c8 <exit+0x98>

    // Parent might be sleeping in wait().
    wakeup1(curproc->parent);

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041eb:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
        if(p->parent == curproc){
            p->parent = initproc;
            if(p->state == ZOMBIE)
                wakeup1(initproc);
801041f1:	e8 3a f8 ff ff       	call   80103a30 <wakeup1>

    // Parent might be sleeping in wait().
    wakeup1(curproc->parent);

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041f6:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
801041fc:	75 d8                	jne    801041d6 <exit+0xa6>
801041fe:	66 90                	xchg   %ax,%ax
        }
    }


    // Jump into the scheduler, never to return.
    curproc->state = ZOMBIE;
80104200:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
    sched();
80104207:	e8 74 fe ff ff       	call   80104080 <sched>
    panic("zombie exit");
8010420c:	c7 04 24 8d 8c 10 80 	movl   $0x80108c8d,(%esp)
80104213:	e8 28 c1 ff ff       	call   80100340 <panic>
    //TODO - the addition
    //cprintf("**exit** status=  %d\t curproc->exit_status=  %d\n",status,curproc->exit_status);
    curproc->exit_status=status;

    if(curproc == initproc)
        panic("init exiting");
80104218:	c7 04 24 80 8c 10 80 	movl   $0x80108c80,(%esp)
8010421f:	e8 1c c1 ff ff       	call   80100340 <panic>
80104224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010422a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104230 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80104230:	55                   	push   %ebp
80104231:	89 e5                	mov    %esp,%ebp
80104233:	56                   	push   %esi
80104234:	53                   	push   %ebx
80104235:	83 ec 10             	sub    $0x10,%esp
    acquire(&ptable.lock);  //DOC: yieldlock
80104238:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010423f:	e8 4c 17 00 00       	call   80105990 <acquire>
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
80104244:	e8 57 16 00 00       	call   801058a0 <pushcli>
    c = mycpu();
80104249:	e8 72 f6 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
8010424e:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80104254:	e8 87 16 00 00       	call   801058e0 <popcli>
// Give up the CPU for one scheduling round.
void
yield(void)
{
    acquire(&ptable.lock);  //DOC: yieldlock
    myproc()->state = RUNNABLE;
80104259:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
80104260:	e8 3b 16 00 00       	call   801058a0 <pushcli>
    c = mycpu();
80104265:	e8 56 f6 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
8010426a:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
80104270:	e8 6b 16 00 00       	call   801058e0 <popcli>
void
yield(void)
{
    acquire(&ptable.lock);  //DOC: yieldlock
    myproc()->state = RUNNABLE;
    myproc()->accumulator+=myproc()->priority;
80104275:	8b 9b 88 00 00 00    	mov    0x88(%ebx),%ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
8010427b:	e8 20 16 00 00       	call   801058a0 <pushcli>
    c = mycpu();
80104280:	e8 3b f6 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80104285:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
8010428b:	e8 50 16 00 00       	call   801058e0 <popcli>
void
yield(void)
{
    acquire(&ptable.lock);  //DOC: yieldlock
    myproc()->state = RUNNABLE;
    myproc()->accumulator+=myproc()->priority;
80104290:	89 d8                	mov    %ebx,%eax
80104292:	99                   	cltd   
80104293:	01 9e 80 00 00 00    	add    %ebx,0x80(%esi)
    //TODO - addition to round-robin scheduling
    rrq.enqueue(myproc());
80104299:	8b 1d d8 c5 10 80    	mov    0x8010c5d8,%ebx
void
yield(void)
{
    acquire(&ptable.lock);  //DOC: yieldlock
    myproc()->state = RUNNABLE;
    myproc()->accumulator+=myproc()->priority;
8010429f:	11 96 84 00 00 00    	adc    %edx,0x84(%esi)
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
801042a5:	e8 f6 15 00 00       	call   801058a0 <pushcli>
    c = mycpu();
801042aa:	e8 11 f6 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
801042af:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
801042b5:	e8 26 16 00 00       	call   801058e0 <popcli>
{
    acquire(&ptable.lock);  //DOC: yieldlock
    myproc()->state = RUNNABLE;
    myproc()->accumulator+=myproc()->priority;
    //TODO - addition to round-robin scheduling
    rrq.enqueue(myproc());
801042ba:	89 34 24             	mov    %esi,(%esp)
801042bd:	ff d3                	call   *%ebx
    //TODO- priority queue addition
    pq.put(myproc()); //add to runabble queue
801042bf:	8b 1d e8 c5 10 80    	mov    0x8010c5e8,%ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
801042c5:	e8 d6 15 00 00       	call   801058a0 <pushcli>
    c = mycpu();
801042ca:	e8 f1 f5 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
801042cf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
801042d5:	e8 06 16 00 00       	call   801058e0 <popcli>
    myproc()->state = RUNNABLE;
    myproc()->accumulator+=myproc()->priority;
    //TODO - addition to round-robin scheduling
    rrq.enqueue(myproc());
    //TODO- priority queue addition
    pq.put(myproc()); //add to runabble queue
801042da:	89 34 24             	mov    %esi,(%esp)
801042dd:	ff d3                	call   *%ebx
    rpholder.remove(myproc());//remove from running queue
801042df:	8b 1d cc c5 10 80    	mov    0x8010c5cc,%ebx
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
801042e5:	e8 b6 15 00 00       	call   801058a0 <pushcli>
    c = mycpu();
801042ea:	e8 d1 f5 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
801042ef:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
801042f5:	e8 e6 15 00 00       	call   801058e0 <popcli>
    myproc()->accumulator+=myproc()->priority;
    //TODO - addition to round-robin scheduling
    rrq.enqueue(myproc());
    //TODO- priority queue addition
    pq.put(myproc()); //add to runabble queue
    rpholder.remove(myproc());//remove from running queue
801042fa:	89 34 24             	mov    %esi,(%esp)
801042fd:	ff d3                	call   *%ebx

    sched();
801042ff:	e8 7c fd ff ff       	call   80104080 <sched>
    release(&ptable.lock);
80104304:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010430b:	e8 20 17 00 00       	call   80105a30 <release>
}
80104310:	83 c4 10             	add    $0x10,%esp
80104313:	5b                   	pop    %ebx
80104314:	5e                   	pop    %esi
80104315:	5d                   	pop    %ebp
80104316:	c3                   	ret    
80104317:	89 f6                	mov    %esi,%esi
80104319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104320 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	83 ec 28             	sub    $0x28,%esp
80104326:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104329:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010432c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010432f:	8b 75 08             	mov    0x8(%ebp),%esi
80104332:	89 7d fc             	mov    %edi,-0x4(%ebp)
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
80104335:	e8 66 15 00 00       	call   801058a0 <pushcli>
    c = mycpu();
8010433a:	e8 81 f5 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
8010433f:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
    popcli();
80104345:	e8 96 15 00 00       	call   801058e0 <popcli>
void
sleep(void *chan, struct spinlock *lk)
{
    struct proc *p = myproc();

    if(p == 0)
8010434a:	85 ff                	test   %edi,%edi
8010434c:	0f 84 ad 00 00 00    	je     801043ff <sleep+0xdf>
        panic("sleep");

    if(lk == 0)
80104352:	85 db                	test   %ebx,%ebx
80104354:	0f 84 99 00 00 00    	je     801043f3 <sleep+0xd3>
        panic("sleep without lk");

    //TODO - addition to priority queue
    p->accumulator+=p->priority;  // add the priority to the acc
8010435a:	8b 87 88 00 00 00    	mov    0x88(%edi),%eax
80104360:	99                   	cltd   
80104361:	01 87 80 00 00 00    	add    %eax,0x80(%edi)
80104367:	11 97 84 00 00 00    	adc    %edx,0x84(%edi)
    rpholder.remove(p); //remove p from RUNNING queue
8010436d:	89 3c 24             	mov    %edi,(%esp)
80104370:	ff 15 cc c5 10 80    	call   *0x8010c5cc
    // change p->state and then call sched.
    // Once we hold ptable.lock, we can be
    // guaranteed that we won't miss any wakeup
    // (wakeup runs with ptable.lock locked),
    // so it's okay to release lk.
    if(lk != &ptable.lock){  //DOC: sleeplock0
80104376:	81 fb 80 4d 11 80    	cmp    $0x80114d80,%ebx
8010437c:	74 52                	je     801043d0 <sleep+0xb0>
        acquire(&ptable.lock);  //DOC: sleeplock1
8010437e:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104385:	e8 06 16 00 00       	call   80105990 <acquire>
        release(lk);
8010438a:	89 1c 24             	mov    %ebx,(%esp)
8010438d:	e8 9e 16 00 00       	call   80105a30 <release>
    }
    // Go to sleep.
    p->chan = chan;
80104392:	89 77 20             	mov    %esi,0x20(%edi)
    p->state = SLEEPING;
80104395:	c7 47 0c 02 00 00 00 	movl   $0x2,0xc(%edi)

    sched();
8010439c:	e8 df fc ff ff       	call   80104080 <sched>

    // Tidy up.
    p->chan = 0;
801043a1:	c7 47 20 00 00 00 00 	movl   $0x0,0x20(%edi)

    // Reacquire original lock.
    if(lk != &ptable.lock){  //DOC: sleeplock2
        release(&ptable.lock);
801043a8:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801043af:	e8 7c 16 00 00       	call   80105a30 <release>
        acquire(lk);
    }
}
801043b4:	8b 75 f8             	mov    -0x8(%ebp),%esi
    p->chan = 0;

    // Reacquire original lock.
    if(lk != &ptable.lock){  //DOC: sleeplock2
        release(&ptable.lock);
        acquire(lk);
801043b7:	89 5d 08             	mov    %ebx,0x8(%ebp)
    }
}
801043ba:	8b 7d fc             	mov    -0x4(%ebp),%edi
801043bd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801043c0:	89 ec                	mov    %ebp,%esp
801043c2:	5d                   	pop    %ebp
    p->chan = 0;

    // Reacquire original lock.
    if(lk != &ptable.lock){  //DOC: sleeplock2
        release(&ptable.lock);
        acquire(lk);
801043c3:	e9 c8 15 00 00       	jmp    80105990 <acquire>
801043c8:	90                   	nop
801043c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(lk != &ptable.lock){  //DOC: sleeplock0
        acquire(&ptable.lock);  //DOC: sleeplock1
        release(lk);
    }
    // Go to sleep.
    p->chan = chan;
801043d0:	89 77 20             	mov    %esi,0x20(%edi)
    p->state = SLEEPING;
801043d3:	c7 47 0c 02 00 00 00 	movl   $0x2,0xc(%edi)

    sched();
801043da:	e8 a1 fc ff ff       	call   80104080 <sched>

    // Tidy up.
    p->chan = 0;
801043df:	c7 47 20 00 00 00 00 	movl   $0x0,0x20(%edi)
    // Reacquire original lock.
    if(lk != &ptable.lock){  //DOC: sleeplock2
        release(&ptable.lock);
        acquire(lk);
    }
}
801043e6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801043e9:	8b 75 f8             	mov    -0x8(%ebp),%esi
801043ec:	8b 7d fc             	mov    -0x4(%ebp),%edi
801043ef:	89 ec                	mov    %ebp,%esp
801043f1:	5d                   	pop    %ebp
801043f2:	c3                   	ret    

    if(p == 0)
        panic("sleep");

    if(lk == 0)
        panic("sleep without lk");
801043f3:	c7 04 24 9f 8c 10 80 	movl   $0x80108c9f,(%esp)
801043fa:	e8 41 bf ff ff       	call   80100340 <panic>
sleep(void *chan, struct spinlock *lk)
{
    struct proc *p = myproc();

    if(p == 0)
        panic("sleep");
801043ff:	c7 04 24 99 8c 10 80 	movl   $0x80108c99,(%esp)
80104406:	e8 35 bf ff ff       	call   80100340 <panic>
8010440b:	90                   	nop
8010440c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104410 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(int *status)
{
80104410:	55                   	push   %ebp
80104411:	89 e5                	mov    %esp,%ebp
80104413:	57                   	push   %edi
80104414:	56                   	push   %esi
80104415:	53                   	push   %ebx
80104416:	83 ec 1c             	sub    $0x1c,%esp
80104419:	8b 7d 08             	mov    0x8(%ebp),%edi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
8010441c:	e8 7f 14 00 00       	call   801058a0 <pushcli>
    c = mycpu();
80104421:	e8 9a f4 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80104426:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
8010442c:	e8 af 14 00 00       	call   801058e0 <popcli>
{
    struct proc *p;
    int havekids, pid;
    struct proc *curproc = myproc();

    acquire(&ptable.lock);
80104431:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104438:	e8 53 15 00 00       	call   80105990 <acquire>
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
8010443d:	31 c0                	xor    %eax,%eax
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010443f:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
80104444:	eb 18                	jmp    8010445e <wait+0x4e>
80104446:	8d 76 00             	lea    0x0(%esi),%esi
80104449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104450:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
80104456:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
8010445c:	74 22                	je     80104480 <wait+0x70>
            if(p->parent != curproc)
8010445e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104461:	75 ed                	jne    80104450 <wait+0x40>
                continue;
            havekids = 1;
            if(p->state == ZOMBIE){
80104463:	8b 43 0c             	mov    0xc(%ebx),%eax
80104466:	83 f8 05             	cmp    $0x5,%eax
80104469:	74 33                	je     8010449e <wait+0x8e>

    acquire(&ptable.lock);
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010446b:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
            if(p->parent != curproc)
                continue;
            havekids = 1;
80104471:	b8 01 00 00 00       	mov    $0x1,%eax

    acquire(&ptable.lock);
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104476:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
8010447c:	75 e0                	jne    8010445e <wait+0x4e>
8010447e:	66 90                	xchg   %ax,%ax
                return pid;
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
80104480:	85 c0                	test   %eax,%eax
80104482:	74 79                	je     801044fd <wait+0xed>
80104484:	8b 56 24             	mov    0x24(%esi),%edx
80104487:	85 d2                	test   %edx,%edx
80104489:	75 72                	jne    801044fd <wait+0xed>
            release(&ptable.lock);
            return -1;
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010448b:	b8 80 4d 11 80       	mov    $0x80114d80,%eax
80104490:	89 44 24 04          	mov    %eax,0x4(%esp)
80104494:	89 34 24             	mov    %esi,(%esp)
80104497:	e8 84 fe ff ff       	call   80104320 <sleep>
    }
8010449c:	eb 9f                	jmp    8010443d <wait+0x2d>
                continue;
            havekids = 1;
            if(p->state == ZOMBIE){
                // Found one.
                pid = p->pid;
                kfree(p->kstack);
8010449e:	8b 43 08             	mov    0x8(%ebx),%eax
            if(p->parent != curproc)
                continue;
            havekids = 1;
            if(p->state == ZOMBIE){
                // Found one.
                pid = p->pid;
801044a1:	8b 73 10             	mov    0x10(%ebx),%esi
                kfree(p->kstack);
801044a4:	89 04 24             	mov    %eax,(%esp)
801044a7:	e8 e4 de ff ff       	call   80102390 <kfree>
                p->kstack = 0;
                freevm(p->pgdir);
801044ac:	8b 43 04             	mov    0x4(%ebx),%eax
            havekids = 1;
            if(p->state == ZOMBIE){
                // Found one.
                pid = p->pid;
                kfree(p->kstack);
                p->kstack = 0;
801044af:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
                freevm(p->pgdir);
801044b6:	89 04 24             	mov    %eax,(%esp)
801044b9:	e8 52 3e 00 00       	call   80108310 <freevm>
                p->parent = 0;
                p->name[0] = 0;
                p->killed = 0;
                p->state = UNUSED;
                //TODO - maybe need to use argptr
                if(status!=null)
801044be:	85 ff                	test   %edi,%edi
                // Found one.
                pid = p->pid;
                kfree(p->kstack);
                p->kstack = 0;
                freevm(p->pgdir);
                p->pid = 0;
801044c0:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
                p->parent = 0;
801044c7:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
                p->name[0] = 0;
801044ce:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
                p->killed = 0;
801044d2:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
                p->state = UNUSED;
801044d9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
                //TODO - maybe need to use argptr
                if(status!=null)
801044e0:	74 05                	je     801044e7 <wait+0xd7>
                    *status = (p->exit_status);
801044e2:	8b 43 7c             	mov    0x7c(%ebx),%eax
801044e5:	89 07                	mov    %eax,(%edi)
//        cprintf("**wait**  status= %d\t p.exit_status= %d\n",&status,p->exit_status);

                release(&ptable.lock);
801044e7:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801044ee:	e8 3d 15 00 00       	call   80105a30 <release>
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
801044f3:	83 c4 1c             	add    $0x1c,%esp
                if(status!=null)
                    *status = (p->exit_status);
//        cprintf("**wait**  status= %d\t p.exit_status= %d\n",&status,p->exit_status);

                release(&ptable.lock);
                return pid;
801044f6:	89 f0                	mov    %esi,%eax
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
801044f8:	5b                   	pop    %ebx
801044f9:	5e                   	pop    %esi
801044fa:	5f                   	pop    %edi
801044fb:	5d                   	pop    %ebp
801044fc:	c3                   	ret    
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
            release(&ptable.lock);
801044fd:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104504:	e8 27 15 00 00       	call   80105a30 <release>
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104509:	83 c4 1c             	add    $0x1c,%esp
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
            release(&ptable.lock);
            return -1;
8010450c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104511:	5b                   	pop    %ebx
80104512:	5e                   	pop    %esi
80104513:	5f                   	pop    %edi
80104514:	5d                   	pop    %ebp
80104515:	c3                   	ret    
80104516:	8d 76 00             	lea    0x0(%esi),%esi
80104519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104520 <wakeup>:
}

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
8010452a:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104531:	e8 5a 14 00 00       	call   80105990 <acquire>
    wakeup1(chan);
80104536:	89 d8                	mov    %ebx,%eax
80104538:	e8 f3 f4 ff ff       	call   80103a30 <wakeup1>
    release(&ptable.lock);
8010453d:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
}
80104544:	83 c4 14             	add    $0x14,%esp
80104547:	5b                   	pop    %ebx
80104548:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
    acquire(&ptable.lock);
    wakeup1(chan);
    release(&ptable.lock);
80104549:	e9 e2 14 00 00       	jmp    80105a30 <release>
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
80104557:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
8010455e:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct proc *p;

    acquire(&ptable.lock);
80104561:	e8 2a 14 00 00       	call   80105990 <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104566:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
8010456b:	eb 0f                	jmp    8010457c <kill+0x2c>
8010456d:	8d 76 00             	lea    0x0(%esi),%esi
80104570:	05 a8 00 00 00       	add    $0xa8,%eax
80104575:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010457a:	74 2c                	je     801045a8 <kill+0x58>
        if(p->pid == pid){
8010457c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010457f:	75 ef                	jne    80104570 <kill+0x20>
            p->killed = 1;
            // Wake process from sleep if necessary.
            if(p->state == SLEEPING){
80104581:	8b 50 0c             	mov    0xc(%eax),%edx
    struct proc *p;

    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->pid == pid){
            p->killed = 1;
80104584:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
            // Wake process from sleep if necessary.
            if(p->state == SLEEPING){
8010458b:	83 fa 02             	cmp    $0x2,%edx
8010458e:	74 2f                	je     801045bf <kill+0x6f>
                //TODO- priority queue addition
                p->accumulator+=p->priority;
                //pq.put(p);
                pushToSpecificQueue(p);
            }
            release(&ptable.lock);
80104590:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104597:	e8 94 14 00 00       	call   80105a30 <release>
            return 0;
        }
    }
    release(&ptable.lock);
    return -1;
}
8010459c:	83 c4 14             	add    $0x14,%esp
                p->accumulator+=p->priority;
                //pq.put(p);
                pushToSpecificQueue(p);
            }
            release(&ptable.lock);
            return 0;
8010459f:	31 c0                	xor    %eax,%eax
        }
    }
    release(&ptable.lock);
    return -1;
}
801045a1:	5b                   	pop    %ebx
801045a2:	5d                   	pop    %ebp
801045a3:	c3                   	ret    
801045a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            }
            release(&ptable.lock);
            return 0;
        }
    }
    release(&ptable.lock);
801045a8:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801045af:	e8 7c 14 00 00       	call   80105a30 <release>
    return -1;
}
801045b4:	83 c4 14             	add    $0x14,%esp
            release(&ptable.lock);
            return 0;
        }
    }
    release(&ptable.lock);
    return -1;
801045b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801045bc:	5b                   	pop    %ebx
801045bd:	5d                   	pop    %ebp
801045be:	c3                   	ret    
            if(p->state == SLEEPING){
                p->state = RUNNABLE;
                //TODO- roundrobin addition
                //rrq.enqueue(p);
                //TODO- priority queue addition
                p->accumulator+=p->priority;
801045bf:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->pid == pid){
            p->killed = 1;
            // Wake process from sleep if necessary.
            if(p->state == SLEEPING){
                p->state = RUNNABLE;
801045c5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
                //TODO- roundrobin addition
                //rrq.enqueue(p);
                //TODO- priority queue addition
                p->accumulator+=p->priority;
801045cc:	89 cb                	mov    %ecx,%ebx
801045ce:	c1 fb 1f             	sar    $0x1f,%ebx
801045d1:	01 88 80 00 00 00    	add    %ecx,0x80(%eax)
801045d7:	11 98 84 00 00 00    	adc    %ebx,0x84(%eax)
                //pq.put(p);
                pushToSpecificQueue(p);
801045dd:	89 04 24             	mov    %eax,(%esp)
801045e0:	e8 0b f4 ff ff       	call   801039f0 <pushToSpecificQueue>
801045e5:	eb a9                	jmp    80104590 <kill+0x40>
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
801045f6:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801045fb:	83 ec 4c             	sub    $0x4c,%esp
801045fe:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104601:	eb 23                	jmp    80104626 <procdump+0x36>
80104603:	90                   	nop
80104604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(p->state == SLEEPING){
            getcallerpcs((uint*)p->context->ebp+2, pc);
            for(i=0; i<10 && pc[i] != 0; i++)
                cprintf(" %p", pc[i]);
        }
        cprintf("\n");
80104608:	c7 04 24 ed 8d 10 80 	movl   $0x80108ded,(%esp)
8010460f:	e8 2c c0 ff ff       	call   80100640 <cprintf>
    int i;
    struct proc *p;
    char *state;
    uint pc[10];

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104614:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
8010461a:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104620:	0f 84 aa 00 00 00    	je     801046d0 <procdump+0xe0>
        if(p->state == UNUSED)
80104626:	8b 43 0c             	mov    0xc(%ebx),%eax
80104629:	85 c0                	test   %eax,%eax
8010462b:	74 e7                	je     80104614 <procdump+0x24>
            continue;
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010462d:	8b 43 0c             	mov    0xc(%ebx),%eax
            state = states[p->state];
        else
            state = "???";
80104630:	b8 b0 8c 10 80       	mov    $0x80108cb0,%eax
    uint pc[10];

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state == UNUSED)
            continue;
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104635:	8b 53 0c             	mov    0xc(%ebx),%edx
80104638:	83 fa 05             	cmp    $0x5,%edx
8010463b:	77 18                	ja     80104655 <procdump+0x65>
8010463d:	8b 53 0c             	mov    0xc(%ebx),%edx
80104640:	8b 14 95 c4 8d 10 80 	mov    -0x7fef723c(,%edx,4),%edx
80104647:	85 d2                	test   %edx,%edx
80104649:	74 0a                	je     80104655 <procdump+0x65>
            state = states[p->state];
8010464b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010464e:	8b 04 85 c4 8d 10 80 	mov    -0x7fef723c(,%eax,4),%eax
        else
            state = "???";
        cprintf("%d %s %s", p->pid, state, p->name);
80104655:	89 44 24 08          	mov    %eax,0x8(%esp)
80104659:	8b 43 10             	mov    0x10(%ebx),%eax
8010465c:	8d 53 6c             	lea    0x6c(%ebx),%edx
8010465f:	89 54 24 0c          	mov    %edx,0xc(%esp)
80104663:	c7 04 24 b4 8c 10 80 	movl   $0x80108cb4,(%esp)
8010466a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010466e:	e8 cd bf ff ff       	call   80100640 <cprintf>
        if(p->state == SLEEPING){
80104673:	8b 43 0c             	mov    0xc(%ebx),%eax
80104676:	83 f8 02             	cmp    $0x2,%eax
80104679:	75 8d                	jne    80104608 <procdump+0x18>
            getcallerpcs((uint*)p->context->ebp+2, pc);
8010467b:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010467e:	89 44 24 04          	mov    %eax,0x4(%esp)
80104682:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104685:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104688:	8b 40 0c             	mov    0xc(%eax),%eax
8010468b:	83 c0 08             	add    $0x8,%eax
8010468e:	89 04 24             	mov    %eax,(%esp)
80104691:	e8 ba 11 00 00       	call   80105850 <getcallerpcs>
80104696:	8d 76 00             	lea    0x0(%esi),%esi
80104699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
            for(i=0; i<10 && pc[i] != 0; i++)
801046a0:	8b 17                	mov    (%edi),%edx
801046a2:	85 d2                	test   %edx,%edx
801046a4:	0f 84 5e ff ff ff    	je     80104608 <procdump+0x18>
                cprintf(" %p", pc[i]);
801046aa:	89 54 24 04          	mov    %edx,0x4(%esp)
801046ae:	83 c7 04             	add    $0x4,%edi
801046b1:	c7 04 24 a1 86 10 80 	movl   $0x801086a1,(%esp)
801046b8:	e8 83 bf ff ff       	call   80100640 <cprintf>
        else
            state = "???";
        cprintf("%d %s %s", p->pid, state, p->name);
        if(p->state == SLEEPING){
            getcallerpcs((uint*)p->context->ebp+2, pc);
            for(i=0; i<10 && pc[i] != 0; i++)
801046bd:	39 f7                	cmp    %esi,%edi
801046bf:	75 df                	jne    801046a0 <procdump+0xb0>
801046c1:	e9 42 ff ff ff       	jmp    80104608 <procdump+0x18>
801046c6:	8d 76 00             	lea    0x0(%esi),%esi
801046c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
                cprintf(" %p", pc[i]);
        }
        cprintf("\n");
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



int
detach(int pid)
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	56                   	push   %esi
801046e4:	53                   	push   %ebx
801046e5:	83 ec 10             	sub    $0x10,%esp
801046e8:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
801046eb:	e8 b0 11 00 00       	call   801058a0 <pushcli>
    c = mycpu();
801046f0:	e8 cb f1 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
801046f5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
801046fb:	e8 e0 11 00 00       	call   801058e0 <popcli>
detach(int pid)
{
    struct proc *p;
    struct proc *curproc = myproc();

    acquire(&ptable.lock);
80104700:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104707:	e8 84 12 00 00       	call   80105990 <acquire>
    // Scan through table looking for exited children with same pid as the argument.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010470c:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80104711:	eb 11                	jmp    80104724 <detach+0x44>
80104713:	90                   	nop
80104714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104718:	05 a8 00 00 00       	add    $0xa8,%eax
8010471d:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
80104722:	74 2c                	je     80104750 <detach+0x70>
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
8010472e:	8b 15 c0 c5 10 80    	mov    0x8010c5c0,%edx
80104734:	89 50 14             	mov    %edx,0x14(%eax)
            //release the ptable
            release(&ptable.lock);
80104737:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010473e:	e8 ed 12 00 00       	call   80105a30 <release>
        }
    }
    //if got here - didn't find proc with pid as argument - exit with error
    release(&ptable.lock);
    return -1;
}
80104743:	83 c4 10             	add    $0x10,%esp
        if (p->pid == pid) {
            //change the father of current proc
            p->parent = initproc;
            //release the ptable
            release(&ptable.lock);
            return 0;
80104746:	31 c0                	xor    %eax,%eax
        }
    }
    //if got here - didn't find proc with pid as argument - exit with error
    release(&ptable.lock);
    return -1;
}
80104748:	5b                   	pop    %ebx
80104749:	5e                   	pop    %esi
8010474a:	5d                   	pop    %ebp
8010474b:	c3                   	ret    
8010474c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            release(&ptable.lock);
            return 0;
        }
    }
    //if got here - didn't find proc with pid as argument - exit with error
    release(&ptable.lock);
80104750:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104757:	e8 d4 12 00 00       	call   80105a30 <release>
    return -1;
}
8010475c:	83 c4 10             	add    $0x10,%esp
            return 0;
        }
    }
    //if got here - didn't find proc with pid as argument - exit with error
    release(&ptable.lock);
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
80104773:	83 ec 18             	sub    $0x18,%esp
80104776:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104779:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010477c:	8b 75 08             	mov    0x8(%ebp),%esi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
8010477f:	e8 1c 11 00 00       	call   801058a0 <pushcli>
    c = mycpu();
80104784:	e8 37 f1 ff ff       	call   801038c0 <mycpu>
    p = c->proc;
80104789:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
    popcli();
8010478f:	e8 4c 11 00 00       	call   801058e0 <popcli>


void
priority(int prio){
    struct proc *curproc = myproc();
    if( curproc != null ) {
80104794:	85 db                	test   %ebx,%ebx
80104796:	74 68                	je     80104800 <priority+0x90>
        acquire(&ptable.lock);
80104798:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
8010479f:	e8 ec 11 00 00       	call   80105990 <acquire>

        if (currpolicy == 2) {
801047a4:	a1 04 c0 10 80       	mov    0x8010c004,%eax
801047a9:	83 f8 02             	cmp    $0x2,%eax
801047ac:	74 22                	je     801047d0 <priority+0x60>
            if (prio > 0 && prio < 11)
                curproc->priority = prio;
        }
        if (currpolicy == 3) {
801047ae:	a1 04 c0 10 80       	mov    0x8010c004,%eax
801047b3:	83 f8 03             	cmp    $0x3,%eax
801047b6:	74 38                	je     801047f0 <priority+0x80>
            if (prio >= 0 && prio < 11)
                curproc->priority = prio;
        }

        release(&ptable.lock);
801047b8:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)
    }
}
801047bf:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801047c2:	8b 75 fc             	mov    -0x4(%ebp),%esi
801047c5:	89 ec                	mov    %ebp,%esp
801047c7:	5d                   	pop    %ebp
        if (currpolicy == 3) {
            if (prio >= 0 && prio < 11)
                curproc->priority = prio;
        }

        release(&ptable.lock);
801047c8:	e9 63 12 00 00       	jmp    80105a30 <release>
801047cd:	8d 76 00             	lea    0x0(%esi),%esi
    struct proc *curproc = myproc();
    if( curproc != null ) {
        acquire(&ptable.lock);

        if (currpolicy == 2) {
            if (prio > 0 && prio < 11)
801047d0:	8d 46 ff             	lea    -0x1(%esi),%eax
801047d3:	83 f8 09             	cmp    $0x9,%eax
801047d6:	77 d6                	ja     801047ae <priority+0x3e>
                curproc->priority = prio;
        }
        if (currpolicy == 3) {
801047d8:	a1 04 c0 10 80       	mov    0x8010c004,%eax
    if( curproc != null ) {
        acquire(&ptable.lock);

        if (currpolicy == 2) {
            if (prio > 0 && prio < 11)
                curproc->priority = prio;
801047dd:	89 b3 88 00 00 00    	mov    %esi,0x88(%ebx)
        }
        if (currpolicy == 3) {
801047e3:	83 f8 03             	cmp    $0x3,%eax
801047e6:	75 d0                	jne    801047b8 <priority+0x48>
801047e8:	90                   	nop
801047e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            if (prio >= 0 && prio < 11)
801047f0:	83 fe 0a             	cmp    $0xa,%esi
801047f3:	77 c3                	ja     801047b8 <priority+0x48>
                curproc->priority = prio;
801047f5:	89 b3 88 00 00 00    	mov    %esi,0x88(%ebx)
801047fb:	eb bb                	jmp    801047b8 <priority+0x48>
801047fd:	8d 76 00             	lea    0x0(%esi),%esi
        }

        release(&ptable.lock);
    }
}
80104800:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104803:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104806:	89 ec                	mov    %ebp,%esp
80104808:	5d                   	pop    %ebp
80104809:	c3                   	ret    
8010480a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104810 <priorityUnExtended>:


void
priorityUnExtended(){
80104810:	55                   	push   %ebp
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104811:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
    }
}


void
priorityUnExtended(){
80104816:	89 e5                	mov    %esp,%ebp
80104818:	90                   	nop
80104819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        if (p->priority == 0)
80104820:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
80104826:	85 c9                	test   %ecx,%ecx
80104828:	75 0b                	jne    80104835 <priorityUnExtended+0x25>
            p->priority = 1;
8010482a:	ba 01 00 00 00       	mov    $0x1,%edx
8010482f:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)


void
priorityUnExtended(){
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104835:	05 a8 00 00 00       	add    $0xa8,%eax
8010483a:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010483f:	75 df                	jne    80104820 <priorityUnExtended+0x10>
        if (p->priority == 0)
            p->priority = 1;
    }
}
80104841:	5d                   	pop    %ebp
80104842:	c3                   	ret    
80104843:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104850 <switchToRoundRobin>:

void
switchToRoundRobin(void){
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	83 ec 18             	sub    $0x18,%esp
    struct proc *p;
    if(!pq.switchToRoundRobinPolicy())
80104856:	ff 15 f4 c5 10 80    	call   *0x8010c5f4
8010485c:	85 c0                	test   %eax,%eax
8010485e:	74 2b                	je     8010488b <switchToRoundRobin+0x3b>
80104860:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80104865:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
        panic("error in switch from policy 2/3 to policy 1\n");
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        p->accumulator=0;
80104870:	31 d2                	xor    %edx,%edx
80104872:	31 c9                	xor    %ecx,%ecx
80104874:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
void
switchToRoundRobin(void){
    struct proc *p;
    if(!pq.switchToRoundRobinPolicy())
        panic("error in switch from policy 2/3 to policy 1\n");
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
8010487a:	05 a8 00 00 00       	add    $0xa8,%eax
        p->accumulator=0;
8010487f:	89 48 dc             	mov    %ecx,-0x24(%eax)
void
switchToRoundRobin(void){
    struct proc *p;
    if(!pq.switchToRoundRobinPolicy())
        panic("error in switch from policy 2/3 to policy 1\n");
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104882:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
80104887:	75 e7                	jne    80104870 <switchToRoundRobin+0x20>
        p->accumulator=0;
    }
}
80104889:	c9                   	leave  
8010488a:	c3                   	ret    

void
switchToRoundRobin(void){
    struct proc *p;
    if(!pq.switchToRoundRobinPolicy())
        panic("error in switch from policy 2/3 to policy 1\n");
8010488b:	c7 04 24 28 8d 10 80 	movl   $0x80108d28,(%esp)
80104892:	e8 a9 ba ff ff       	call   80100340 <panic>
80104897:	89 f6                	mov    %esi,%esi
80104899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048a0 <policy>:
        p->accumulator=0;
    }
}

void
policy(int num){
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	53                   	push   %ebx
801048a4:	83 ec 14             	sub    $0x14,%esp
801048a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    //check legal input
    //TODO- need to check if there is a need to change to default or to panic
    if(num>3 || num<1)
801048aa:	8d 43 ff             	lea    -0x1(%ebx),%eax
801048ad:	83 f8 02             	cmp    $0x2,%eax
801048b0:	76 0e                	jbe    801048c0 <policy+0x20>
            panic("illegal policy number\n");
            break;
    }
    release(&ptable.lock);

}
801048b2:	83 c4 14             	add    $0x14,%esp
801048b5:	5b                   	pop    %ebx
801048b6:	5d                   	pop    %ebp
801048b7:	c3                   	ret    
801048b8:	90                   	nop
801048b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
801048c0:	fb                   	sti    
    if(num>3 || num<1)
        return; //currpolicy get the default policy
    // Enable interrupts on this processor.
    sti();
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
801048c1:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801048c8:	e8 c3 10 00 00       	call   80105990 <acquire>
    switch (currpolicy){
801048cd:	a1 04 c0 10 80       	mov    0x8010c004,%eax
801048d2:	83 f8 02             	cmp    $0x2,%eax
801048d5:	74 39                	je     80104910 <policy+0x70>
801048d7:	83 f8 03             	cmp    $0x3,%eax
801048da:	74 14                	je     801048f0 <policy+0x50>
801048dc:	48                   	dec    %eax
801048dd:	74 41                	je     80104920 <policy+0x80>
            if(num==2){
                priorityUnExtended();
            }
            break;
        default:
            panic("illegal policy number\n");
801048df:	c7 04 24 bd 8c 10 80 	movl   $0x80108cbd,(%esp)
801048e6:	e8 55 ba ff ff       	call   80100340 <panic>
801048eb:	90                   	nop
801048ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                switchToRoundRobin();
            }
            break;

        case 3:
            if(num==1){
801048f0:	83 fb 01             	cmp    $0x1,%ebx
801048f3:	74 1e                	je     80104913 <policy+0x73>
                switchToRoundRobin();
            }
            if(num==2){
801048f5:	83 fb 02             	cmp    $0x2,%ebx
801048f8:	74 6e                	je     80104968 <policy+0xc8>
            break;
        default:
            panic("illegal policy number\n");
            break;
    }
    release(&ptable.lock);
801048fa:	c7 45 08 80 4d 11 80 	movl   $0x80114d80,0x8(%ebp)

}
80104901:	83 c4 14             	add    $0x14,%esp
80104904:	5b                   	pop    %ebx
80104905:	5d                   	pop    %ebp
            break;
        default:
            panic("illegal policy number\n");
            break;
    }
    release(&ptable.lock);
80104906:	e9 25 11 00 00       	jmp    80105a30 <release>
8010490b:	90                   	nop
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                    priorityUnExtended();
            }
            break;

        case 2:
            if(num==1){
80104910:	4b                   	dec    %ebx
80104911:	75 e7                	jne    801048fa <policy+0x5a>
                switchToRoundRobin();
80104913:	e8 38 ff ff ff       	call   80104850 <switchToRoundRobin>
80104918:	eb e0                	jmp    801048fa <policy+0x5a>
8010491a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sti();
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    switch (currpolicy){
        case 1:
            if(num==2 || num==3){
80104920:	8d 43 fe             	lea    -0x2(%ebx),%eax
80104923:	83 f8 01             	cmp    $0x1,%eax
80104926:	77 d2                	ja     801048fa <policy+0x5a>
                rrq.switchToPriorityQueuePolicy();
80104928:	ff 15 e0 c5 10 80    	call   *0x8010c5e0
                //if(!rrq.switchToPriorityQueuePolicy())
                //    panic("error in switch from rouncrobin to priority queue\n");
                //if num=2 ->check that there are no priority=0
                if(num==2)
8010492e:	83 fb 02             	cmp    $0x2,%ebx
80104931:	75 c7                	jne    801048fa <policy+0x5a>
80104933:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
80104938:	90                   	nop
80104939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

void
priorityUnExtended(){
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
        if (p->priority == 0)
80104940:	8b 90 88 00 00 00    	mov    0x88(%eax),%edx
80104946:	85 d2                	test   %edx,%edx
80104948:	75 0b                	jne    80104955 <policy+0xb5>
            p->priority = 1;
8010494a:	bb 01 00 00 00       	mov    $0x1,%ebx
8010494f:	89 98 88 00 00 00    	mov    %ebx,0x88(%eax)


void
priorityUnExtended(){
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104955:	05 a8 00 00 00       	add    $0xa8,%eax
8010495a:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010495f:	75 df                	jne    80104940 <policy+0xa0>
80104961:	eb 97                	jmp    801048fa <policy+0x5a>
80104963:	90                   	nop
80104964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104968:	b8 b4 4d 11 80       	mov    $0x80114db4,%eax
8010496d:	8d 76 00             	lea    0x0(%esi),%esi
        if (p->priority == 0)
80104970:	8b 88 88 00 00 00    	mov    0x88(%eax),%ecx
80104976:	85 c9                	test   %ecx,%ecx
80104978:	75 0b                	jne    80104985 <policy+0xe5>
            p->priority = 1;
8010497a:	ba 01 00 00 00       	mov    $0x1,%edx
8010497f:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)


void
priorityUnExtended(){
    struct proc *p;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
80104985:	05 a8 00 00 00       	add    $0xa8,%eax
8010498a:	3d b4 77 11 80       	cmp    $0x801177b4,%eax
8010498f:	75 df                	jne    80104970 <policy+0xd0>
80104991:	e9 64 ff ff ff       	jmp    801048fa <policy+0x5a>
80104996:	8d 76 00             	lea    0x0(%esi),%esi
80104999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049a0 <wait_stat>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait_stat(int* status, struct perf* performance)
{
801049a0:	55                   	push   %ebp
801049a1:	89 e5                	mov    %esp,%ebp
801049a3:	57                   	push   %edi
801049a4:	56                   	push   %esi
801049a5:	53                   	push   %ebx
801049a6:	83 ec 2c             	sub    $0x2c,%esp
801049a9:	8b 7d 08             	mov    0x8(%ebp),%edi
// while reading proc from the cpu structure
struct proc*
myproc(void) {
    struct cpu *c;
    struct proc *p;
    pushcli();
801049ac:	e8 ef 0e 00 00       	call   801058a0 <pushcli>
    c = mycpu();
801049b1:	e8 0a ef ff ff       	call   801038c0 <mycpu>
    p = c->proc;
801049b6:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
    popcli();
801049bc:	e8 1f 0f 00 00       	call   801058e0 <popcli>
{
    struct proc *p;
    int havekids, pid;
    struct proc *curproc = myproc();

    acquire(&ptable.lock);
801049c1:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
801049c8:	e8 c3 0f 00 00       	call   80105990 <acquire>
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
801049cd:	31 c0                	xor    %eax,%eax
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049cf:	bb b4 4d 11 80       	mov    $0x80114db4,%ebx
801049d4:	eb 18                	jmp    801049ee <wait_stat+0x4e>
801049d6:	8d 76 00             	lea    0x0(%esi),%esi
801049d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801049e0:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
801049e6:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
801049ec:	74 22                	je     80104a10 <wait_stat+0x70>
            if(p->parent != curproc)
801049ee:	39 73 14             	cmp    %esi,0x14(%ebx)
801049f1:	75 ed                	jne    801049e0 <wait_stat+0x40>
                continue;
            havekids = 1;
            if(p->state == ZOMBIE){
801049f3:	8b 43 0c             	mov    0xc(%ebx),%eax
801049f6:	83 f8 05             	cmp    $0x5,%eax
801049f9:	74 3b                	je     80104a36 <wait_stat+0x96>

    acquire(&ptable.lock);
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049fb:	81 c3 a8 00 00 00    	add    $0xa8,%ebx
            if(p->parent != curproc)
                continue;
            havekids = 1;
80104a01:	b8 01 00 00 00       	mov    $0x1,%eax

    acquire(&ptable.lock);
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a06:	81 fb b4 77 11 80    	cmp    $0x801177b4,%ebx
80104a0c:	75 e0                	jne    801049ee <wait_stat+0x4e>
80104a0e:	66 90                	xchg   %ax,%ax
                return pid;
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
80104a10:	85 c0                	test   %eax,%eax
80104a12:	0f 84 c6 00 00 00    	je     80104ade <wait_stat+0x13e>
80104a18:	8b 56 24             	mov    0x24(%esi),%edx
80104a1b:	85 d2                	test   %edx,%edx
80104a1d:	0f 85 bb 00 00 00    	jne    80104ade <wait_stat+0x13e>
            release(&ptable.lock);
            return -1;
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104a23:	b8 80 4d 11 80       	mov    $0x80114d80,%eax
80104a28:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a2c:	89 34 24             	mov    %esi,(%esp)
80104a2f:	e8 ec f8 ff ff       	call   80104320 <sleep>
    }
80104a34:	eb 97                	jmp    801049cd <wait_stat+0x2d>
                continue;
            havekids = 1;
            if(p->state == ZOMBIE){
                // Found one.
                pid = p->pid;
                kfree(p->kstack);
80104a36:	8b 43 08             	mov    0x8(%ebx),%eax
            if(p->parent != curproc)
                continue;
            havekids = 1;
            if(p->state == ZOMBIE){
                // Found one.
                pid = p->pid;
80104a39:	8b 73 10             	mov    0x10(%ebx),%esi
                kfree(p->kstack);
80104a3c:	89 04 24             	mov    %eax,(%esp)
80104a3f:	e8 4c d9 ff ff       	call   80102390 <kfree>
                p->kstack = 0;
                freevm(p->pgdir);
80104a44:	8b 43 04             	mov    0x4(%ebx),%eax
            havekids = 1;
            if(p->state == ZOMBIE){
                // Found one.
                pid = p->pid;
                kfree(p->kstack);
                p->kstack = 0;
80104a47:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
                freevm(p->pgdir);
80104a4e:	89 04 24             	mov    %eax,(%esp)
80104a51:	e8 ba 38 00 00       	call   80108310 <freevm>
                p->parent = 0;
                p->name[0] = 0;
                p->killed = 0;
                p->state = UNUSED;
                //TODO - maybe need to use argptr
                if(status!=null)
80104a56:	85 ff                	test   %edi,%edi
                // Found one.
                pid = p->pid;
                kfree(p->kstack);
                p->kstack = 0;
                freevm(p->pgdir);
                p->pid = 0;
80104a58:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
                p->parent = 0;
80104a5f:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
                p->name[0] = 0;
80104a66:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
                p->killed = 0;
80104a6a:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
                p->state = UNUSED;
80104a71:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
                //TODO - maybe need to use argptr
                if(status!=null)
80104a78:	74 03                	je     80104a7d <wait_stat+0xdd>
                    p->exit_status= (int)status ;
80104a7a:	89 7b 7c             	mov    %edi,0x7c(%ebx)
                //ent time= creation time+run time+sleep time+ready time
                p->perf.ttime=p->perf.ctime+p->perf.rutime+p->perf.retime+p->perf.stime;
80104a7d:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80104a83:	8b 8b 9c 00 00 00    	mov    0x9c(%ebx),%ecx
80104a89:	8b 93 98 00 00 00    	mov    0x98(%ebx),%edx
80104a8f:	8b bb 94 00 00 00    	mov    0x94(%ebx),%edi
                cprintf("process pid:  %d \n creation time:  %d\nRUNNING time:  %d\n"
80104a95:	89 44 24 08          	mov    %eax,0x8(%esp)
80104a99:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
                p->state = UNUSED;
                //TODO - maybe need to use argptr
                if(status!=null)
                    p->exit_status= (int)status ;
                //ent time= creation time+run time+sleep time+ready time
                p->perf.ttime=p->perf.ctime+p->perf.rutime+p->perf.retime+p->perf.stime;
80104a9d:	89 54 24 10          	mov    %edx,0x10(%esp)
80104aa1:	8d 14 08             	lea    (%eax,%ecx,1),%edx
80104aa4:	03 54 24 10          	add    0x10(%esp),%edx
                cprintf("process pid:  %d \n creation time:  %d\nRUNNING time:  %d\n"
80104aa8:	89 7c 24 14          	mov    %edi,0x14(%esp)
80104aac:	89 74 24 04          	mov    %esi,0x4(%esp)
                p->state = UNUSED;
                //TODO - maybe need to use argptr
                if(status!=null)
                    p->exit_status= (int)status ;
                //ent time= creation time+run time+sleep time+ready time
                p->perf.ttime=p->perf.ctime+p->perf.rutime+p->perf.retime+p->perf.stime;
80104ab0:	01 fa                	add    %edi,%edx
                cprintf("process pid:  %d \n creation time:  %d\nRUNNING time:  %d\n"
80104ab2:	89 54 24 18          	mov    %edx,0x18(%esp)
80104ab6:	c7 04 24 58 8d 10 80 	movl   $0x80108d58,(%esp)
                p->state = UNUSED;
                //TODO - maybe need to use argptr
                if(status!=null)
                    p->exit_status= (int)status ;
                //ent time= creation time+run time+sleep time+ready time
                p->perf.ttime=p->perf.ctime+p->perf.rutime+p->perf.retime+p->perf.stime;
80104abd:	89 93 90 00 00 00    	mov    %edx,0x90(%ebx)
                cprintf("process pid:  %d \n creation time:  %d\nRUNNING time:  %d\n"
80104ac3:	e8 78 bb ff ff       	call   80100640 <cprintf>
                        "READY time:  %d\nSLEEPING time:  %d\nend time:  %d\n",
                        pid,p->perf.ctime,p->perf.rutime,p->perf.retime,p->perf.stime,p->perf.ttime);
                release(&ptable.lock);
80104ac8:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104acf:	e8 5c 0f 00 00       	call   80105a30 <release>
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104ad4:	83 c4 2c             	add    $0x2c,%esp
                p->perf.ttime=p->perf.ctime+p->perf.rutime+p->perf.retime+p->perf.stime;
                cprintf("process pid:  %d \n creation time:  %d\nRUNNING time:  %d\n"
                        "READY time:  %d\nSLEEPING time:  %d\nend time:  %d\n",
                        pid,p->perf.ctime,p->perf.rutime,p->perf.retime,p->perf.stime,p->perf.ttime);
                release(&ptable.lock);
                return pid;
80104ad7:	89 f0                	mov    %esi,%eax
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104ad9:	5b                   	pop    %ebx
80104ada:	5e                   	pop    %esi
80104adb:	5f                   	pop    %edi
80104adc:	5d                   	pop    %ebp
80104add:	c3                   	ret    
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
            release(&ptable.lock);
80104ade:	c7 04 24 80 4d 11 80 	movl   $0x80114d80,(%esp)
80104ae5:	e8 46 0f 00 00       	call   80105a30 <release>
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104aea:	83 c4 2c             	add    $0x2c,%esp
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
            release(&ptable.lock);
            return -1;
80104aed:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104af2:	5b                   	pop    %ebx
80104af3:	5e                   	pop    %esi
80104af4:	5f                   	pop    %edi
80104af5:	5d                   	pop    %ebp
80104af6:	c3                   	ret    
80104af7:	66 90                	xchg   %ax,%ax
80104af9:	66 90                	xchg   %ax,%ax
80104afb:	66 90                	xchg   %ax,%ax
80104afd:	66 90                	xchg   %ax,%ax
80104aff:	90                   	nop

80104b00 <isEmptyPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80104b00:	a1 14 c6 10 80       	mov    0x8010c614,%eax
	spaceLeft -= size;
	return ans;
}

//for pq
static boolean isEmptyPriorityQueue() {
80104b05:	55                   	push   %ebp
80104b06:	89 e5                	mov    %esp,%ebp
	return priorityQ->isEmpty();
}
80104b08:	5d                   	pop    %ebp
	return ans;
}

//for pq
static boolean isEmptyPriorityQueue() {
	return priorityQ->isEmpty();
80104b09:	8b 00                	mov    (%eax),%eax
80104b0b:	85 c0                	test   %eax,%eax
80104b0d:	0f 94 c0             	sete   %al
80104b10:	0f b6 c0             	movzbl %al,%eax
}
80104b13:	c3                   	ret    
80104b14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104b20 <getMinAccumulatorPriorityQueue>:
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80104b20:	a1 14 c6 10 80       	mov    0x8010c614,%eax
80104b25:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104b27:	85 d2                	test   %edx,%edx
80104b29:	75 07                	jne    80104b32 <getMinAccumulatorPriorityQueue+0x12>
80104b2b:	eb 2b                	jmp    80104b58 <getMinAccumulatorPriorityQueue+0x38>
80104b2d:	8d 76 00             	lea    0x0(%esi),%esi
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
	while(minNode->left)
80104b30:	89 c2                	mov    %eax,%edx
80104b32:	8b 42 18             	mov    0x18(%edx),%eax
80104b35:	85 c0                	test   %eax,%eax
80104b37:	75 f7                	jne    80104b30 <getMinAccumulatorPriorityQueue+0x10>

static boolean putPriorityQueue(Proc* p) {
	return priorityQ->put(p);
}

static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
80104b39:	55                   	push   %ebp
80104b3a:	89 e5                	mov    %esp,%ebp
80104b3c:	53                   	push   %ebx

	return minNode;
}

void MapNode::getMinKey(long long *pkey) {
	*pkey = getMinNode()->key;
80104b3d:	8b 45 08             	mov    0x8(%ebp),%eax
80104b40:	8b 5a 04             	mov    0x4(%edx),%ebx
80104b43:	8b 0a                	mov    (%edx),%ecx
80104b45:	89 58 04             	mov    %ebx,0x4(%eax)
80104b48:	89 08                	mov    %ecx,(%eax)
80104b4a:	b8 01 00 00 00       	mov    $0x1,%eax
	return priorityQ->put(p);
}

static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
	return priorityQ->getMinKey(pkey);
}
80104b4f:	5b                   	pop    %ebx
80104b50:	5d                   	pop    %ebp
80104b51:	c3                   	ret    
80104b52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
80104b58:	31 c0                	xor    %eax,%eax
80104b5a:	c3                   	ret    
80104b5b:	90                   	nop
80104b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b60 <isEmptyRoundRobinQueue>:

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104b60:	a1 10 c6 10 80       	mov    0x8010c610,%eax
static boolean extractProcPriorityQueue(Proc *p) {
	return priorityQ->extractProc(p);
}

//for rrq
static boolean isEmptyRoundRobinQueue() {
80104b65:	55                   	push   %ebp
80104b66:	89 e5                	mov    %esp,%ebp
	return roundRobinQ->isEmpty();
}
80104b68:	5d                   	pop    %ebp
	return priorityQ->extractProc(p);
}

//for rrq
static boolean isEmptyRoundRobinQueue() {
	return roundRobinQ->isEmpty();
80104b69:	8b 00                	mov    (%eax),%eax
80104b6b:	85 c0                	test   %eax,%eax
80104b6d:	0f 94 c0             	sete   %al
80104b70:	0f b6 c0             	movzbl %al,%eax
}
80104b73:	c3                   	ret    
80104b74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104b80 <dequeueRoundRobinQueue>:
static boolean enqueueRoundRobinQueue(Proc *p) {
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
80104b80:	8b 0d 10 c6 10 80    	mov    0x8010c610,%ecx

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104b86:	8b 11                	mov    (%ecx),%edx
	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
80104b88:	85 d2                	test   %edx,%edx
80104b8a:	74 4c                	je     80104bd8 <dequeueRoundRobinQueue+0x58>

static boolean enqueueRoundRobinQueue(Proc *p) {
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
80104b8c:	55                   	push   %ebp
80104b8d:	89 e5                	mov    %esp,%ebp
80104b8f:	83 ec 08             	sub    $0x8,%esp
80104b92:	89 75 fc             	mov    %esi,-0x4(%ebp)
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80104b95:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi

static boolean enqueueRoundRobinQueue(Proc *p) {
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
80104b9b:	89 5d f8             	mov    %ebx,-0x8(%ebp)
Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
	Link *next = first->next;
80104b9e:	8b 5a 04             	mov    0x4(%edx),%ebx

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
80104ba1:	8b 02                	mov    (%edx),%eax
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80104ba3:	89 72 04             	mov    %esi,0x4(%edx)
	freeLinks = link;
80104ba6:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
80104bac:	85 db                	test   %ebx,%ebx
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
80104bae:	89 19                	mov    %ebx,(%ecx)

	if(isEmpty())
80104bb0:	74 0e                	je     80104bc0 <dequeueRoundRobinQueue+0x40>
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
}
80104bb2:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104bb5:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104bb8:	89 ec                	mov    %ebp,%esp
80104bba:	5d                   	pop    %ebp
80104bbb:	c3                   	ret    
80104bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	deallocLink(first);
	
	first = next;

	if(isEmpty())
		last = null;
80104bc0:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
	return roundRobinQ->enqueue(p);
}

static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
}
80104bc7:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104bca:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104bcd:	89 ec                	mov    %ebp,%esp
80104bcf:	5d                   	pop    %ebp
80104bd0:	c3                   	ret    
80104bd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;
80104bd8:	31 c0                	xor    %eax,%eax
80104bda:	c3                   	ret    
80104bdb:	90                   	nop
80104bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104be0 <isEmptyRunningProcessHolder>:

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104be0:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
	return roundRobinQ->transfer();
}

//for rpholder
static boolean isEmptyRunningProcessHolder() {
80104be5:	55                   	push   %ebp
80104be6:	89 e5                	mov    %esp,%ebp
	return runningProcHolder->isEmpty();
}
80104be8:	5d                   	pop    %ebp
	return roundRobinQ->transfer();
}

//for rpholder
static boolean isEmptyRunningProcessHolder() {
	return runningProcHolder->isEmpty();
80104be9:	8b 00                	mov    (%eax),%eax
80104beb:	85 c0                	test   %eax,%eax
80104bed:	0f 94 c0             	sete   %al
80104bf0:	0f b6 c0             	movzbl %al,%eax
}
80104bf3:	c3                   	ret    
80104bf4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104bfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c00 <_ZL8mymallocj>:
static MapNode                    *freeNodes;

static char                       *data;
static uint                       spaceLeft;
                
static char* mymalloc(uint size) {
80104c00:	55                   	push   %ebp
80104c01:	89 e5                	mov    %esp,%ebp
80104c03:	53                   	push   %ebx
80104c04:	89 c3                	mov    %eax,%ebx
80104c06:	83 ec 14             	sub    $0x14,%esp
	if(spaceLeft < size) {
80104c09:	8b 15 fc c5 10 80    	mov    0x8010c5fc,%edx
80104c0f:	39 c2                	cmp    %eax,%edx
80104c11:	73 26                	jae    80104c39 <_ZL8mymallocj+0x39>
		data = kalloc();
80104c13:	e8 48 d9 ff ff       	call   80102560 <kalloc>
		memset(data, 0, PGSIZE);
80104c18:	ba 00 10 00 00       	mov    $0x1000,%edx
80104c1d:	31 c9                	xor    %ecx,%ecx
80104c1f:	89 54 24 08          	mov    %edx,0x8(%esp)
80104c23:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80104c27:	89 04 24             	mov    %eax,(%esp)
static char                       *data;
static uint                       spaceLeft;
                
static char* mymalloc(uint size) {
	if(spaceLeft < size) {
		data = kalloc();
80104c2a:	a3 00 c6 10 80       	mov    %eax,0x8010c600
		memset(data, 0, PGSIZE);
80104c2f:	e8 4c 0e 00 00       	call   80105a80 <memset>
80104c34:	ba 00 10 00 00       	mov    $0x1000,%edx
		spaceLeft = PGSIZE;
	}

	char* ans = data;
80104c39:	a1 00 c6 10 80       	mov    0x8010c600,%eax
	data += size;
	spaceLeft -= size;
80104c3e:	29 da                	sub    %ebx,%edx
80104c40:	89 15 fc c5 10 80    	mov    %edx,0x8010c5fc
		memset(data, 0, PGSIZE);
		spaceLeft = PGSIZE;
	}

	char* ans = data;
	data += size;
80104c46:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104c49:	89 0d 00 c6 10 80    	mov    %ecx,0x8010c600
	spaceLeft -= size;
	return ans;
}
80104c4f:	83 c4 14             	add    $0x14,%esp
80104c52:	5b                   	pop    %ebx
80104c53:	5d                   	pop    %ebp
80104c54:	c3                   	ret    
80104c55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c60 <initSchedDS>:

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
	return runningProcHolder->getMinKey(pkey);
}

void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104c60:	55                   	push   %ebp
	data               = null;
80104c61:	31 c0                	xor    %eax,%eax

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
	return runningProcHolder->getMinKey(pkey);
}

void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104c63:	89 e5                	mov    %esp,%ebp
80104c65:	53                   	push   %ebx
	*roundRobinQ       = LinkedList();

	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
	*runningProcHolder = LinkedList();

	freeLinks = null;
80104c66:	bb 80 00 00 00       	mov    $0x80,%ebx

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
	return runningProcHolder->getMinKey(pkey);
}

void initSchedDS() { //called once by the "pioneer" cpu from the main function in main.c
80104c6b:	83 ec 04             	sub    $0x4,%esp
	data               = null;
80104c6e:	a3 00 c6 10 80       	mov    %eax,0x8010c600
	spaceLeft          = 0u;
80104c73:	31 c0                	xor    %eax,%eax
80104c75:	a3 fc c5 10 80       	mov    %eax,0x8010c5fc

	priorityQ          = (Map*)mymalloc(sizeof(Map));
80104c7a:	b8 04 00 00 00       	mov    $0x4,%eax
80104c7f:	e8 7c ff ff ff       	call   80104c00 <_ZL8mymallocj>
80104c84:	a3 14 c6 10 80       	mov    %eax,0x8010c614
	*priorityQ         = Map();
80104c89:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

	roundRobinQ        = (LinkedList*)mymalloc(sizeof(LinkedList));
80104c8f:	b8 08 00 00 00       	mov    $0x8,%eax
80104c94:	e8 67 ff ff ff       	call   80104c00 <_ZL8mymallocj>
80104c99:	a3 10 c6 10 80       	mov    %eax,0x8010c610
	*roundRobinQ       = LinkedList();
80104c9e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104ca4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)

	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
80104cab:	b8 08 00 00 00       	mov    $0x8,%eax
80104cb0:	e8 4b ff ff ff       	call   80104c00 <_ZL8mymallocj>
80104cb5:	a3 0c c6 10 80       	mov    %eax,0x8010c60c
	*runningProcHolder = LinkedList();
80104cba:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104cc0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)

	freeLinks = null;
80104cc7:	31 c0                	xor    %eax,%eax
80104cc9:	a3 08 c6 10 80       	mov    %eax,0x8010c608
80104cce:	66 90                	xchg   %ax,%ax
	for(int i = 0; i < NPROCLIST; ++i) {
		Link *link = (Link*)mymalloc(sizeof(Link));
80104cd0:	b8 08 00 00 00       	mov    $0x8,%eax
80104cd5:	e8 26 ff ff ff       	call   80104c00 <_ZL8mymallocj>
		*link = Link();
		link->next = freeLinks;
80104cda:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx

	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
	*runningProcHolder = LinkedList();

	freeLinks = null;
	for(int i = 0; i < NPROCLIST; ++i) {
80104ce0:	4b                   	dec    %ebx
		Link *link = (Link*)mymalloc(sizeof(Link));
		*link = Link();
80104ce1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
		link->next = freeLinks;
80104ce7:	89 50 04             	mov    %edx,0x4(%eax)
		freeLinks = link;
80104cea:	a3 08 c6 10 80       	mov    %eax,0x8010c608

	runningProcHolder  = (LinkedList*)mymalloc(sizeof(LinkedList));
	*runningProcHolder = LinkedList();

	freeLinks = null;
	for(int i = 0; i < NPROCLIST; ++i) {
80104cef:	75 df                	jne    80104cd0 <initSchedDS+0x70>
		*link = Link();
		link->next = freeLinks;
		freeLinks = link;
	}

	freeNodes = null;
80104cf1:	31 c0                	xor    %eax,%eax
80104cf3:	bb 80 00 00 00       	mov    $0x80,%ebx
80104cf8:	a3 04 c6 10 80       	mov    %eax,0x8010c604
80104cfd:	8d 76 00             	lea    0x0(%esi),%esi
	for(int i = 0; i < NPROCMAP; ++i) {
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
80104d00:	b8 20 00 00 00       	mov    $0x20,%eax
80104d05:	e8 f6 fe ff ff       	call   80104c00 <_ZL8mymallocj>
		*node = MapNode();
		node->next = freeNodes;
80104d0a:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
		link->next = freeLinks;
		freeLinks = link;
	}

	freeNodes = null;
	for(int i = 0; i < NPROCMAP; ++i) {
80104d10:	4b                   	dec    %ebx
		MapNode *node = (MapNode*)mymalloc(sizeof(MapNode));
		*node = MapNode();
80104d11:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104d18:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
80104d1f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80104d26:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
80104d2d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
		node->next = freeNodes;
80104d34:	89 50 10             	mov    %edx,0x10(%eax)
		freeNodes = node;
80104d37:	a3 04 c6 10 80       	mov    %eax,0x8010c604
		link->next = freeLinks;
		freeLinks = link;
	}

	freeNodes = null;
	for(int i = 0; i < NPROCMAP; ++i) {
80104d3c:	75 c2                	jne    80104d00 <initSchedDS+0xa0>
		node->next = freeNodes;
		freeNodes = node;
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
80104d3e:	b8 00 4b 10 80       	mov    $0x80104b00,%eax
	pq.put                          = putPriorityQueue;
80104d43:	ba a0 53 10 80       	mov    $0x801053a0,%edx
		node->next = freeNodes;
		freeNodes = node;
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
80104d48:	a3 e4 c5 10 80       	mov    %eax,0x8010c5e4
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
	pq.extractMin                   = extractMinPriorityQueue;
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104d4d:	b8 30 55 10 80       	mov    $0x80105530,%eax
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104d52:	b9 20 4b 10 80       	mov    $0x80104b20,%ecx
	pq.extractMin                   = extractMinPriorityQueue;
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
80104d57:	a3 f4 c5 10 80       	mov    %eax,0x8010c5f4
	pq.extractProc                  = extractProcPriorityQueue;
80104d5c:	b8 00 56 10 80       	mov    $0x80105600,%eax

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
	pq.extractMin                   = extractMinPriorityQueue;
80104d61:	bb c0 54 10 80       	mov    $0x801054c0,%ebx
	pq.switchToRoundRobinPolicy     = switchToRoundRobinPolicyPriorityQueue;
	pq.extractProc                  = extractProcPriorityQueue;
80104d66:	a3 f8 c5 10 80       	mov    %eax,0x8010c5f8

	//init rrq
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
80104d6b:	b8 60 4b 10 80       	mov    $0x80104b60,%eax
80104d70:	a3 d4 c5 10 80       	mov    %eax,0x8010c5d4
	rrq.enqueue                     = enqueueRoundRobinQueue;
80104d75:	b8 d0 4e 10 80       	mov    $0x80104ed0,%eax
80104d7a:	a3 d8 c5 10 80       	mov    %eax,0x8010c5d8
	rrq.dequeue                     = dequeueRoundRobinQueue;
80104d7f:	b8 80 4b 10 80       	mov    $0x80104b80,%eax
80104d84:	a3 dc c5 10 80       	mov    %eax,0x8010c5dc
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104d89:	b8 00 51 10 80       	mov    $0x80105100,%eax
		freeNodes = node;
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
80104d8e:	89 15 e8 c5 10 80    	mov    %edx,0x8010c5e8
	rrq.enqueue                     = enqueueRoundRobinQueue;
	rrq.dequeue                     = dequeueRoundRobinQueue;
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104d94:	ba e0 4b 10 80       	mov    $0x80104be0,%edx
	}

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
80104d99:	89 0d ec c5 10 80    	mov    %ecx,0x8010c5ec
	rrq.dequeue                     = dequeueRoundRobinQueue;
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
	rpholder.add                    = addRunningProcessHolder;
80104d9f:	b9 b0 4e 10 80       	mov    $0x80104eb0,%ecx

	//init pq
	pq.isEmpty                      = isEmptyPriorityQueue;
	pq.put                          = putPriorityQueue;
	pq.getMinAccumulator            = getMinAccumulatorPriorityQueue;
	pq.extractMin                   = extractMinPriorityQueue;
80104da4:	89 1d f0 c5 10 80    	mov    %ebx,0x8010c5f0
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
	rpholder.add                    = addRunningProcessHolder;
	rpholder.remove                 = removeRunningProcessHolder;
80104daa:	bb 60 50 10 80       	mov    $0x80105060,%ebx

	//init rrq
	rrq.isEmpty                     = isEmptyRoundRobinQueue;
	rrq.enqueue                     = enqueueRoundRobinQueue;
	rrq.dequeue                     = dequeueRoundRobinQueue;
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;
80104daf:	a3 e0 c5 10 80       	mov    %eax,0x8010c5e0

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
	rpholder.add                    = addRunningProcessHolder;
	rpholder.remove                 = removeRunningProcessHolder;
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104db4:	b8 a0 51 10 80       	mov    $0x801051a0,%eax
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
	rpholder.add                    = addRunningProcessHolder;
	rpholder.remove                 = removeRunningProcessHolder;
80104db9:	89 1d cc c5 10 80    	mov    %ebx,0x8010c5cc
	rrq.enqueue                     = enqueueRoundRobinQueue;
	rrq.dequeue                     = dequeueRoundRobinQueue;
	rrq.switchToPriorityQueuePolicy = switchToPriorityQueuePolicyRoundRobinQueue;

	//init rpholder
	rpholder.isEmpty                = isEmptyRunningProcessHolder;
80104dbf:	89 15 c4 c5 10 80    	mov    %edx,0x8010c5c4
	rpholder.add                    = addRunningProcessHolder;
80104dc5:	89 0d c8 c5 10 80    	mov    %ecx,0x8010c5c8
	rpholder.remove                 = removeRunningProcessHolder;
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
80104dcb:	a3 d0 c5 10 80       	mov    %eax,0x8010c5d0
}
80104dd0:	58                   	pop    %eax
80104dd1:	5b                   	pop    %ebx
80104dd2:	5d                   	pop    %ebp
80104dd3:	c3                   	ret    
80104dd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104dda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104de0 <_ZN4Link7getLastEv>:
	}

	return ans;
}

Link* Link::getLast() {
80104de0:	55                   	push   %ebp
80104de1:	89 e5                	mov    %esp,%ebp
	Link* ans = this;
80104de3:	8b 45 08             	mov    0x8(%ebp),%eax
80104de6:	eb 0a                	jmp    80104df2 <_ZN4Link7getLastEv+0x12>
80104de8:	90                   	nop
80104de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104df0:	89 d0                	mov    %edx,%eax
	
	while(ans->next)
80104df2:	8b 50 04             	mov    0x4(%eax),%edx
80104df5:	85 d2                	test   %edx,%edx
80104df7:	75 f7                	jne    80104df0 <_ZN4Link7getLastEv+0x10>
		ans = ans->next;

	return ans;
}
80104df9:	5d                   	pop    %ebp
80104dfa:	c3                   	ret    
80104dfb:	90                   	nop
80104dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e00 <_ZN10LinkedList7isEmptyEv>:

bool LinkedList::isEmpty() {
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
	return !first;
80104e03:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104e06:	5d                   	pop    %ebp

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104e07:	8b 00                	mov    (%eax),%eax
80104e09:	85 c0                	test   %eax,%eax
80104e0b:	0f 94 c0             	sete   %al
}
80104e0e:	c3                   	ret    
80104e0f:	90                   	nop

80104e10 <_ZN10LinkedList6appendEP4Link>:

void LinkedList::append(Link *link) {
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	8b 55 0c             	mov    0xc(%ebp),%edx
80104e16:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!link)
80104e19:	85 d2                	test   %edx,%edx
80104e1b:	74 1f                	je     80104e3c <_ZN10LinkedList6appendEP4Link+0x2c>
		return;

	if(isEmpty()) first = link;
80104e1d:	8b 01                	mov    (%ecx),%eax
80104e1f:	85 c0                	test   %eax,%eax
80104e21:	74 1d                	je     80104e40 <_ZN10LinkedList6appendEP4Link+0x30>
	else last->next = link;
80104e23:	8b 41 04             	mov    0x4(%ecx),%eax
80104e26:	89 50 04             	mov    %edx,0x4(%eax)
80104e29:	eb 07                	jmp    80104e32 <_ZN10LinkedList6appendEP4Link+0x22>
80104e2b:	90                   	nop
80104e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

Link* Link::getLast() {
	Link* ans = this;
	
	while(ans->next)
80104e30:	89 c2                	mov    %eax,%edx
80104e32:	8b 42 04             	mov    0x4(%edx),%eax
80104e35:	85 c0                	test   %eax,%eax
80104e37:	75 f7                	jne    80104e30 <_ZN10LinkedList6appendEP4Link+0x20>
		return;

	if(isEmpty()) first = link;
	else last->next = link;

	last = link->getLast();
80104e39:	89 51 04             	mov    %edx,0x4(%ecx)
}
80104e3c:	5d                   	pop    %ebp
80104e3d:	c3                   	ret    
80104e3e:	66 90                	xchg   %ax,%ax

void LinkedList::append(Link *link) {
	if(!link)
		return;

	if(isEmpty()) first = link;
80104e40:	89 11                	mov    %edx,(%ecx)
80104e42:	eb ee                	jmp    80104e32 <_ZN10LinkedList6appendEP4Link+0x22>
80104e44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104e50 <_ZN10LinkedList7enqueueEP4proc>:
	rpholder.remove                 = removeRunningProcessHolder;
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
}

static Link* allocLink(Proc *p) {
	if(!freeLinks)
80104e50:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
	else last->next = link;

	last = link->getLast();
}

bool LinkedList::enqueue(Proc *p) {
80104e56:	55                   	push   %ebp
80104e57:	89 e5                	mov    %esp,%ebp
80104e59:	8b 4d 08             	mov    0x8(%ebp),%ecx
	rpholder.remove                 = removeRunningProcessHolder;
	rpholder.getMinAccumulator      = getMinAccumulatorRunningProcessHolder;
}

static Link* allocLink(Proc *p) {
	if(!freeLinks)
80104e5c:	85 d2                	test   %edx,%edx
80104e5e:	74 40                	je     80104ea0 <_ZN10LinkedList7enqueueEP4proc+0x50>
		return null;

	Link *ans = freeLinks;
	freeLinks = freeLinks->next;
80104e60:	8b 42 04             	mov    0x4(%edx),%eax
	ans->next = null;
80104e63:	c7 42 04 00 00 00 00 	movl   $0x0,0x4(%edx)
static Link* allocLink(Proc *p) {
	if(!freeLinks)
		return null;

	Link *ans = freeLinks;
	freeLinks = freeLinks->next;
80104e6a:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	ans->next = null;
	ans->p = p;
80104e6f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e72:	89 02                	mov    %eax,(%edx)

void LinkedList::append(Link *link) {
	if(!link)
		return;

	if(isEmpty()) first = link;
80104e74:	8b 01                	mov    (%ecx),%eax
80104e76:	85 c0                	test   %eax,%eax
80104e78:	74 2e                	je     80104ea8 <_ZN10LinkedList7enqueueEP4proc+0x58>
	else last->next = link;
80104e7a:	8b 41 04             	mov    0x4(%ecx),%eax
80104e7d:	89 50 04             	mov    %edx,0x4(%eax)
80104e80:	eb 08                	jmp    80104e8a <_ZN10LinkedList7enqueueEP4proc+0x3a>
80104e82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}

Link* Link::getLast() {
	Link* ans = this;
	
	while(ans->next)
80104e88:	89 c2                	mov    %eax,%edx
80104e8a:	8b 42 04             	mov    0x4(%edx),%eax
80104e8d:	85 c0                	test   %eax,%eax
80104e8f:	75 f7                	jne    80104e88 <_ZN10LinkedList7enqueueEP4proc+0x38>
		return;

	if(isEmpty()) first = link;
	else last->next = link;

	last = link->getLast();
80104e91:	89 51 04             	mov    %edx,0x4(%ecx)
	
	if(!link)
		return false;

	append(link);
	return true;
80104e94:	b0 01                	mov    $0x1,%al
}
80104e96:	5d                   	pop    %ebp
80104e97:	c3                   	ret    
80104e98:	90                   	nop
80104e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

bool LinkedList::enqueue(Proc *p) {
	Link *link = allocLink(p);
	
	if(!link)
		return false;
80104ea0:	31 c0                	xor    %eax,%eax

	append(link);
	return true;
}
80104ea2:	5d                   	pop    %ebp
80104ea3:	c3                   	ret    
80104ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void LinkedList::append(Link *link) {
	if(!link)
		return;

	if(isEmpty()) first = link;
80104ea8:	89 11                	mov    %edx,(%ecx)
80104eaa:	eb de                	jmp    80104e8a <_ZN10LinkedList7enqueueEP4proc+0x3a>
80104eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104eb0 <addRunningProcessHolder>:
//for rpholder
static boolean isEmptyRunningProcessHolder() {
	return runningProcHolder->isEmpty();
}

static boolean addRunningProcessHolder(Proc* p) {
80104eb0:	55                   	push   %ebp
80104eb1:	89 e5                	mov    %esp,%ebp
80104eb3:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->enqueue(p);
80104eb6:	8b 45 08             	mov    0x8(%ebp),%eax
80104eb9:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ebd:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
80104ec2:	89 04 24             	mov    %eax,(%esp)
80104ec5:	e8 86 ff ff ff       	call   80104e50 <_ZN10LinkedList7enqueueEP4proc>
}
80104eca:	c9                   	leave  
static boolean isEmptyRunningProcessHolder() {
	return runningProcHolder->isEmpty();
}

static boolean addRunningProcessHolder(Proc* p) {
	return runningProcHolder->enqueue(p);
80104ecb:	0f b6 c0             	movzbl %al,%eax
}
80104ece:	c3                   	ret    
80104ecf:	90                   	nop

80104ed0 <enqueueRoundRobinQueue>:
//for rrq
static boolean isEmptyRoundRobinQueue() {
	return roundRobinQ->isEmpty();
}

static boolean enqueueRoundRobinQueue(Proc *p) {
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	83 ec 08             	sub    $0x8,%esp
	return roundRobinQ->enqueue(p);
80104ed6:	8b 45 08             	mov    0x8(%ebp),%eax
80104ed9:	89 44 24 04          	mov    %eax,0x4(%esp)
80104edd:	a1 10 c6 10 80       	mov    0x8010c610,%eax
80104ee2:	89 04 24             	mov    %eax,(%esp)
80104ee5:	e8 66 ff ff ff       	call   80104e50 <_ZN10LinkedList7enqueueEP4proc>
}
80104eea:	c9                   	leave  
static boolean isEmptyRoundRobinQueue() {
	return roundRobinQ->isEmpty();
}

static boolean enqueueRoundRobinQueue(Proc *p) {
	return roundRobinQ->enqueue(p);
80104eeb:	0f b6 c0             	movzbl %al,%eax
}
80104eee:	c3                   	ret    
80104eef:	90                   	nop

80104ef0 <_ZL9allocNodeP4procx>:
	ans->next = null;
	ans->key = key;
	return ans;
}

static MapNode* allocNode(Proc *p, long long key) {
80104ef0:	55                   	push   %ebp
80104ef1:	89 e5                	mov    %esp,%ebp
80104ef3:	56                   	push   %esi
80104ef4:	53                   	push   %ebx
80104ef5:	83 ec 08             	sub    $0x8,%esp
	if(!freeNodes)
80104ef8:	8b 1d 04 c6 10 80    	mov    0x8010c604,%ebx
80104efe:	85 db                	test   %ebx,%ebx
80104f00:	74 28                	je     80104f2a <_ZL9allocNodeP4procx+0x3a>
static MapNode* allocNode(long long key) {
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
80104f02:	8b 73 10             	mov    0x10(%ebx),%esi
	ans->next = null;
	ans->key = key;
80104f05:	89 13                	mov    %edx,(%ebx)
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
	ans->next = null;
80104f07:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
80104f0e:	89 4b 04             	mov    %ecx,0x4(%ebx)

	MapNode *ans = allocNode(key);
	if(!ans)
		return null;

	if(!ans->listOfProcs.enqueue(p)) {
80104f11:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f15:	8d 43 08             	lea    0x8(%ebx),%eax
80104f18:	89 04 24             	mov    %eax,(%esp)
static MapNode* allocNode(long long key) {
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
80104f1b:	89 35 04 c6 10 80    	mov    %esi,0x8010c604

	MapNode *ans = allocNode(key);
	if(!ans)
		return null;

	if(!ans->listOfProcs.enqueue(p)) {
80104f21:	e8 2a ff ff ff       	call   80104e50 <_ZN10LinkedList7enqueueEP4proc>
80104f26:	84 c0                	test   %al,%al
80104f28:	74 0e                	je     80104f38 <_ZL9allocNodeP4procx+0x48>
		deallocNode(ans);
		return null;
	}

	return ans;
}
80104f2a:	83 c4 08             	add    $0x8,%esp
80104f2d:	89 d8                	mov    %ebx,%eax
80104f2f:	5b                   	pop    %ebx
80104f30:	5e                   	pop    %esi
80104f31:	5d                   	pop    %ebp
80104f32:	c3                   	ret    
80104f33:	90                   	nop
80104f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	link->next = freeLinks;
	freeLinks = link;
}

static void deallocNode(MapNode *node) {
	node->parent = node->left = node->right = null;
80104f38:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
80104f3f:	c7 43 18 00 00 00 00 	movl   $0x0,0x18(%ebx)
80104f46:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
	node->next = freeNodes;
80104f4d:	89 73 10             	mov    %esi,0x10(%ebx)
	freeNodes = node;
80104f50:	89 1d 04 c6 10 80    	mov    %ebx,0x8010c604
	if(!ans)
		return null;

	if(!ans->listOfProcs.enqueue(p)) {
		deallocNode(ans);
		return null;
80104f56:	31 db                	xor    %ebx,%ebx
80104f58:	eb d0                	jmp    80104f2a <_ZL9allocNodeP4procx+0x3a>
80104f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f60 <_ZN10LinkedList7dequeueEv>:

	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
80104f60:	55                   	push   %ebp
80104f61:	89 e5                	mov    %esp,%ebp
80104f63:	83 ec 08             	sub    $0x8,%esp
80104f66:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104f69:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104f6c:	89 75 fc             	mov    %esi,-0x4(%ebp)

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104f6f:	8b 11                	mov    (%ecx),%edx
	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
80104f71:	85 d2                	test   %edx,%edx
80104f73:	74 43                	je     80104fb8 <_ZN10LinkedList7dequeueEv+0x58>
		return null;

	Proc *p = first->p;
	Link *next = first->next;
80104f75:	8b 5a 04             	mov    0x4(%edx),%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80104f78:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
80104f7e:	8b 02                	mov    (%edx),%eax
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
	freeLinks = link;
80104f80:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
80104f86:	85 db                	test   %ebx,%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80104f88:	89 72 04             	mov    %esi,0x4(%edx)
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
80104f8b:	89 19                	mov    %ebx,(%ecx)

	if(isEmpty())
80104f8d:	74 11                	je     80104fa0 <_ZN10LinkedList7dequeueEv+0x40>
		last = null;
	
	return p;
}
80104f8f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104f92:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104f95:	89 ec                	mov    %ebp,%esp
80104f97:	5d                   	pop    %ebp
80104f98:	c3                   	ret    
80104f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	deallocLink(first);
	
	first = next;

	if(isEmpty())
		last = null;
80104fa0:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
	
	return p;
}
80104fa7:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104faa:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104fad:	89 ec                	mov    %ebp,%esp
80104faf:	5d                   	pop    %ebp
80104fb0:	c3                   	ret    
80104fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;
80104fb8:	31 c0                	xor    %eax,%eax
80104fba:	eb d3                	jmp    80104f8f <_ZN10LinkedList7dequeueEv+0x2f>
80104fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fc0 <_ZN10LinkedList6removeEP4proc>:
		last = null;
	
	return p;
}

bool LinkedList::remove(Proc *p) {
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	56                   	push   %esi
80104fc4:	8b 75 08             	mov    0x8(%ebp),%esi
80104fc7:	53                   	push   %ebx
80104fc8:	8b 4d 0c             	mov    0xc(%ebp),%ecx

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80104fcb:	8b 1e                	mov    (%esi),%ebx
	
	return p;
}

bool LinkedList::remove(Proc *p) {
	if(isEmpty())
80104fcd:	85 db                	test   %ebx,%ebx
80104fcf:	74 57                	je     80105028 <_ZN10LinkedList6removeEP4proc+0x68>
		return false;
	
	if(first->p == p) {
80104fd1:	39 0b                	cmp    %ecx,(%ebx)
Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
	Link *next = first->next;
80104fd3:	8b 53 04             	mov    0x4(%ebx),%edx

bool LinkedList::remove(Proc *p) {
	if(isEmpty())
		return false;
	
	if(first->p == p) {
80104fd6:	74 58                	je     80105030 <_ZN10LinkedList6removeEP4proc+0x70>
		return true;
	}

	Link *prev = first;
	Link *cur = first->next;
	while(cur) {
80104fd8:	85 d2                	test   %edx,%edx
80104fda:	74 4c                	je     80105028 <_ZN10LinkedList6removeEP4proc+0x68>
		if(cur->p == p) {
80104fdc:	3b 0a                	cmp    (%edx),%ecx
80104fde:	66 90                	xchg   %ax,%ax
80104fe0:	75 0c                	jne    80104fee <_ZN10LinkedList6removeEP4proc+0x2e>
80104fe2:	eb 15                	jmp    80104ff9 <_ZN10LinkedList6removeEP4proc+0x39>
80104fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fe8:	3b 08                	cmp    (%eax),%ecx
80104fea:	74 14                	je     80105000 <_ZN10LinkedList6removeEP4proc+0x40>
80104fec:	89 c2                	mov    %eax,%edx

			return true;
		}

		prev = cur;
		cur = cur->next;
80104fee:	8b 42 04             	mov    0x4(%edx),%eax
		return true;
	}

	Link *prev = first;
	Link *cur = first->next;
	while(cur) {
80104ff1:	85 c0                	test   %eax,%eax
80104ff3:	75 f3                	jne    80104fe8 <_ZN10LinkedList6removeEP4proc+0x28>
		cur = cur->next;
	}

	//didn't find the process
	return false;
}
80104ff5:	5b                   	pop    %ebx
80104ff6:	5e                   	pop    %esi
80104ff7:	5d                   	pop    %ebp
80104ff8:	c3                   	ret    
	}

	Link *prev = first;
	Link *cur = first->next;
	while(cur) {
		if(cur->p == p) {
80104ff9:	89 d0                	mov    %edx,%eax
80104ffb:	89 da                	mov    %ebx,%edx
80104ffd:	8d 76 00             	lea    0x0(%esi),%esi
			prev->next = cur->next;
80105000:	8b 48 04             	mov    0x4(%eax),%ecx
80105003:	89 4a 04             	mov    %ecx,0x4(%edx)
			
			if(!(cur->next)) //removes the last link
80105006:	8b 48 04             	mov    0x4(%eax),%ecx
80105009:	85 c9                	test   %ecx,%ecx
8010500b:	74 43                	je     80105050 <_ZN10LinkedList6removeEP4proc+0x90>
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
8010500d:	8b 15 08 c6 10 80    	mov    0x8010c608,%edx
	freeLinks = link;
80105013:	a3 08 c6 10 80       	mov    %eax,0x8010c608
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80105018:	89 50 04             	mov    %edx,0x4(%eax)
			if(!(cur->next)) //removes the last link
				last = prev;

			deallocLink(cur);

			return true;
8010501b:	b0 01                	mov    $0x1,%al
		cur = cur->next;
	}

	//didn't find the process
	return false;
}
8010501d:	5b                   	pop    %ebx
8010501e:	5e                   	pop    %esi
8010501f:	5d                   	pop    %ebp
80105020:	c3                   	ret    
80105021:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105028:	5b                   	pop    %ebx
	return p;
}

bool LinkedList::remove(Proc *p) {
	if(isEmpty())
		return false;
80105029:	31 c0                	xor    %eax,%eax
		cur = cur->next;
	}

	//didn't find the process
	return false;
}
8010502b:	5e                   	pop    %esi
8010502c:	5d                   	pop    %ebp
8010502d:	c3                   	ret    
8010502e:	66 90                	xchg   %ax,%ax
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80105030:	a1 08 c6 10 80       	mov    0x8010c608,%eax
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
80105035:	85 d2                	test   %edx,%edx
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
	freeLinks = link;
80105037:	89 1d 08 c6 10 80    	mov    %ebx,0x8010c608
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
8010503d:	89 43 04             	mov    %eax,0x4(%ebx)
	if(isEmpty())
		return false;
	
	if(first->p == p) {
		dequeue();
		return true;
80105040:	b0 01                	mov    $0x1,%al
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
80105042:	89 16                	mov    %edx,(%esi)

	if(isEmpty())
80105044:	75 af                	jne    80104ff5 <_ZN10LinkedList6removeEP4proc+0x35>
		last = null;
80105046:	c7 46 04 00 00 00 00 	movl   $0x0,0x4(%esi)
8010504d:	eb a6                	jmp    80104ff5 <_ZN10LinkedList6removeEP4proc+0x35>
8010504f:	90                   	nop
	while(cur) {
		if(cur->p == p) {
			prev->next = cur->next;
			
			if(!(cur->next)) //removes the last link
				last = prev;
80105050:	89 56 04             	mov    %edx,0x4(%esi)
80105053:	eb b8                	jmp    8010500d <_ZN10LinkedList6removeEP4proc+0x4d>
80105055:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105060 <removeRunningProcessHolder>:

static boolean addRunningProcessHolder(Proc* p) {
	return runningProcHolder->enqueue(p);
}

static boolean removeRunningProcessHolder(Proc* p) {
80105060:	55                   	push   %ebp
80105061:	89 e5                	mov    %esp,%ebp
80105063:	83 ec 08             	sub    $0x8,%esp
	return runningProcHolder->remove(p);
80105066:	8b 45 08             	mov    0x8(%ebp),%eax
80105069:	89 44 24 04          	mov    %eax,0x4(%esp)
8010506d:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
80105072:	89 04 24             	mov    %eax,(%esp)
80105075:	e8 46 ff ff ff       	call   80104fc0 <_ZN10LinkedList6removeEP4proc>
}
8010507a:	c9                   	leave  
static boolean addRunningProcessHolder(Proc* p) {
	return runningProcHolder->enqueue(p);
}

static boolean removeRunningProcessHolder(Proc* p) {
	return runningProcHolder->remove(p);
8010507b:	0f b6 c0             	movzbl %al,%eax
}
8010507e:	c3                   	ret    
8010507f:	90                   	nop

80105080 <_ZN10LinkedList8transferEv>:
	//didn't find the process
	return false;
}

bool LinkedList::transfer() {
	if(!priorityQ->isEmpty())
80105080:	8b 15 14 c6 10 80    	mov    0x8010c614,%edx
		return false;
80105086:	31 c0                	xor    %eax,%eax

	//didn't find the process
	return false;
}

bool LinkedList::transfer() {
80105088:	55                   	push   %ebp
80105089:	89 e5                	mov    %esp,%ebp
8010508b:	53                   	push   %ebx
8010508c:	8b 4d 08             	mov    0x8(%ebp),%ecx
	if(!priorityQ->isEmpty())
8010508f:	8b 1a                	mov    (%edx),%ebx
80105091:	85 db                	test   %ebx,%ebx
80105093:	74 0b                	je     801050a0 <_ZN10LinkedList8transferEv+0x20>
		node->listOfProcs.last = last;
		first = last = null;
		priorityQ->root = node;
	}
	return true;
}
80105095:	5b                   	pop    %ebx
80105096:	5d                   	pop    %ebp
80105097:	c3                   	ret    
80105098:	90                   	nop
80105099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

bool LinkedList::transfer() {
	if(!priorityQ->isEmpty())
		return false;
	
	if(!isEmpty()) {
801050a0:	8b 19                	mov    (%ecx),%ebx
801050a2:	85 db                	test   %ebx,%ebx
801050a4:	74 4a                	je     801050f0 <_ZN10LinkedList8transferEv+0x70>
	node->next = freeNodes;
	freeNodes = node;
}

static MapNode* allocNode(long long key) {
	if(!freeNodes)
801050a6:	8b 1d 04 c6 10 80    	mov    0x8010c604,%ebx
801050ac:	85 db                	test   %ebx,%ebx
801050ae:	74 e5                	je     80105095 <_ZN10LinkedList8transferEv+0x15>
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
801050b0:	8b 43 10             	mov    0x10(%ebx),%eax
	ans->next = null;
	ans->key = key;
801050b3:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
	ans->next = null;
801050b9:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
	ans->key = key;
801050c0:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
static MapNode* allocNode(long long key) {
	if(!freeNodes)
		return null;

	MapNode *ans = freeNodes;
	freeNodes = freeNodes->next;
801050c7:	a3 04 c6 10 80       	mov    %eax,0x8010c604
	if(!isEmpty()) {
		MapNode *node = allocNode(0);
		if(!node)
			return false;
		
		node->listOfProcs.first = first;
801050cc:	8b 01                	mov    (%ecx),%eax
801050ce:	89 43 08             	mov    %eax,0x8(%ebx)
		node->listOfProcs.last = last;
801050d1:	8b 41 04             	mov    0x4(%ecx),%eax
801050d4:	89 43 0c             	mov    %eax,0xc(%ebx)
		first = last = null;
		priorityQ->root = node;
	}
	return true;
801050d7:	b0 01                	mov    $0x1,%al
		if(!node)
			return false;
		
		node->listOfProcs.first = first;
		node->listOfProcs.last = last;
		first = last = null;
801050d9:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%ecx)
801050e0:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
		priorityQ->root = node;
801050e6:	89 1a                	mov    %ebx,(%edx)
	}
	return true;
}
801050e8:	5b                   	pop    %ebx
801050e9:	5d                   	pop    %ebp
801050ea:	c3                   	ret    
801050eb:	90                   	nop
801050ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		node->listOfProcs.first = first;
		node->listOfProcs.last = last;
		first = last = null;
		priorityQ->root = node;
	}
	return true;
801050f0:	b0 01                	mov    $0x1,%al
801050f2:	eb a1                	jmp    80105095 <_ZN10LinkedList8transferEv+0x15>
801050f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105100 <switchToPriorityQueuePolicyRoundRobinQueue>:

static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
}

static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	83 ec 04             	sub    $0x4,%esp
	return roundRobinQ->transfer();
80105106:	a1 10 c6 10 80       	mov    0x8010c610,%eax
8010510b:	89 04 24             	mov    %eax,(%esp)
8010510e:	e8 6d ff ff ff       	call   80105080 <_ZN10LinkedList8transferEv>
}
80105113:	c9                   	leave  
static Proc* dequeueRoundRobinQueue() {
	return roundRobinQ->dequeue();
}

static boolean switchToPriorityQueuePolicyRoundRobinQueue() {
	return roundRobinQ->transfer();
80105114:	0f b6 c0             	movzbl %al,%eax
}
80105117:	c3                   	ret    
80105118:	90                   	nop
80105119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105120 <_ZN10LinkedList9getMinKeyEPx>:
		priorityQ->root = node;
	}
	return true;
}

bool LinkedList::getMinKey(long long *pkey) {
80105120:	55                   	push   %ebp
80105121:	89 e5                	mov    %esp,%ebp
80105123:	57                   	push   %edi
80105124:	56                   	push   %esi
80105125:	53                   	push   %ebx
80105126:	83 ec 1c             	sub    $0x1c,%esp
80105129:	8b 7d 08             	mov    0x8(%ebp),%edi

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
8010512c:	8b 07                	mov    (%edi),%eax
	}
	return true;
}

bool LinkedList::getMinKey(long long *pkey) {
	if(isEmpty())
8010512e:	85 c0                	test   %eax,%eax
80105130:	74 56                	je     80105188 <_ZN10LinkedList9getMinKeyEPx+0x68>
		return false;

	long long minKey = getAccumulator(first->p);
80105132:	8b 00                	mov    (%eax),%eax
80105134:	89 04 24             	mov    %eax,(%esp)
80105137:	e8 a4 e6 ff ff       	call   801037e0 <getAccumulator>
8010513c:	8b 3f                	mov    (%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
8010513e:	85 ff                	test   %edi,%edi
80105140:	89 c6                	mov    %eax,%esi
80105142:	89 d3                	mov    %edx,%ebx
80105144:	74 29                	je     8010516f <_ZN10LinkedList9getMinKeyEPx+0x4f>
80105146:	8d 76 00             	lea    0x0(%esi),%esi
80105149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	
	forEach([&](Proc *p) {
		long long key = getAccumulator(p);
80105150:	8b 07                	mov    (%edi),%eax
80105152:	89 04 24             	mov    %eax,(%esp)
80105155:	e8 86 e6 ff ff       	call   801037e0 <getAccumulator>
8010515a:	39 d3                	cmp    %edx,%ebx
8010515c:	7c 0a                	jl     80105168 <_ZN10LinkedList9getMinKeyEPx+0x48>
8010515e:	7f 04                	jg     80105164 <_ZN10LinkedList9getMinKeyEPx+0x44>
80105160:	39 c6                	cmp    %eax,%esi
80105162:	76 04                	jbe    80105168 <_ZN10LinkedList9getMinKeyEPx+0x48>
80105164:	89 c6                	mov    %eax,%esi
80105166:	89 d3                	mov    %edx,%ebx
			accept(link->p);
			link = link->next;
80105168:	8b 7f 04             	mov    0x4(%edi),%edi
	void append(Link *link); //appends the given list to the queue. No allocations always succeeds.
	
	template<typename Func>
	void forEach(const Func& accept) { //for-each loop. gets a function that applies the procin each link node.
		Link *link = first;
		while(link) {
8010516b:	85 ff                	test   %edi,%edi
8010516d:	75 e1                	jne    80105150 <_ZN10LinkedList9getMinKeyEPx+0x30>
		if(key < minKey)
			minKey = key;
	});

	*pkey = minKey;
8010516f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105172:	89 30                	mov    %esi,(%eax)
80105174:	89 58 04             	mov    %ebx,0x4(%eax)
	
	return true;
}
80105177:	83 c4 1c             	add    $0x1c,%esp
			minKey = key;
	});

	*pkey = minKey;
	
	return true;
8010517a:	b0 01                	mov    $0x1,%al
}
8010517c:	5b                   	pop    %ebx
8010517d:	5e                   	pop    %esi
8010517e:	5f                   	pop    %edi
8010517f:	5d                   	pop    %ebp
80105180:	c3                   	ret    
80105181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105188:	83 c4 1c             	add    $0x1c,%esp
	return true;
}

bool LinkedList::getMinKey(long long *pkey) {
	if(isEmpty())
		return false;
8010518b:	31 c0                	xor    %eax,%eax
	});

	*pkey = minKey;
	
	return true;
}
8010518d:	5b                   	pop    %ebx
8010518e:	5e                   	pop    %esi
8010518f:	5f                   	pop    %edi
80105190:	5d                   	pop    %ebp
80105191:	c3                   	ret    
80105192:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051a0 <getMinAccumulatorRunningProcessHolder>:

static boolean removeRunningProcessHolder(Proc* p) {
	return runningProcHolder->remove(p);
}

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	83 ec 18             	sub    $0x18,%esp
	return runningProcHolder->getMinKey(pkey);
801051a6:	8b 45 08             	mov    0x8(%ebp),%eax
801051a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801051ad:	a1 0c c6 10 80       	mov    0x8010c60c,%eax
801051b2:	89 04 24             	mov    %eax,(%esp)
801051b5:	e8 66 ff ff ff       	call   80105120 <_ZN10LinkedList9getMinKeyEPx>
}
801051ba:	c9                   	leave  
static boolean removeRunningProcessHolder(Proc* p) {
	return runningProcHolder->remove(p);
}

static boolean getMinAccumulatorRunningProcessHolder(long long *pkey) {
	return runningProcHolder->getMinKey(pkey);
801051bb:	0f b6 c0             	movzbl %al,%eax
}
801051be:	c3                   	ret    
801051bf:	90                   	nop

801051c0 <_ZN7MapNode7isEmptyEv>:
	*pkey = minKey;
	
	return true;
}

bool MapNode::isEmpty() {
801051c0:	55                   	push   %ebp
801051c1:	89 e5                	mov    %esp,%ebp
	return listOfProcs.isEmpty();
801051c3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801051c6:	5d                   	pop    %ebp
	
	return true;
}

bool MapNode::isEmpty() {
	return listOfProcs.isEmpty();
801051c7:	8b 40 08             	mov    0x8(%eax),%eax
801051ca:	85 c0                	test   %eax,%eax
801051cc:	0f 94 c0             	sete   %al
}
801051cf:	c3                   	ret    

801051d0 <_ZN7MapNode3putEP4proc>:

bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	57                   	push   %edi
801051d4:	56                   	push   %esi
801051d5:	53                   	push   %ebx
801051d6:	83 ec 2c             	sub    $0x2c,%esp
801051d9:	8b 45 0c             	mov    0xc(%ebp),%eax
801051dc:	8b 5d 08             	mov    0x8(%ebp),%ebx
	MapNode *node = this;
	long long key = getAccumulator(p);
801051df:	89 04 24             	mov    %eax,(%esp)

bool MapNode::isEmpty() {
	return listOfProcs.isEmpty();
}

bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
801051e2:	89 45 e0             	mov    %eax,-0x20(%ebp)
	MapNode *node = this;
	long long key = getAccumulator(p);
801051e5:	e8 f6 e5 ff ff       	call   801037e0 <getAccumulator>
801051ea:	89 c6                	mov    %eax,%esi
801051ec:	89 d1                	mov    %edx,%ecx
801051ee:	66 90                	xchg   %ax,%ax
	for(;;) {
		if(key == node->key)
801051f0:	8b 43 04             	mov    0x4(%ebx),%eax
801051f3:	89 cf                	mov    %ecx,%edi
801051f5:	8b 13                	mov    (%ebx),%edx
801051f7:	31 c7                	xor    %eax,%edi
801051f9:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801051fc:	89 f7                	mov    %esi,%edi
801051fe:	31 d7                	xor    %edx,%edi
80105200:	0b 7d e4             	or     -0x1c(%ebp),%edi
80105203:	74 43                	je     80105248 <_ZN7MapNode3putEP4proc+0x78>
			return node->listOfProcs.enqueue(p);
		else if(key < node->key) { //left
80105205:	39 c1                	cmp    %eax,%ecx
80105207:	7f 17                	jg     80105220 <_ZN7MapNode3putEP4proc+0x50>
80105209:	7c 07                	jl     80105212 <_ZN7MapNode3putEP4proc+0x42>
8010520b:	39 d6                	cmp    %edx,%esi
8010520d:	8d 76 00             	lea    0x0(%esi),%esi
80105210:	73 0e                	jae    80105220 <_ZN7MapNode3putEP4proc+0x50>
			if(node->left)
80105212:	8b 43 18             	mov    0x18(%ebx),%eax
80105215:	85 c0                	test   %eax,%eax
80105217:	74 47                	je     80105260 <_ZN7MapNode3putEP4proc+0x90>
80105219:	89 c3                	mov    %eax,%ebx
8010521b:	eb d3                	jmp    801051f0 <_ZN7MapNode3putEP4proc+0x20>
8010521d:	8d 76 00             	lea    0x0(%esi),%esi
					return true;
				}
				return false;
			}
		} else { //right
			if(node->right)
80105220:	8b 43 1c             	mov    0x1c(%ebx),%eax
80105223:	85 c0                	test   %eax,%eax
80105225:	75 f2                	jne    80105219 <_ZN7MapNode3putEP4proc+0x49>
				node = node->right;
			else {
				node->right = allocNode(p, key);
80105227:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010522a:	89 f2                	mov    %esi,%edx
8010522c:	e8 bf fc ff ff       	call   80104ef0 <_ZL9allocNodeP4procx>
				if(node->right) {
80105231:	85 c0                	test   %eax,%eax
			}
		} else { //right
			if(node->right)
				node = node->right;
			else {
				node->right = allocNode(p, key);
80105233:	89 43 1c             	mov    %eax,0x1c(%ebx)
				if(node->right) {
80105236:	74 39                	je     80105271 <_ZN7MapNode3putEP4proc+0xa1>
					node->right->parent = node;
80105238:	89 58 14             	mov    %ebx,0x14(%eax)
					return true;
8010523b:	b0 01                	mov    $0x1,%al
				}
				return false;
			}
		}
	}
}
8010523d:	83 c4 2c             	add    $0x2c,%esp
80105240:	5b                   	pop    %ebx
80105241:	5e                   	pop    %esi
80105242:	5f                   	pop    %edi
80105243:	5d                   	pop    %ebp
80105244:	c3                   	ret    
80105245:	8d 76 00             	lea    0x0(%esi),%esi
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
	MapNode *node = this;
	long long key = getAccumulator(p);
	for(;;) {
		if(key == node->key)
			return node->listOfProcs.enqueue(p);
80105248:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010524b:	83 c3 08             	add    $0x8,%ebx
8010524e:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105251:	89 45 0c             	mov    %eax,0xc(%ebp)
				}
				return false;
			}
		}
	}
}
80105254:	83 c4 2c             	add    $0x2c,%esp
80105257:	5b                   	pop    %ebx
80105258:	5e                   	pop    %esi
80105259:	5f                   	pop    %edi
8010525a:	5d                   	pop    %ebp
bool MapNode::put(Proc *p) { //we can not use recursion, since the stack of xv6 is too small....
	MapNode *node = this;
	long long key = getAccumulator(p);
	for(;;) {
		if(key == node->key)
			return node->listOfProcs.enqueue(p);
8010525b:	e9 f0 fb ff ff       	jmp    80104e50 <_ZN10LinkedList7enqueueEP4proc>
		else if(key < node->key) { //left
			if(node->left)
				node = node->left;
			else {
				node->left = allocNode(p, key);
80105260:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105263:	89 f2                	mov    %esi,%edx
80105265:	e8 86 fc ff ff       	call   80104ef0 <_ZL9allocNodeP4procx>
				if(node->left) {
8010526a:	85 c0                	test   %eax,%eax
			return node->listOfProcs.enqueue(p);
		else if(key < node->key) { //left
			if(node->left)
				node = node->left;
			else {
				node->left = allocNode(p, key);
8010526c:	89 43 18             	mov    %eax,0x18(%ebx)
				if(node->left) {
8010526f:	75 c7                	jne    80105238 <_ZN7MapNode3putEP4proc+0x68>
					node->left->parent = node;
					return true;
				}
				return false;
80105271:	31 c0                	xor    %eax,%eax
80105273:	eb c8                	jmp    8010523d <_ZN7MapNode3putEP4proc+0x6d>
80105275:	90                   	nop
80105276:	8d 76 00             	lea    0x0(%esi),%esi
80105279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105280 <_ZN7MapNode10getMinNodeEv>:
			}
		}
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
80105280:	55                   	push   %ebp
80105281:	89 e5                	mov    %esp,%ebp
	MapNode* minNode = this;	
80105283:	8b 45 08             	mov    0x8(%ebp),%eax
80105286:	eb 0a                	jmp    80105292 <_ZN7MapNode10getMinNodeEv+0x12>
80105288:	90                   	nop
80105289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105290:	89 d0                	mov    %edx,%eax
	while(minNode->left)
80105292:	8b 50 18             	mov    0x18(%eax),%edx
80105295:	85 d2                	test   %edx,%edx
80105297:	75 f7                	jne    80105290 <_ZN7MapNode10getMinNodeEv+0x10>
		minNode = minNode->left;

	return minNode;
}
80105299:	5d                   	pop    %ebp
8010529a:	c3                   	ret    
8010529b:	90                   	nop
8010529c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052a0 <_ZN7MapNode9getMinKeyEPx>:

void MapNode::getMinKey(long long *pkey) {
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
		}
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
801052a3:	8b 55 08             	mov    0x8(%ebp),%edx
		minNode = minNode->left;

	return minNode;
}

void MapNode::getMinKey(long long *pkey) {
801052a6:	53                   	push   %ebx
801052a7:	eb 09                	jmp    801052b2 <_ZN7MapNode9getMinKeyEPx+0x12>
801052a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
	while(minNode->left)
801052b0:	89 c2                	mov    %eax,%edx
801052b2:	8b 42 18             	mov    0x18(%edx),%eax
801052b5:	85 c0                	test   %eax,%eax
801052b7:	75 f7                	jne    801052b0 <_ZN7MapNode9getMinKeyEPx+0x10>

	return minNode;
}

void MapNode::getMinKey(long long *pkey) {
	*pkey = getMinNode()->key;
801052b9:	8b 5a 04             	mov    0x4(%edx),%ebx
801052bc:	8b 45 0c             	mov    0xc(%ebp),%eax
801052bf:	8b 0a                	mov    (%edx),%ecx
801052c1:	89 58 04             	mov    %ebx,0x4(%eax)
801052c4:	89 08                	mov    %ecx,(%eax)
}
801052c6:	5b                   	pop    %ebx
801052c7:	5d                   	pop    %ebp
801052c8:	c3                   	ret    
801052c9:	90                   	nop
801052ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801052d0 <_ZN7MapNode7dequeueEv>:

Proc* MapNode::dequeue() {
801052d0:	55                   	push   %ebp
801052d1:	89 e5                	mov    %esp,%ebp
801052d3:	83 ec 08             	sub    $0x8,%esp
801052d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
801052d9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801052dc:	89 75 fc             	mov    %esi,-0x4(%ebp)

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
801052df:	8b 51 08             	mov    0x8(%ecx),%edx
	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
801052e2:	85 d2                	test   %edx,%edx
801052e4:	74 42                	je     80105328 <_ZN7MapNode7dequeueEv+0x58>
		return null;

	Proc *p = first->p;
	Link *next = first->next;
801052e6:	8b 5a 04             	mov    0x4(%edx),%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
801052e9:	8b 35 08 c6 10 80    	mov    0x8010c608,%esi

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
801052ef:	8b 02                	mov    (%edx),%eax
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
	freeLinks = link;
801052f1:	89 15 08 c6 10 80    	mov    %edx,0x8010c608
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
801052f7:	85 db                	test   %ebx,%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
801052f9:	89 72 04             	mov    %esi,0x4(%edx)
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
801052fc:	89 59 08             	mov    %ebx,0x8(%ecx)

	if(isEmpty())
801052ff:	74 0f                	je     80105310 <_ZN7MapNode7dequeueEv+0x40>
	*pkey = getMinNode()->key;
}

Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}
80105301:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105304:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105307:	89 ec                	mov    %ebp,%esp
80105309:	5d                   	pop    %ebp
8010530a:	c3                   	ret    
8010530b:	90                   	nop
8010530c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	deallocLink(first);
	
	first = next;

	if(isEmpty())
		last = null;
80105310:	c7 41 0c 00 00 00 00 	movl   $0x0,0xc(%ecx)
	*pkey = getMinNode()->key;
}

Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}
80105317:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010531a:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010531d:	89 ec                	mov    %ebp,%esp
8010531f:	5d                   	pop    %ebp
80105320:	c3                   	ret    
80105321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;
80105328:	31 c0                	xor    %eax,%eax
8010532a:	eb d5                	jmp    80105301 <_ZN7MapNode7dequeueEv+0x31>
8010532c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105330 <_ZN3Map7isEmptyEv>:

Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
	return !root;
80105333:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105336:	5d                   	pop    %ebp
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80105337:	8b 00                	mov    (%eax),%eax
80105339:	85 c0                	test   %eax,%eax
8010533b:	0f 94 c0             	sete   %al
}
8010533e:	c3                   	ret    
8010533f:	90                   	nop

80105340 <_ZN3Map3putEP4proc>:

bool Map::put(Proc *p) {
80105340:	55                   	push   %ebp
80105341:	89 e5                	mov    %esp,%ebp
80105343:	83 ec 18             	sub    $0x18,%esp
80105346:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105349:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010534c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010534f:	8b 75 08             	mov    0x8(%ebp),%esi
	long long key = getAccumulator(p);
80105352:	89 1c 24             	mov    %ebx,(%esp)
80105355:	e8 86 e4 ff ff       	call   801037e0 <getAccumulator>
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
8010535a:	8b 0e                	mov    (%esi),%ecx
}

bool Map::put(Proc *p) {
	long long key = getAccumulator(p);
	if(isEmpty()) {
8010535c:	85 c9                	test   %ecx,%ecx
8010535e:	74 18                	je     80105378 <_ZN3Map3putEP4proc+0x38>
		root = allocNode(p, key);
		return !isEmpty();
	}
	
	return root->put(p);
80105360:	89 5d 0c             	mov    %ebx,0xc(%ebp)
}
80105363:	8b 75 fc             	mov    -0x4(%ebp),%esi
	if(isEmpty()) {
		root = allocNode(p, key);
		return !isEmpty();
	}
	
	return root->put(p);
80105366:	89 4d 08             	mov    %ecx,0x8(%ebp)
}
80105369:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010536c:	89 ec                	mov    %ebp,%esp
8010536e:	5d                   	pop    %ebp
	if(isEmpty()) {
		root = allocNode(p, key);
		return !isEmpty();
	}
	
	return root->put(p);
8010536f:	e9 5c fe ff ff       	jmp    801051d0 <_ZN7MapNode3putEP4proc>
80105374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}

bool Map::put(Proc *p) {
	long long key = getAccumulator(p);
	if(isEmpty()) {
		root = allocNode(p, key);
80105378:	89 d1                	mov    %edx,%ecx
8010537a:	89 c2                	mov    %eax,%edx
8010537c:	89 d8                	mov    %ebx,%eax
8010537e:	e8 6d fb ff ff       	call   80104ef0 <_ZL9allocNodeP4procx>
80105383:	89 06                	mov    %eax,(%esi)
		return !isEmpty();
80105385:	85 c0                	test   %eax,%eax
80105387:	0f 95 c0             	setne  %al
	}
	
	return root->put(p);
}
8010538a:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010538d:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105390:	89 ec                	mov    %ebp,%esp
80105392:	5d                   	pop    %ebp
80105393:	c3                   	ret    
80105394:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010539a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801053a0 <putPriorityQueue>:
//for pq
static boolean isEmptyPriorityQueue() {
	return priorityQ->isEmpty();
}

static boolean putPriorityQueue(Proc* p) {
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->put(p);
801053a6:	8b 45 08             	mov    0x8(%ebp),%eax
801053a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801053ad:	a1 14 c6 10 80       	mov    0x8010c614,%eax
801053b2:	89 04 24             	mov    %eax,(%esp)
801053b5:	e8 86 ff ff ff       	call   80105340 <_ZN3Map3putEP4proc>
}
801053ba:	c9                   	leave  
static boolean isEmptyPriorityQueue() {
	return priorityQ->isEmpty();
}

static boolean putPriorityQueue(Proc* p) {
	return priorityQ->put(p);
801053bb:	0f b6 c0             	movzbl %al,%eax
}
801053be:	c3                   	ret    
801053bf:	90                   	nop

801053c0 <_ZN3Map9getMinKeyEPx>:
	}
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
801053c3:	8b 45 08             	mov    0x8(%ebp),%eax
	}
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
801053c6:	53                   	push   %ebx
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
801053c7:	8b 10                	mov    (%eax),%edx
	
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
801053c9:	85 d2                	test   %edx,%edx
801053cb:	75 05                	jne    801053d2 <_ZN3Map9getMinKeyEPx+0x12>
801053cd:	eb 21                	jmp    801053f0 <_ZN3Map9getMinKeyEPx+0x30>
801053cf:	90                   	nop
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
	while(minNode->left)
801053d0:	89 c2                	mov    %eax,%edx
801053d2:	8b 42 18             	mov    0x18(%edx),%eax
801053d5:	85 c0                	test   %eax,%eax
801053d7:	75 f7                	jne    801053d0 <_ZN3Map9getMinKeyEPx+0x10>

	return minNode;
}

void MapNode::getMinKey(long long *pkey) {
	*pkey = getMinNode()->key;
801053d9:	8b 45 0c             	mov    0xc(%ebp),%eax
801053dc:	8b 5a 04             	mov    0x4(%edx),%ebx
801053df:	8b 0a                	mov    (%edx),%ecx
801053e1:	89 58 04             	mov    %ebx,0x4(%eax)
801053e4:	89 08                	mov    %ecx,(%eax)
bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
		return false;

	root->getMinKey(pkey);
	return true;
801053e6:	b0 01                	mov    $0x1,%al
}
801053e8:	5b                   	pop    %ebx
801053e9:	5d                   	pop    %ebp
801053ea:	c3                   	ret    
801053eb:	90                   	nop
801053ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053f0:	5b                   	pop    %ebx
	return root->put(p);
}

bool Map::getMinKey(long long *pkey) {
	if(isEmpty())
		return false;
801053f1:	31 c0                	xor    %eax,%eax

	root->getMinKey(pkey);
	return true;
}
801053f3:	5d                   	pop    %ebp
801053f4:	c3                   	ret    
801053f5:	90                   	nop
801053f6:	8d 76 00             	lea    0x0(%esi),%esi
801053f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105400 <_ZN3Map10extractMinEv>:

Proc* Map::extractMin() {
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	57                   	push   %edi
80105404:	56                   	push   %esi
80105405:	8b 75 08             	mov    0x8(%ebp),%esi
80105408:	53                   	push   %ebx
Proc* MapNode::dequeue() {
	return listOfProcs.dequeue();
}

bool Map::isEmpty() {
	return !root;
80105409:	8b 1e                	mov    (%esi),%ebx
	root->getMinKey(pkey);
	return true;
}

Proc* Map::extractMin() {
	if(isEmpty())
8010540b:	85 db                	test   %ebx,%ebx
8010540d:	0f 84 a2 00 00 00    	je     801054b5 <_ZN3Map10extractMinEv+0xb5>
80105413:	89 da                	mov    %ebx,%edx
80105415:	eb 0b                	jmp    80105422 <_ZN3Map10extractMinEv+0x22>
80105417:	89 f6                	mov    %esi,%esi
80105419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	}
}

MapNode* MapNode::getMinNode() { //no recursion.
	MapNode* minNode = this;	
	while(minNode->left)
80105420:	89 c2                	mov    %eax,%edx
80105422:	8b 42 18             	mov    0x18(%edx),%eax
80105425:	85 c0                	test   %eax,%eax
80105427:	75 f7                	jne    80105420 <_ZN3Map10extractMinEv+0x20>

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80105429:	8b 4a 08             	mov    0x8(%edx),%ecx
	append(link);
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
8010542c:	85 c9                	test   %ecx,%ecx
8010542e:	74 20                	je     80105450 <_ZN3Map10extractMinEv+0x50>
		return null;

	Proc *p = first->p;
	Link *next = first->next;
80105430:	8b 59 04             	mov    0x4(%ecx),%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80105433:	8b 3d 08 c6 10 80    	mov    0x8010c608,%edi

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;

	Proc *p = first->p;
80105439:	8b 01                	mov    (%ecx),%eax
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
	freeLinks = link;
8010543b:	89 0d 08 c6 10 80    	mov    %ecx,0x8010c608
	
	deallocLink(first);
	
	first = next;

	if(isEmpty())
80105441:	85 db                	test   %ebx,%ebx
	ans->p = p;
	return ans;
}

static void deallocLink(Link *link) {
	link->next = freeLinks;
80105443:	89 79 04             	mov    %edi,0x4(%ecx)
	Proc *p = first->p;
	Link *next = first->next;
	
	deallocLink(first);
	
	first = next;
80105446:	89 5a 08             	mov    %ebx,0x8(%edx)

	if(isEmpty())
80105449:	74 4d                	je     80105498 <_ZN3Map10extractMinEv+0x98>
		}
		deallocNode(minNode);
	}

	return p;
}
8010544b:	5b                   	pop    %ebx
8010544c:	5e                   	pop    %esi
8010544d:	5f                   	pop    %edi
8010544e:	5d                   	pop    %ebp
8010544f:	c3                   	ret    
	return true;
}

Proc* LinkedList::dequeue() {
	if(isEmpty())
		return null;
80105450:	31 c0                	xor    %eax,%eax
	MapNode *minNode = root->getMinNode();

	Proc *p = minNode->dequeue();
	
	if(minNode->isEmpty()) {
		if(minNode == root) {
80105452:	39 da                	cmp    %ebx,%edx
80105454:	74 4d                	je     801054a3 <_ZN3Map10extractMinEv+0xa3>
			root = minNode->right;
			if(!isEmpty())
				root->parent = null;
		} else {
			MapNode *parent = minNode->parent;
			parent->left = minNode->right;
80105456:	8b 4a 1c             	mov    0x1c(%edx),%ecx
		if(minNode == root) {
			root = minNode->right;
			if(!isEmpty())
				root->parent = null;
		} else {
			MapNode *parent = minNode->parent;
80105459:	8b 5a 14             	mov    0x14(%edx),%ebx
			parent->left = minNode->right;
8010545c:	89 4b 18             	mov    %ecx,0x18(%ebx)
			if(minNode->right)
8010545f:	8b 4a 1c             	mov    0x1c(%edx),%ecx
80105462:	85 c9                	test   %ecx,%ecx
80105464:	74 03                	je     80105469 <_ZN3Map10extractMinEv+0x69>
				minNode->right->parent = parent;
80105466:	89 59 14             	mov    %ebx,0x14(%ecx)
	freeLinks = link;
}

static void deallocNode(MapNode *node) {
	node->parent = node->left = node->right = null;
	node->next = freeNodes;
80105469:	8b 0d 04 c6 10 80    	mov    0x8010c604,%ecx
	link->next = freeLinks;
	freeLinks = link;
}

static void deallocNode(MapNode *node) {
	node->parent = node->left = node->right = null;
8010546f:	c7 42 1c 00 00 00 00 	movl   $0x0,0x1c(%edx)
80105476:	c7 42 18 00 00 00 00 	movl   $0x0,0x18(%edx)
8010547d:	c7 42 14 00 00 00 00 	movl   $0x0,0x14(%edx)
	node->next = freeNodes;
80105484:	89 4a 10             	mov    %ecx,0x10(%edx)
		}
		deallocNode(minNode);
	}

	return p;
}
80105487:	5b                   	pop    %ebx
}

static void deallocNode(MapNode *node) {
	node->parent = node->left = node->right = null;
	node->next = freeNodes;
	freeNodes = node;
80105488:	89 15 04 c6 10 80    	mov    %edx,0x8010c604
		}
		deallocNode(minNode);
	}

	return p;
}
8010548e:	5e                   	pop    %esi
8010548f:	5f                   	pop    %edi
80105490:	5d                   	pop    %ebp
80105491:	c3                   	ret    
80105492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	deallocLink(first);
	
	first = next;

	if(isEmpty())
		last = null;
80105498:	c7 42 0c 00 00 00 00 	movl   $0x0,0xc(%edx)
8010549f:	8b 1e                	mov    (%esi),%ebx
801054a1:	eb af                	jmp    80105452 <_ZN3Map10extractMinEv+0x52>

	Proc *p = minNode->dequeue();
	
	if(minNode->isEmpty()) {
		if(minNode == root) {
			root = minNode->right;
801054a3:	8b 4a 1c             	mov    0x1c(%edx),%ecx
			if(!isEmpty())
801054a6:	85 c9                	test   %ecx,%ecx

	Proc *p = minNode->dequeue();
	
	if(minNode->isEmpty()) {
		if(minNode == root) {
			root = minNode->right;
801054a8:	89 0e                	mov    %ecx,(%esi)
			if(!isEmpty())
801054aa:	74 bd                	je     80105469 <_ZN3Map10extractMinEv+0x69>
				root->parent = null;
801054ac:	c7 41 14 00 00 00 00 	movl   $0x0,0x14(%ecx)
801054b3:	eb b4                	jmp    80105469 <_ZN3Map10extractMinEv+0x69>
	return true;
}

Proc* Map::extractMin() {
	if(isEmpty())
		return null;
801054b5:	31 c0                	xor    %eax,%eax
801054b7:	eb 92                	jmp    8010544b <_ZN3Map10extractMinEv+0x4b>
801054b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801054c0 <extractMinPriorityQueue>:

static boolean getMinAccumulatorPriorityQueue(long long* pkey) {
	return priorityQ->getMinKey(pkey);
}

static Proc* extractMinPriorityQueue() {
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	83 ec 04             	sub    $0x4,%esp
	return priorityQ->extractMin();
801054c6:	a1 14 c6 10 80       	mov    0x8010c614,%eax
801054cb:	89 04 24             	mov    %eax,(%esp)
801054ce:	e8 2d ff ff ff       	call   80105400 <_ZN3Map10extractMinEv>
}
801054d3:	c9                   	leave  
801054d4:	c3                   	ret    
801054d5:	90                   	nop
801054d6:	8d 76 00             	lea    0x0(%esi),%esi
801054d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054e0 <_ZN3Map8transferEv.part.1>:
	}

	return p;
}

bool Map::transfer() {
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	56                   	push   %esi
801054e4:	53                   	push   %ebx
801054e5:	83 ec 08             	sub    $0x8,%esp
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
801054e8:	8b 10                	mov    (%eax),%edx
801054ea:	8b 35 10 c6 10 80    	mov    0x8010c610,%esi
801054f0:	85 d2                	test   %edx,%edx
801054f2:	74 26                	je     8010551a <_ZN3Map8transferEv.part.1+0x3a>
801054f4:	89 c3                	mov    %eax,%ebx
801054f6:	8d 76 00             	lea    0x0(%esi),%esi
801054f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		Proc* p = extractMin();
80105500:	89 1c 24             	mov    %ebx,(%esp)
80105503:	e8 f8 fe ff ff       	call   80105400 <_ZN3Map10extractMinEv>
		roundRobinQ->enqueue(p); //should succeed.
80105508:	89 34 24             	mov    %esi,(%esp)
8010550b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010550f:	e8 3c f9 ff ff       	call   80104e50 <_ZN10LinkedList7enqueueEP4proc>

bool Map::transfer() {
	if(!roundRobinQ->isEmpty())
		return false;

	while(!isEmpty()) {
80105514:	8b 03                	mov    (%ebx),%eax
80105516:	85 c0                	test   %eax,%eax
80105518:	75 e6                	jne    80105500 <_ZN3Map8transferEv.part.1+0x20>
		Proc* p = extractMin();
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
8010551a:	83 c4 08             	add    $0x8,%esp
8010551d:	b0 01                	mov    $0x1,%al
8010551f:	5b                   	pop    %ebx
80105520:	5e                   	pop    %esi
80105521:	5d                   	pop    %ebp
80105522:	c3                   	ret    
80105523:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105530 <switchToRoundRobinPolicyPriorityQueue>:

	return p;
}

bool Map::transfer() {
	if(!roundRobinQ->isEmpty())
80105530:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
80105536:	8b 02                	mov    (%edx),%eax
80105538:	85 c0                	test   %eax,%eax
8010553a:	74 04                	je     80105540 <switchToRoundRobinPolicyPriorityQueue+0x10>
8010553c:	31 c0                	xor    %eax,%eax
8010553e:	c3                   	ret    
8010553f:	90                   	nop
80105540:	a1 14 c6 10 80       	mov    0x8010c614,%eax

static Proc* extractMinPriorityQueue() {
	return priorityQ->extractMin();
}

static boolean switchToRoundRobinPolicyPriorityQueue() {
80105545:	55                   	push   %ebp
80105546:	89 e5                	mov    %esp,%ebp
80105548:	e8 93 ff ff ff       	call   801054e0 <_ZN3Map8transferEv.part.1>
	return priorityQ->transfer();
}
8010554d:	5d                   	pop    %ebp
8010554e:	0f b6 c0             	movzbl %al,%eax
80105551:	c3                   	ret    
80105552:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105560 <_ZN3Map8transferEv>:

	return ans;
}

bool LinkedList::isEmpty() {
	return !first;
80105560:	8b 15 10 c6 10 80    	mov    0x8010c610,%edx
	}

	return p;
}

bool Map::transfer() {
80105566:	55                   	push   %ebp
80105567:	89 e5                	mov    %esp,%ebp
80105569:	8b 45 08             	mov    0x8(%ebp),%eax
	if(!roundRobinQ->isEmpty())
8010556c:	8b 12                	mov    (%edx),%edx
8010556e:	85 d2                	test   %edx,%edx
80105570:	74 0e                	je     80105580 <_ZN3Map8transferEv+0x20>
		Proc* p = extractMin();
		roundRobinQ->enqueue(p); //should succeed.
	}

	return true;
}
80105572:	31 c0                	xor    %eax,%eax
80105574:	5d                   	pop    %ebp
80105575:	c3                   	ret    
80105576:	8d 76 00             	lea    0x0(%esi),%esi
80105579:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105580:	5d                   	pop    %ebp
80105581:	e9 5a ff ff ff       	jmp    801054e0 <_ZN3Map8transferEv.part.1>
80105586:	8d 76 00             	lea    0x0(%esi),%esi
80105589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105590 <_ZN3Map11extractProcEP4proc>:

bool Map::extractProc(Proc *p) {
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	57                   	push   %edi
80105594:	56                   	push   %esi
80105595:	53                   	push   %ebx
80105596:	83 ec 2c             	sub    $0x2c,%esp
	if(!freeNodes)
80105599:	8b 15 04 c6 10 80    	mov    0x8010c604,%edx
	}

	return true;
}

bool Map::extractProc(Proc *p) {
8010559f:	8b 75 08             	mov    0x8(%ebp),%esi
801055a2:	8b 7d 0c             	mov    0xc(%ebp),%edi
	if(!freeNodes)
801055a5:	85 d2                	test   %edx,%edx
801055a7:	74 48                	je     801055f1 <_ZN3Map11extractProcEP4proc+0x61>
	MapNode *next, *parent, *left, *right;
};

class Map {
public:
	Map(): root(null) {}
801055a9:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		return false;

	bool ans = false;
801055b0:	31 db                	xor    %ebx,%ebx
801055b2:	eb 12                	jmp    801055c6 <_ZN3Map11extractProcEP4proc+0x36>
801055b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
801055b8:	89 34 24             	mov    %esi,(%esp)
801055bb:	e8 40 fe ff ff       	call   80105400 <_ZN3Map10extractMinEv>
		if(otherP != p)
801055c0:	39 f8                	cmp    %edi,%eax
801055c2:	75 1c                	jne    801055e0 <_ZN3Map11extractProcEP4proc+0x50>
			tempMap.put(otherP); //should scucceed.
		else ans = true;
801055c4:	b3 01                	mov    $0x1,%bl
	if(!freeNodes)
		return false;

	bool ans = false;
	Map tempMap;
	while(!isEmpty()) {
801055c6:	8b 06                	mov    (%esi),%eax
801055c8:	85 c0                	test   %eax,%eax
801055ca:	75 ec                	jne    801055b8 <_ZN3Map11extractProcEP4proc+0x28>
		Proc *otherP = extractMin();
		if(otherP != p)
			tempMap.put(otherP); //should scucceed.
		else ans = true;
	}
	root = tempMap.root;
801055cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801055cf:	89 06                	mov    %eax,(%esi)
	return ans;
}
801055d1:	83 c4 2c             	add    $0x2c,%esp
		Proc *otherP = extractMin();
		if(otherP != p)
			tempMap.put(otherP); //should scucceed.
		else ans = true;
	}
	root = tempMap.root;
801055d4:	88 d8                	mov    %bl,%al
	return ans;
}
801055d6:	5b                   	pop    %ebx
801055d7:	5e                   	pop    %esi
801055d8:	5f                   	pop    %edi
801055d9:	5d                   	pop    %ebp
801055da:	c3                   	ret    
801055db:	90                   	nop
801055dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	bool ans = false;
	Map tempMap;
	while(!isEmpty()) {
		Proc *otherP = extractMin();
		if(otherP != p)
			tempMap.put(otherP); //should scucceed.
801055e0:	89 44 24 04          	mov    %eax,0x4(%esp)
801055e4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055e7:	89 04 24             	mov    %eax,(%esp)
801055ea:	e8 51 fd ff ff       	call   80105340 <_ZN3Map3putEP4proc>
801055ef:	eb d5                	jmp    801055c6 <_ZN3Map11extractProcEP4proc+0x36>
		else ans = true;
	}
	root = tempMap.root;
	return ans;
}
801055f1:	83 c4 2c             	add    $0x2c,%esp
	return true;
}

bool Map::extractProc(Proc *p) {
	if(!freeNodes)
		return false;
801055f4:	31 c0                	xor    %eax,%eax
			tempMap.put(otherP); //should scucceed.
		else ans = true;
	}
	root = tempMap.root;
	return ans;
}
801055f6:	5b                   	pop    %ebx
801055f7:	5e                   	pop    %esi
801055f8:	5f                   	pop    %edi
801055f9:	5d                   	pop    %ebp
801055fa:	c3                   	ret    
801055fb:	90                   	nop
801055fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105600 <extractProcPriorityQueue>:

static boolean switchToRoundRobinPolicyPriorityQueue() {
	return priorityQ->transfer();
}

static boolean extractProcPriorityQueue(Proc *p) {
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	83 ec 18             	sub    $0x18,%esp
	return priorityQ->extractProc(p);
80105606:	8b 45 08             	mov    0x8(%ebp),%eax
80105609:	89 44 24 04          	mov    %eax,0x4(%esp)
8010560d:	a1 14 c6 10 80       	mov    0x8010c614,%eax
80105612:	89 04 24             	mov    %eax,(%esp)
80105615:	e8 76 ff ff ff       	call   80105590 <_ZN3Map11extractProcEP4proc>
}
8010561a:	c9                   	leave  
static boolean switchToRoundRobinPolicyPriorityQueue() {
	return priorityQ->transfer();
}

static boolean extractProcPriorityQueue(Proc *p) {
	return priorityQ->extractProc(p);
8010561b:	0f b6 c0             	movzbl %al,%eax
}
8010561e:	c3                   	ret    
8010561f:	90                   	nop

80105620 <__moddi3>:
	}
	root = tempMap.root;
	return ans;
}

long long __moddi3(long long number, long long divisor) { //returns number%divisor
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	57                   	push   %edi
80105624:	56                   	push   %esi
80105625:	53                   	push   %ebx
80105626:	83 ec 2c             	sub    $0x2c,%esp
80105629:	8b 45 08             	mov    0x8(%ebp),%eax
8010562c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010562f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105632:	8b 45 10             	mov    0x10(%ebp),%eax
80105635:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80105638:	8b 55 14             	mov    0x14(%ebp),%edx
8010563b:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010563e:	89 d7                	mov    %edx,%edi
	if(divisor == 0)
80105640:	09 c2                	or     %eax,%edx
80105642:	0f 84 9d 00 00 00    	je     801056e5 <__moddi3+0xc5>
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
80105648:	8b 45 e4             	mov    -0x1c(%ebp),%eax

long long __moddi3(long long number, long long divisor) { //returns number%divisor
	if(divisor == 0)
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
8010564b:	c6 45 df 00          	movb   $0x0,-0x21(%ebp)
	if(number < 0) {
8010564f:	85 c0                	test   %eax,%eax
80105651:	78 7f                	js     801056d2 <__moddi3+0xb2>
80105653:	8b 55 d8             	mov    -0x28(%ebp),%edx
80105656:	89 f8                	mov    %edi,%eax
80105658:	c1 ff 1f             	sar    $0x1f,%edi
8010565b:	31 f8                	xor    %edi,%eax
8010565d:	89 f9                	mov    %edi,%ecx
8010565f:	31 fa                	xor    %edi,%edx
80105661:	89 c7                	mov    %eax,%edi
80105663:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105666:	89 d6                	mov    %edx,%esi
80105668:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010566b:	29 ce                	sub    %ecx,%esi
8010566d:	19 cf                	sbb    %ecx,%edi
8010566f:	90                   	nop
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
80105670:	39 fa                	cmp    %edi,%edx
80105672:	7d 1c                	jge    80105690 <__moddi3+0x70>
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
			return isNumberNegative ? -number : number;
80105674:	80 7d df 00          	cmpb   $0x0,-0x21(%ebp)
80105678:	74 07                	je     80105681 <__moddi3+0x61>
8010567a:	f7 d8                	neg    %eax
8010567c:	83 d2 00             	adc    $0x0,%edx
8010567f:	f7 da                	neg    %edx
	}
}
80105681:	83 c4 2c             	add    $0x2c,%esp
80105684:	5b                   	pop    %ebx
80105685:	5e                   	pop    %esi
80105686:	5f                   	pop    %edi
80105687:	5d                   	pop    %ebp
80105688:	c3                   	ret    
80105689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
80105690:	7f 04                	jg     80105696 <__moddi3+0x76>
80105692:	39 f0                	cmp    %esi,%eax
80105694:	72 de                	jb     80105674 <__moddi3+0x54>
80105696:	89 f1                	mov    %esi,%ecx
80105698:	89 fb                	mov    %edi,%ebx
8010569a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			number -= divisor2;
801056a0:	29 c8                	sub    %ecx,%eax
801056a2:	19 da                	sbb    %ebx,%edx
			if(divisor2 + divisor2 > 0) //exponential decay.
801056a4:	0f a4 cb 01          	shld   $0x1,%ecx,%ebx
801056a8:	01 c9                	add    %ecx,%ecx
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
801056aa:	39 da                	cmp    %ebx,%edx
801056ac:	7f f2                	jg     801056a0 <__moddi3+0x80>
801056ae:	7d 18                	jge    801056c8 <__moddi3+0xa8>
			number -= divisor2;
			if(divisor2 + divisor2 > 0) //exponential decay.
				divisor2 += divisor2;
		}

		if(number < divisor)
801056b0:	39 d7                	cmp    %edx,%edi
801056b2:	7c bc                	jl     80105670 <__moddi3+0x50>
801056b4:	7f be                	jg     80105674 <__moddi3+0x54>
801056b6:	39 c6                	cmp    %eax,%esi
801056b8:	76 b6                	jbe    80105670 <__moddi3+0x50>
801056ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801056c0:	eb b2                	jmp    80105674 <__moddi3+0x54>
801056c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
	if(divisor < 0)
		divisor = -divisor;

	for(;;) {
		long long divisor2 = divisor;
		while(number >= divisor2) {
801056c8:	39 c8                	cmp    %ecx,%eax
801056ca:	73 d4                	jae    801056a0 <__moddi3+0x80>
801056cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056d0:	eb de                	jmp    801056b0 <__moddi3+0x90>
	if(divisor == 0)
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
		number = -number;
801056d2:	f7 5d e0             	negl   -0x20(%ebp)
		isNumberNegative = true;
801056d5:	c6 45 df 01          	movb   $0x1,-0x21(%ebp)
	if(divisor == 0)
		panic((char*)"divide by zero!!!\n");

	bool isNumberNegative = false;
	if(number < 0) {
		number = -number;
801056d9:	83 55 e4 00          	adcl   $0x0,-0x1c(%ebp)
801056dd:	f7 5d e4             	negl   -0x1c(%ebp)
801056e0:	e9 6e ff ff ff       	jmp    80105653 <__moddi3+0x33>
	return ans;
}

long long __moddi3(long long number, long long divisor) { //returns number%divisor
	if(divisor == 0)
		panic((char*)"divide by zero!!!\n");
801056e5:	c7 04 24 dc 8d 10 80 	movl   $0x80108ddc,(%esp)
801056ec:	e8 4f ac ff ff       	call   80100340 <panic>
801056f1:	90                   	nop
801056f2:	66 90                	xchg   %ax,%ax
801056f4:	66 90                	xchg   %ax,%ax
801056f6:	66 90                	xchg   %ax,%ax
801056f8:	66 90                	xchg   %ax,%ax
801056fa:	66 90                	xchg   %ax,%ax
801056fc:	66 90                	xchg   %ax,%ax
801056fe:	66 90                	xchg   %ax,%ax

80105700 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105700:	55                   	push   %ebp
  initlock(&lk->lk, "sleep lock");
80105701:	b8 ef 8d 10 80       	mov    $0x80108def,%eax
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105706:	89 e5                	mov    %esp,%ebp
80105708:	53                   	push   %ebx
80105709:	83 ec 14             	sub    $0x14,%esp
8010570c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010570f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105713:	8d 43 04             	lea    0x4(%ebx),%eax
80105716:	89 04 24             	mov    %eax,(%esp)
80105719:	e8 12 01 00 00       	call   80105830 <initlock>
  lk->name = name;
8010571e:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80105721:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80105727:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
8010572e:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
80105731:	83 c4 14             	add    $0x14,%esp
80105734:	5b                   	pop    %ebx
80105735:	5d                   	pop    %ebp
80105736:	c3                   	ret    
80105737:	89 f6                	mov    %esi,%esi
80105739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105740 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
80105743:	56                   	push   %esi
80105744:	53                   	push   %ebx
80105745:	83 ec 10             	sub    $0x10,%esp
80105748:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010574b:	8d 73 04             	lea    0x4(%ebx),%esi
8010574e:	89 34 24             	mov    %esi,(%esp)
80105751:	e8 3a 02 00 00       	call   80105990 <acquire>
  while (lk->locked) {
80105756:	8b 13                	mov    (%ebx),%edx
80105758:	85 d2                	test   %edx,%edx
8010575a:	74 16                	je     80105772 <acquiresleep+0x32>
8010575c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80105760:	89 74 24 04          	mov    %esi,0x4(%esp)
80105764:	89 1c 24             	mov    %ebx,(%esp)
80105767:	e8 b4 eb ff ff       	call   80104320 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010576c:	8b 03                	mov    (%ebx),%eax
8010576e:	85 c0                	test   %eax,%eax
80105770:	75 ee                	jne    80105760 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80105772:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105778:	e8 e3 e1 ff ff       	call   80103960 <myproc>
8010577d:	8b 40 10             	mov    0x10(%eax),%eax
80105780:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105783:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105786:	83 c4 10             	add    $0x10,%esp
80105789:	5b                   	pop    %ebx
8010578a:	5e                   	pop    %esi
8010578b:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010578c:	e9 9f 02 00 00       	jmp    80105a30 <release>
80105791:	eb 0d                	jmp    801057a0 <releasesleep>
80105793:	90                   	nop
80105794:	90                   	nop
80105795:	90                   	nop
80105796:	90                   	nop
80105797:	90                   	nop
80105798:	90                   	nop
80105799:	90                   	nop
8010579a:	90                   	nop
8010579b:	90                   	nop
8010579c:	90                   	nop
8010579d:	90                   	nop
8010579e:	90                   	nop
8010579f:	90                   	nop

801057a0 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	83 ec 18             	sub    $0x18,%esp
801057a6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801057a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801057ac:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
801057af:	8d 73 04             	lea    0x4(%ebx),%esi
801057b2:	89 34 24             	mov    %esi,(%esp)
801057b5:	e8 d6 01 00 00       	call   80105990 <acquire>
  lk->locked = 0;
801057ba:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801057c0:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801057c7:	89 1c 24             	mov    %ebx,(%esp)
801057ca:	e8 51 ed ff ff       	call   80104520 <wakeup>
  release(&lk->lk);
}
801057cf:	8b 5d f8             	mov    -0x8(%ebp),%ebx
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
801057d2:	89 75 08             	mov    %esi,0x8(%ebp)
}
801057d5:	8b 75 fc             	mov    -0x4(%ebp),%esi
801057d8:	89 ec                	mov    %ebp,%esp
801057da:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
801057db:	e9 50 02 00 00       	jmp    80105a30 <release>

801057e0 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	83 ec 28             	sub    $0x28,%esp
801057e6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801057e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801057ec:	89 7d fc             	mov    %edi,-0x4(%ebp)
801057ef:	89 75 f8             	mov    %esi,-0x8(%ebp)
801057f2:	31 f6                	xor    %esi,%esi
  int r;
  
  acquire(&lk->lk);
801057f4:	8d 7b 04             	lea    0x4(%ebx),%edi
801057f7:	89 3c 24             	mov    %edi,(%esp)
801057fa:	e8 91 01 00 00       	call   80105990 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801057ff:	8b 03                	mov    (%ebx),%eax
80105801:	85 c0                	test   %eax,%eax
80105803:	74 11                	je     80105816 <holdingsleep+0x36>
80105805:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80105808:	e8 53 e1 ff ff       	call   80103960 <myproc>
8010580d:	39 58 10             	cmp    %ebx,0x10(%eax)
80105810:	0f 94 c0             	sete   %al
80105813:	0f b6 f0             	movzbl %al,%esi
  release(&lk->lk);
80105816:	89 3c 24             	mov    %edi,(%esp)
80105819:	e8 12 02 00 00       	call   80105a30 <release>
  return r;
}
8010581e:	89 f0                	mov    %esi,%eax
80105820:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105823:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105826:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105829:	89 ec                	mov    %ebp,%esp
8010582b:	5d                   	pop    %ebp
8010582c:	c3                   	ret    
8010582d:	66 90                	xchg   %ax,%ax
8010582f:	90                   	nop

80105830 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80105836:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80105839:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
8010583f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80105842:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105849:	5d                   	pop    %ebp
8010584a:	c3                   	ret    
8010584b:	90                   	nop
8010584c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105850 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105850:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105851:	31 d2                	xor    %edx,%edx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105853:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80105855:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105858:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010585b:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010585c:	83 e8 08             	sub    $0x8,%eax
8010585f:	90                   	nop
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105860:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80105866:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010586c:	77 12                	ja     80105880 <getcallerpcs+0x30>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010586e:	8b 58 04             	mov    0x4(%eax),%ebx
80105871:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105874:	42                   	inc    %edx
80105875:	83 fa 0a             	cmp    $0xa,%edx
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80105878:	8b 00                	mov    (%eax),%eax
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
8010587a:	75 e4                	jne    80105860 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010587c:	5b                   	pop    %ebx
8010587d:	5d                   	pop    %ebp
8010587e:	c3                   	ret    
8010587f:	90                   	nop
80105880:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80105883:	8d 51 28             	lea    0x28(%ecx),%edx
80105886:	8d 76 00             	lea    0x0(%esi),%esi
80105889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80105890:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105896:	83 c0 04             	add    $0x4,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105899:	39 d0                	cmp    %edx,%eax
8010589b:	75 f3                	jne    80105890 <getcallerpcs+0x40>
    pcs[i] = 0;
}
8010589d:	5b                   	pop    %ebx
8010589e:	5d                   	pop    %ebp
8010589f:	c3                   	ret    

801058a0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	53                   	push   %ebx
801058a4:	83 ec 04             	sub    $0x4,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801058a7:	9c                   	pushf  
801058a8:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
801058a9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801058aa:	e8 11 e0 ff ff       	call   801038c0 <mycpu>
801058af:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801058b5:	85 d2                	test   %edx,%edx
801058b7:	75 11                	jne    801058ca <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
801058b9:	e8 02 e0 ff ff       	call   801038c0 <mycpu>
801058be:	81 e3 00 02 00 00    	and    $0x200,%ebx
801058c4:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
801058ca:	e8 f1 df ff ff       	call   801038c0 <mycpu>
801058cf:	ff 80 a4 00 00 00    	incl   0xa4(%eax)
}
801058d5:	58                   	pop    %eax
801058d6:	5b                   	pop    %ebx
801058d7:	5d                   	pop    %ebp
801058d8:	c3                   	ret    
801058d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058e0 <popcli>:

void
popcli(void)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801058e6:	9c                   	pushf  
801058e7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801058e8:	f6 c4 02             	test   $0x2,%ah
801058eb:	75 51                	jne    8010593e <popcli+0x5e>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801058ed:	e8 ce df ff ff       	call   801038c0 <mycpu>
801058f2:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
801058f8:	8d 51 ff             	lea    -0x1(%ecx),%edx
801058fb:	85 d2                	test   %edx,%edx
801058fd:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80105903:	78 2d                	js     80105932 <popcli+0x52>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105905:	e8 b6 df ff ff       	call   801038c0 <mycpu>
8010590a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105910:	85 d2                	test   %edx,%edx
80105912:	74 0c                	je     80105920 <popcli+0x40>
    sti();
}
80105914:	c9                   	leave  
80105915:	c3                   	ret    
80105916:	8d 76 00             	lea    0x0(%esi),%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105920:	e8 9b df ff ff       	call   801038c0 <mycpu>
80105925:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010592b:	85 c0                	test   %eax,%eax
8010592d:	74 e5                	je     80105914 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
8010592f:	fb                   	sti    
    sti();
}
80105930:	c9                   	leave  
80105931:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
80105932:	c7 04 24 11 8e 10 80 	movl   $0x80108e11,(%esp)
80105939:	e8 02 aa ff ff       	call   80100340 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
8010593e:	c7 04 24 fa 8d 10 80 	movl   $0x80108dfa,(%esp)
80105945:	e8 f6 a9 ff ff       	call   80100340 <panic>
8010594a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105950 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	83 ec 08             	sub    $0x8,%esp
80105956:	89 75 fc             	mov    %esi,-0x4(%ebp)
80105959:	8b 75 08             	mov    0x8(%ebp),%esi
8010595c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010595f:	31 db                	xor    %ebx,%ebx
  int r;
  pushcli();
80105961:	e8 3a ff ff ff       	call   801058a0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105966:	8b 06                	mov    (%esi),%eax
80105968:	85 c0                	test   %eax,%eax
8010596a:	74 10                	je     8010597c <holding+0x2c>
8010596c:	8b 5e 08             	mov    0x8(%esi),%ebx
8010596f:	e8 4c df ff ff       	call   801038c0 <mycpu>
80105974:	39 c3                	cmp    %eax,%ebx
80105976:	0f 94 c3             	sete   %bl
80105979:	0f b6 db             	movzbl %bl,%ebx
  popcli();
8010597c:	e8 5f ff ff ff       	call   801058e0 <popcli>
  return r;
}
80105981:	89 d8                	mov    %ebx,%eax
80105983:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105986:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105989:	89 ec                	mov    %ebp,%esp
8010598b:	5d                   	pop    %ebp
8010598c:	c3                   	ret    
8010598d:	8d 76 00             	lea    0x0(%esi),%esi

80105990 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	56                   	push   %esi
80105994:	53                   	push   %ebx
80105995:	83 ec 10             	sub    $0x10,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105998:	e8 03 ff ff ff       	call   801058a0 <pushcli>
  if(holding(lk))
8010599d:	8b 5d 08             	mov    0x8(%ebp),%ebx
801059a0:	89 1c 24             	mov    %ebx,(%esp)
801059a3:	e8 a8 ff ff ff       	call   80105950 <holding>
801059a8:	85 c0                	test   %eax,%eax
801059aa:	75 78                	jne    80105a24 <acquire+0x94>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801059ac:	ba 01 00 00 00       	mov    $0x1,%edx
801059b1:	eb 08                	jmp    801059bb <acquire+0x2b>
801059b3:	90                   	nop
801059b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059b8:	8b 5d 08             	mov    0x8(%ebp),%ebx
801059bb:	89 d0                	mov    %edx,%eax
801059bd:	f0 87 03             	lock xchg %eax,(%ebx)
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
801059c0:	85 c0                	test   %eax,%eax
801059c2:	75 f4                	jne    801059b8 <acquire+0x28>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
801059c4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801059c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801059cc:	e8 ef de ff ff       	call   801038c0 <mycpu>
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801059d1:	89 ea                	mov    %ebp,%edx
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
801059d3:	8d 73 0c             	lea    0xc(%ebx),%esi
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
801059d6:	89 43 08             	mov    %eax,0x8(%ebx)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801059d9:	31 c0                	xor    %eax,%eax
801059db:	90                   	nop
801059dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801059e0:	8d 8a 00 00 00 80    	lea    -0x80000000(%edx),%ecx
801059e6:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
801059ec:	77 1a                	ja     80105a08 <acquire+0x78>
      break;
    pcs[i] = ebp[1];     // saved %eip
801059ee:	8b 4a 04             	mov    0x4(%edx),%ecx
801059f1:	89 0c 86             	mov    %ecx,(%esi,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801059f4:	40                   	inc    %eax
801059f5:	83 f8 0a             	cmp    $0xa,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801059f8:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801059fa:	75 e4                	jne    801059e0 <acquire+0x50>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
801059fc:	83 c4 10             	add    $0x10,%esp
801059ff:	5b                   	pop    %ebx
80105a00:	5e                   	pop    %esi
80105a01:	5d                   	pop    %ebp
80105a02:	c3                   	ret    
80105a03:	90                   	nop
80105a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a08:	8d 04 86             	lea    (%esi,%eax,4),%eax
80105a0b:	8d 53 34             	lea    0x34(%ebx),%edx
80105a0e:	66 90                	xchg   %ax,%ax
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80105a10:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105a16:	83 c0 04             	add    $0x4,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105a19:	39 d0                	cmp    %edx,%eax
80105a1b:	75 f3                	jne    80105a10 <acquire+0x80>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
  getcallerpcs(&lk, lk->pcs);
}
80105a1d:	83 c4 10             	add    $0x10,%esp
80105a20:	5b                   	pop    %ebx
80105a21:	5e                   	pop    %esi
80105a22:	5d                   	pop    %ebp
80105a23:	c3                   	ret    
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80105a24:	c7 04 24 18 8e 10 80 	movl   $0x80108e18,(%esp)
80105a2b:	e8 10 a9 ff ff       	call   80100340 <panic>

80105a30 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80105a30:	55                   	push   %ebp
80105a31:	89 e5                	mov    %esp,%ebp
80105a33:	53                   	push   %ebx
80105a34:	83 ec 14             	sub    $0x14,%esp
80105a37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80105a3a:	89 1c 24             	mov    %ebx,(%esp)
80105a3d:	e8 0e ff ff ff       	call   80105950 <holding>
80105a42:	85 c0                	test   %eax,%eax
80105a44:	74 23                	je     80105a69 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
80105a46:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105a4d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80105a54:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80105a59:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
80105a5f:	83 c4 14             	add    $0x14,%esp
80105a62:	5b                   	pop    %ebx
80105a63:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
80105a64:	e9 77 fe ff ff       	jmp    801058e0 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80105a69:	c7 04 24 20 8e 10 80 	movl   $0x80108e20,(%esp)
80105a70:	e8 cb a8 ff ff       	call   80100340 <panic>
80105a75:	66 90                	xchg   %ax,%ax
80105a77:	66 90                	xchg   %ax,%ax
80105a79:	66 90                	xchg   %ax,%ax
80105a7b:	66 90                	xchg   %ax,%ax
80105a7d:	66 90                	xchg   %ax,%ax
80105a7f:	90                   	nop

80105a80 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
80105a83:	83 ec 08             	sub    $0x8,%esp
80105a86:	8b 55 08             	mov    0x8(%ebp),%edx
80105a89:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105a8c:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105a8f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if ((int)dst%4 == 0 && n%4 == 0){
80105a92:	f6 c2 03             	test   $0x3,%dl
80105a95:	75 05                	jne    80105a9c <memset+0x1c>
80105a97:	f6 c1 03             	test   $0x3,%cl
80105a9a:	74 14                	je     80105ab0 <memset+0x30>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80105a9c:	89 d7                	mov    %edx,%edi
80105a9e:	8b 45 0c             	mov    0xc(%ebp),%eax
80105aa1:	fc                   	cld    
80105aa2:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105aa4:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105aa7:	89 d0                	mov    %edx,%eax
80105aa9:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105aac:	89 ec                	mov    %ebp,%esp
80105aae:	5d                   	pop    %ebp
80105aaf:	c3                   	ret    

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80105ab0:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
80105ab4:	c1 e9 02             	shr    $0x2,%ecx
80105ab7:	89 fb                	mov    %edi,%ebx
80105ab9:	89 f8                	mov    %edi,%eax
80105abb:	c1 e3 18             	shl    $0x18,%ebx
80105abe:	c1 e0 10             	shl    $0x10,%eax
80105ac1:	09 d8                	or     %ebx,%eax
80105ac3:	09 f8                	or     %edi,%eax
80105ac5:	c1 e7 08             	shl    $0x8,%edi
80105ac8:	09 f8                	or     %edi,%eax
80105aca:	89 d7                	mov    %edx,%edi
80105acc:	fc                   	cld    
80105acd:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80105acf:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105ad2:	89 d0                	mov    %edx,%eax
80105ad4:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105ad7:	89 ec                	mov    %ebp,%esp
80105ad9:	5d                   	pop    %ebp
80105ada:	c3                   	ret    
80105adb:	90                   	nop
80105adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ae0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
80105ae3:	8b 45 10             	mov    0x10(%ebp),%eax
80105ae6:	57                   	push   %edi
80105ae7:	56                   	push   %esi
80105ae8:	8b 75 0c             	mov    0xc(%ebp),%esi
80105aeb:	53                   	push   %ebx
80105aec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105aef:	85 c0                	test   %eax,%eax
80105af1:	74 27                	je     80105b1a <memcmp+0x3a>
    if(*s1 != *s2)
80105af3:	0f b6 13             	movzbl (%ebx),%edx
80105af6:	0f b6 0e             	movzbl (%esi),%ecx
80105af9:	38 d1                	cmp    %dl,%cl
80105afb:	75 2b                	jne    80105b28 <memcmp+0x48>
80105afd:	8d 78 ff             	lea    -0x1(%eax),%edi
80105b00:	31 c0                	xor    %eax,%eax
80105b02:	eb 12                	jmp    80105b16 <memcmp+0x36>
80105b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b08:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
80105b0d:	40                   	inc    %eax
80105b0e:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105b12:	38 ca                	cmp    %cl,%dl
80105b14:	75 12                	jne    80105b28 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105b16:	39 f8                	cmp    %edi,%eax
80105b18:	75 ee                	jne    80105b08 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80105b1a:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80105b1b:	31 c0                	xor    %eax,%eax
}
80105b1d:	5e                   	pop    %esi
80105b1e:	5f                   	pop    %edi
80105b1f:	5d                   	pop    %ebp
80105b20:	c3                   	ret    
80105b21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b28:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80105b29:	0f b6 c2             	movzbl %dl,%eax
80105b2c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
80105b2e:	5e                   	pop    %esi
80105b2f:	5f                   	pop    %edi
80105b30:	5d                   	pop    %ebp
80105b31:	c3                   	ret    
80105b32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b40 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105b40:	55                   	push   %ebp
80105b41:	89 e5                	mov    %esp,%ebp
80105b43:	8b 45 08             	mov    0x8(%ebp),%eax
80105b46:	56                   	push   %esi
80105b47:	8b 75 0c             	mov    0xc(%ebp),%esi
80105b4a:	53                   	push   %ebx
80105b4b:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105b4e:	39 c6                	cmp    %eax,%esi
80105b50:	73 36                	jae    80105b88 <memmove+0x48>
80105b52:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80105b55:	39 c8                	cmp    %ecx,%eax
80105b57:	73 2f                	jae    80105b88 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
80105b59:	85 db                	test   %ebx,%ebx
80105b5b:	8d 53 ff             	lea    -0x1(%ebx),%edx
80105b5e:	74 1d                	je     80105b7d <memmove+0x3d>
      *--d = *--s;
80105b60:	29 d9                	sub    %ebx,%ecx
80105b62:	89 cb                	mov    %ecx,%ebx
80105b64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105b6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
80105b70:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80105b74:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80105b77:	4a                   	dec    %edx
80105b78:	83 fa ff             	cmp    $0xffffffff,%edx
80105b7b:	75 f3                	jne    80105b70 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105b7d:	5b                   	pop    %ebx
80105b7e:	5e                   	pop    %esi
80105b7f:	5d                   	pop    %ebp
80105b80:	c3                   	ret    
80105b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105b88:	31 d2                	xor    %edx,%edx
80105b8a:	85 db                	test   %ebx,%ebx
80105b8c:	74 ef                	je     80105b7d <memmove+0x3d>
80105b8e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80105b90:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80105b94:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80105b97:	42                   	inc    %edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80105b98:	39 d3                	cmp    %edx,%ebx
80105b9a:	75 f4                	jne    80105b90 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
80105b9c:	5b                   	pop    %ebx
80105b9d:	5e                   	pop    %esi
80105b9e:	5d                   	pop    %ebp
80105b9f:	c3                   	ret    

80105ba0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105ba0:	55                   	push   %ebp
80105ba1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80105ba3:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80105ba4:	eb 9a                	jmp    80105b40 <memmove>
80105ba6:	8d 76 00             	lea    0x0(%esi),%esi
80105ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105bb0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
80105bb3:	57                   	push   %edi
80105bb4:	8b 7d 08             	mov    0x8(%ebp),%edi
80105bb7:	56                   	push   %esi
80105bb8:	8b 75 0c             	mov    0xc(%ebp),%esi
80105bbb:	53                   	push   %ebx
80105bbc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
80105bbf:	85 db                	test   %ebx,%ebx
80105bc1:	74 35                	je     80105bf8 <strncmp+0x48>
80105bc3:	0f b6 17             	movzbl (%edi),%edx
80105bc6:	0f b6 0e             	movzbl (%esi),%ecx
80105bc9:	84 d2                	test   %dl,%dl
80105bcb:	74 37                	je     80105c04 <strncmp+0x54>
80105bcd:	38 d1                	cmp    %dl,%cl
80105bcf:	75 33                	jne    80105c04 <strncmp+0x54>
80105bd1:	8d 47 01             	lea    0x1(%edi),%eax
80105bd4:	01 df                	add    %ebx,%edi
80105bd6:	eb 19                	jmp    80105bf1 <strncmp+0x41>
80105bd8:	90                   	nop
80105bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105be0:	0f b6 10             	movzbl (%eax),%edx
80105be3:	84 d2                	test   %dl,%dl
80105be5:	74 19                	je     80105c00 <strncmp+0x50>
80105be7:	0f b6 0b             	movzbl (%ebx),%ecx
80105bea:	40                   	inc    %eax
80105beb:	89 de                	mov    %ebx,%esi
80105bed:	38 ca                	cmp    %cl,%dl
80105bef:	75 13                	jne    80105c04 <strncmp+0x54>
80105bf1:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80105bf3:	8d 5e 01             	lea    0x1(%esi),%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80105bf6:	75 e8                	jne    80105be0 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80105bf8:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
80105bf9:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
80105bfb:	5e                   	pop    %esi
80105bfc:	5f                   	pop    %edi
80105bfd:	5d                   	pop    %ebp
80105bfe:	c3                   	ret    
80105bff:	90                   	nop
80105c00:	0f b6 4e 01          	movzbl 0x1(%esi),%ecx
80105c04:	5b                   	pop    %ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80105c05:	0f b6 c2             	movzbl %dl,%eax
80105c08:	29 c8                	sub    %ecx,%eax
}
80105c0a:	5e                   	pop    %esi
80105c0b:	5f                   	pop    %edi
80105c0c:	5d                   	pop    %ebp
80105c0d:	c3                   	ret    
80105c0e:	66 90                	xchg   %ax,%ax

80105c10 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105c10:	55                   	push   %ebp
80105c11:	89 e5                	mov    %esp,%ebp
80105c13:	8b 45 08             	mov    0x8(%ebp),%eax
80105c16:	56                   	push   %esi
80105c17:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105c1a:	53                   	push   %ebx
80105c1b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105c1e:	89 c2                	mov    %eax,%edx
80105c20:	eb 15                	jmp    80105c37 <strncpy+0x27>
80105c22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105c28:	46                   	inc    %esi
80105c29:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
80105c2d:	42                   	inc    %edx
80105c2e:	84 c9                	test   %cl,%cl
80105c30:	88 4a ff             	mov    %cl,-0x1(%edx)
80105c33:	74 09                	je     80105c3e <strncpy+0x2e>
80105c35:	89 d9                	mov    %ebx,%ecx
80105c37:	85 c9                	test   %ecx,%ecx
80105c39:	8d 59 ff             	lea    -0x1(%ecx),%ebx
80105c3c:	7f ea                	jg     80105c28 <strncpy+0x18>
    ;
  while(n-- > 0)
80105c3e:	31 c9                	xor    %ecx,%ecx
80105c40:	85 db                	test   %ebx,%ebx
80105c42:	7e 19                	jle    80105c5d <strncpy+0x4d>
80105c44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105c4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi
    *s++ = 0;
80105c50:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80105c54:	89 de                	mov    %ebx,%esi
80105c56:	41                   	inc    %ecx
80105c57:	29 ce                	sub    %ecx,%esi
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80105c59:	85 f6                	test   %esi,%esi
80105c5b:	7f f3                	jg     80105c50 <strncpy+0x40>
    *s++ = 0;
  return os;
}
80105c5d:	5b                   	pop    %ebx
80105c5e:	5e                   	pop    %esi
80105c5f:	5d                   	pop    %ebp
80105c60:	c3                   	ret    
80105c61:	eb 0d                	jmp    80105c70 <safestrcpy>
80105c63:	90                   	nop
80105c64:	90                   	nop
80105c65:	90                   	nop
80105c66:	90                   	nop
80105c67:	90                   	nop
80105c68:	90                   	nop
80105c69:	90                   	nop
80105c6a:	90                   	nop
80105c6b:	90                   	nop
80105c6c:	90                   	nop
80105c6d:	90                   	nop
80105c6e:	90                   	nop
80105c6f:	90                   	nop

80105c70 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105c70:	55                   	push   %ebp
80105c71:	89 e5                	mov    %esp,%ebp
80105c73:	8b 4d 10             	mov    0x10(%ebp),%ecx
80105c76:	56                   	push   %esi
80105c77:	8b 45 08             	mov    0x8(%ebp),%eax
80105c7a:	53                   	push   %ebx
80105c7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80105c7e:	85 c9                	test   %ecx,%ecx
80105c80:	7e 22                	jle    80105ca4 <safestrcpy+0x34>
80105c82:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80105c86:	89 c1                	mov    %eax,%ecx
80105c88:	eb 13                	jmp    80105c9d <safestrcpy+0x2d>
80105c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105c90:	42                   	inc    %edx
80105c91:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80105c95:	41                   	inc    %ecx
80105c96:	84 db                	test   %bl,%bl
80105c98:	88 59 ff             	mov    %bl,-0x1(%ecx)
80105c9b:	74 04                	je     80105ca1 <safestrcpy+0x31>
80105c9d:	39 f2                	cmp    %esi,%edx
80105c9f:	75 ef                	jne    80105c90 <safestrcpy+0x20>
    ;
  *s = 0;
80105ca1:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80105ca4:	5b                   	pop    %ebx
80105ca5:	5e                   	pop    %esi
80105ca6:	5d                   	pop    %ebp
80105ca7:	c3                   	ret    
80105ca8:	90                   	nop
80105ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105cb0 <strlen>:

int
strlen(const char *s)
{
80105cb0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105cb1:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80105cb3:	89 e5                	mov    %esp,%ebp
80105cb5:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80105cb8:	80 3a 00             	cmpb   $0x0,(%edx)
80105cbb:	74 0a                	je     80105cc7 <strlen+0x17>
80105cbd:	8d 76 00             	lea    0x0(%esi),%esi
80105cc0:	40                   	inc    %eax
80105cc1:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105cc5:	75 f9                	jne    80105cc0 <strlen+0x10>
    ;
  return n;
}
80105cc7:	5d                   	pop    %ebp
80105cc8:	c3                   	ret    

80105cc9 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105cc9:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105ccd:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80105cd1:	55                   	push   %ebp
  pushl %ebx
80105cd2:	53                   	push   %ebx
  pushl %esi
80105cd3:	56                   	push   %esi
  pushl %edi
80105cd4:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105cd5:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105cd7:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80105cd9:	5f                   	pop    %edi
  popl %esi
80105cda:	5e                   	pop    %esi
  popl %ebx
80105cdb:	5b                   	pop    %ebx
  popl %ebp
80105cdc:	5d                   	pop    %ebp
  ret
80105cdd:	c3                   	ret    
80105cde:	66 90                	xchg   %ax,%ax

80105ce0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105ce0:	55                   	push   %ebp
80105ce1:	89 e5                	mov    %esp,%ebp
80105ce3:	53                   	push   %ebx
80105ce4:	83 ec 04             	sub    $0x4,%esp
80105ce7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80105cea:	e8 71 dc ff ff       	call   80103960 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105cef:	8b 00                	mov    (%eax),%eax
80105cf1:	39 d8                	cmp    %ebx,%eax
80105cf3:	76 1b                	jbe    80105d10 <fetchint+0x30>
80105cf5:	8d 53 04             	lea    0x4(%ebx),%edx
80105cf8:	39 d0                	cmp    %edx,%eax
80105cfa:	72 14                	jb     80105d10 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105cfc:	8b 45 0c             	mov    0xc(%ebp),%eax
80105cff:	8b 13                	mov    (%ebx),%edx
80105d01:	89 10                	mov    %edx,(%eax)
  return 0;
80105d03:	31 c0                	xor    %eax,%eax
}
80105d05:	5a                   	pop    %edx
80105d06:	5b                   	pop    %ebx
80105d07:	5d                   	pop    %ebp
80105d08:	c3                   	ret    
80105d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80105d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d15:	eb ee                	jmp    80105d05 <fetchint+0x25>
80105d17:	89 f6                	mov    %esi,%esi
80105d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d20 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105d20:	55                   	push   %ebp
80105d21:	89 e5                	mov    %esp,%ebp
80105d23:	53                   	push   %ebx
80105d24:	83 ec 04             	sub    $0x4,%esp
80105d27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80105d2a:	e8 31 dc ff ff       	call   80103960 <myproc>

  if(addr >= curproc->sz)
80105d2f:	39 18                	cmp    %ebx,(%eax)
80105d31:	76 27                	jbe    80105d5a <fetchstr+0x3a>
    return -1;
  *pp = (char*)addr;
80105d33:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105d36:	89 da                	mov    %ebx,%edx
80105d38:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80105d3a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80105d3c:	39 c3                	cmp    %eax,%ebx
80105d3e:	73 1a                	jae    80105d5a <fetchstr+0x3a>
    if(*s == 0)
80105d40:	80 3b 00             	cmpb   $0x0,(%ebx)
80105d43:	75 10                	jne    80105d55 <fetchstr+0x35>
80105d45:	eb 21                	jmp    80105d68 <fetchstr+0x48>
80105d47:	89 f6                	mov    %esi,%esi
80105d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105d50:	80 3a 00             	cmpb   $0x0,(%edx)
80105d53:	74 13                	je     80105d68 <fetchstr+0x48>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
80105d55:	42                   	inc    %edx
80105d56:	39 d0                	cmp    %edx,%eax
80105d58:	77 f6                	ja     80105d50 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80105d5a:	5a                   	pop    %edx
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
    return -1;
80105d5b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
  }
  return -1;
}
80105d60:	5b                   	pop    %ebx
80105d61:	5d                   	pop    %ebp
80105d62:	c3                   	ret    
80105d63:	90                   	nop
80105d64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80105d68:	89 d0                	mov    %edx,%eax
  }
  return -1;
}
80105d6a:	5a                   	pop    %edx
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
      return s - *pp;
80105d6b:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80105d6d:	5b                   	pop    %ebx
80105d6e:	5d                   	pop    %ebp
80105d6f:	c3                   	ret    

80105d70 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105d70:	55                   	push   %ebp
80105d71:	89 e5                	mov    %esp,%ebp
80105d73:	56                   	push   %esi
80105d74:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105d75:	e8 e6 db ff ff       	call   80103960 <myproc>
80105d7a:	8b 55 08             	mov    0x8(%ebp),%edx
80105d7d:	8b 40 18             	mov    0x18(%eax),%eax
80105d80:	8b 40 44             	mov    0x44(%eax),%eax
80105d83:	8d 1c 90             	lea    (%eax,%edx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();
80105d86:	e8 d5 db ff ff       	call   80103960 <myproc>

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105d8b:	8d 73 04             	lea    0x4(%ebx),%esi
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105d8e:	8b 00                	mov    (%eax),%eax
80105d90:	39 c6                	cmp    %eax,%esi
80105d92:	73 1c                	jae    80105db0 <argint+0x40>
80105d94:	8d 53 08             	lea    0x8(%ebx),%edx
80105d97:	39 d0                	cmp    %edx,%eax
80105d99:	72 15                	jb     80105db0 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
80105d9b:	8b 45 0c             	mov    0xc(%ebp),%eax
80105d9e:	8b 53 04             	mov    0x4(%ebx),%edx
80105da1:	89 10                	mov    %edx,(%eax)
  return 0;
80105da3:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
}
80105da5:	5b                   	pop    %ebx
80105da6:	5e                   	pop    %esi
80105da7:	5d                   	pop    %ebp
80105da8:	c3                   	ret    
80105da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
    return -1;
80105db0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105db5:	eb ee                	jmp    80105da5 <argint+0x35>
80105db7:	89 f6                	mov    %esi,%esi
80105db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105dc0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105dc0:	55                   	push   %ebp
80105dc1:	89 e5                	mov    %esp,%ebp
80105dc3:	56                   	push   %esi
80105dc4:	53                   	push   %ebx
80105dc5:	83 ec 20             	sub    $0x20,%esp
80105dc8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80105dcb:	e8 90 db ff ff       	call   80103960 <myproc>
80105dd0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80105dd2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105dd5:	89 44 24 04          	mov    %eax,0x4(%esp)
80105dd9:	8b 45 08             	mov    0x8(%ebp),%eax
80105ddc:	89 04 24             	mov    %eax,(%esp)
80105ddf:	e8 8c ff ff ff       	call   80105d70 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105de4:	c1 e8 1f             	shr    $0x1f,%eax
80105de7:	84 c0                	test   %al,%al
80105de9:	75 2d                	jne    80105e18 <argptr+0x58>
80105deb:	89 d8                	mov    %ebx,%eax
80105ded:	c1 e8 1f             	shr    $0x1f,%eax
80105df0:	84 c0                	test   %al,%al
80105df2:	75 24                	jne    80105e18 <argptr+0x58>
80105df4:	8b 16                	mov    (%esi),%edx
80105df6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105df9:	39 c2                	cmp    %eax,%edx
80105dfb:	76 1b                	jbe    80105e18 <argptr+0x58>
80105dfd:	01 c3                	add    %eax,%ebx
80105dff:	39 da                	cmp    %ebx,%edx
80105e01:	72 15                	jb     80105e18 <argptr+0x58>
    return -1;
  *pp = (char*)i;
80105e03:	8b 55 0c             	mov    0xc(%ebp),%edx
80105e06:	89 02                	mov    %eax,(%edx)
  return 0;
80105e08:	31 c0                	xor    %eax,%eax
}
80105e0a:	83 c4 20             	add    $0x20,%esp
80105e0d:	5b                   	pop    %ebx
80105e0e:	5e                   	pop    %esi
80105e0f:	5d                   	pop    %ebp
80105e10:	c3                   	ret    
80105e11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80105e18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e1d:	eb eb                	jmp    80105e0a <argptr+0x4a>
80105e1f:	90                   	nop

80105e20 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105e20:	55                   	push   %ebp
80105e21:	89 e5                	mov    %esp,%ebp
80105e23:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105e26:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e29:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e2d:	8b 45 08             	mov    0x8(%ebp),%eax
80105e30:	89 04 24             	mov    %eax,(%esp)
80105e33:	e8 38 ff ff ff       	call   80105d70 <argint>
80105e38:	85 c0                	test   %eax,%eax
80105e3a:	78 14                	js     80105e50 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80105e3c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105e3f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e46:	89 04 24             	mov    %eax,(%esp)
80105e49:	e8 d2 fe ff ff       	call   80105d20 <fetchstr>
}
80105e4e:	c9                   	leave  
80105e4f:	c3                   	ret    
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
80105e50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
80105e55:	c9                   	leave  
80105e56:	c3                   	ret    
80105e57:	89 f6                	mov    %esi,%esi
80105e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e60 <syscall>:
[SYS_priority] sys_priority,
};

void
syscall(void)
{
80105e60:	55                   	push   %ebp
80105e61:	89 e5                	mov    %esp,%ebp
80105e63:	83 ec 18             	sub    $0x18,%esp
80105e66:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80105e69:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int num;
  struct proc *curproc = myproc();
80105e6c:	e8 ef da ff ff       	call   80103960 <myproc>

  num = curproc->tf->eax;
80105e71:	8b 70 18             	mov    0x18(%eax),%esi

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
80105e74:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105e76:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105e79:	8d 50 ff             	lea    -0x1(%eax),%edx
80105e7c:	83 fa 17             	cmp    $0x17,%edx
80105e7f:	77 1f                	ja     80105ea0 <syscall+0x40>
80105e81:	8b 14 85 60 8e 10 80 	mov    -0x7fef71a0(,%eax,4),%edx
80105e88:	85 d2                	test   %edx,%edx
80105e8a:	74 14                	je     80105ea0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80105e8c:	ff d2                	call   *%edx
80105e8e:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105e91:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105e94:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105e97:	89 ec                	mov    %ebp,%esp
80105e99:	5d                   	pop    %ebp
80105e9a:	c3                   	ret    
80105e9b:	90                   	nop
80105e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105ea0:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
80105ea4:	8d 43 6c             	lea    0x6c(%ebx),%eax
80105ea7:	89 44 24 08          	mov    %eax,0x8(%esp)

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105eab:	8b 43 10             	mov    0x10(%ebx),%eax
80105eae:	c7 04 24 28 8e 10 80 	movl   $0x80108e28,(%esp)
80105eb5:	89 44 24 04          	mov    %eax,0x4(%esp)
80105eb9:	e8 82 a7 ff ff       	call   80100640 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
80105ebe:	8b 43 18             	mov    0x18(%ebx),%eax
80105ec1:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80105ec8:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105ecb:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105ece:	89 ec                	mov    %ebp,%esp
80105ed0:	5d                   	pop    %ebp
80105ed1:	c3                   	ret    
80105ed2:	66 90                	xchg   %ax,%ax
80105ed4:	66 90                	xchg   %ax,%ax
80105ed6:	66 90                	xchg   %ax,%ax
80105ed8:	66 90                	xchg   %ax,%ax
80105eda:	66 90                	xchg   %ax,%ax
80105edc:	66 90                	xchg   %ax,%ax
80105ede:	66 90                	xchg   %ax,%ax

80105ee0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105ee0:	55                   	push   %ebp
80105ee1:	0f bf d2             	movswl %dx,%edx
80105ee4:	89 e5                	mov    %esp,%ebp
80105ee6:	83 ec 58             	sub    $0x58,%esp
80105ee9:	89 7d fc             	mov    %edi,-0x4(%ebp)
80105eec:	0f bf 7d 08          	movswl 0x8(%ebp),%edi
80105ef0:	0f bf c9             	movswl %cx,%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105ef3:	89 04 24             	mov    %eax,(%esp)
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105ef6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105ef9:	89 75 f8             	mov    %esi,-0x8(%ebp)
80105efc:	89 7d bc             	mov    %edi,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105eff:	8d 7d da             	lea    -0x26(%ebp),%edi
80105f02:	89 7c 24 04          	mov    %edi,0x4(%esp)
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105f06:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105f09:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105f0c:	e8 9f c0 ff ff       	call   80101fb0 <nameiparent>
80105f11:	85 c0                	test   %eax,%eax
80105f13:	0f 84 ef 00 00 00    	je     80106008 <create+0x128>
    return 0;
  ilock(dp);
80105f19:	89 04 24             	mov    %eax,(%esp)
80105f1c:	89 c3                	mov    %eax,%ebx
80105f1e:	e8 cd b7 ff ff       	call   801016f0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105f23:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105f26:	89 44 24 08          	mov    %eax,0x8(%esp)
80105f2a:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105f2e:	89 1c 24             	mov    %ebx,(%esp)
80105f31:	e8 1a bd ff ff       	call   80101c50 <dirlookup>
80105f36:	85 c0                	test   %eax,%eax
80105f38:	89 c6                	mov    %eax,%esi
80105f3a:	74 54                	je     80105f90 <create+0xb0>
    iunlockput(dp);
80105f3c:	89 1c 24             	mov    %ebx,(%esp)
80105f3f:	e8 3c ba ff ff       	call   80101980 <iunlockput>
    ilock(ip);
80105f44:	89 34 24             	mov    %esi,(%esp)
80105f47:	e8 a4 b7 ff ff       	call   801016f0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105f4c:	83 7d c4 02          	cmpl   $0x2,-0x3c(%ebp)
80105f50:	75 1e                	jne    80105f70 <create+0x90>
80105f52:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105f57:	89 f0                	mov    %esi,%eax
80105f59:	75 15                	jne    80105f70 <create+0x90>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105f5b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105f5e:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105f61:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105f64:	89 ec                	mov    %ebp,%esp
80105f66:	5d                   	pop    %ebp
80105f67:	c3                   	ret    
80105f68:	90                   	nop
80105f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80105f70:	89 34 24             	mov    %esi,(%esp)
80105f73:	e8 08 ba ff ff       	call   80101980 <iunlockput>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105f78:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
80105f7b:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105f7d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105f80:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105f83:	89 ec                	mov    %ebp,%esp
80105f85:	5d                   	pop    %ebp
80105f86:	c3                   	ret    
80105f87:	89 f6                	mov    %esi,%esi
80105f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105f90:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80105f93:	89 44 24 04          	mov    %eax,0x4(%esp)
80105f97:	8b 03                	mov    (%ebx),%eax
80105f99:	89 04 24             	mov    %eax,(%esp)
80105f9c:	e8 cf b5 ff ff       	call   80101570 <ialloc>
80105fa1:	85 c0                	test   %eax,%eax
80105fa3:	89 c6                	mov    %eax,%esi
80105fa5:	0f 84 c1 00 00 00    	je     8010606c <create+0x18c>
    panic("create: ialloc");

  ilock(ip);
80105fab:	89 04 24             	mov    %eax,(%esp)
80105fae:	e8 3d b7 ff ff       	call   801016f0 <ilock>
  ip->major = major;
80105fb3:	8b 45 c0             	mov    -0x40(%ebp),%eax
  ip->minor = minor;
  ip->nlink = 1;
80105fb6:	66 c7 46 56 01 00    	movw   $0x1,0x56(%esi)

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
80105fbc:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80105fc0:	8b 45 bc             	mov    -0x44(%ebp),%eax
80105fc3:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
  iupdate(ip);
80105fc7:	89 34 24             	mov    %esi,(%esp)
80105fca:	e8 61 b6 ff ff       	call   80101630 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80105fcf:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
80105fd3:	74 3b                	je     80106010 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105fd5:	8b 46 04             	mov    0x4(%esi),%eax
80105fd8:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105fdc:	89 1c 24             	mov    %ebx,(%esp)
80105fdf:	89 44 24 08          	mov    %eax,0x8(%esp)
80105fe3:	e8 c8 be ff ff       	call   80101eb0 <dirlink>
80105fe8:	85 c0                	test   %eax,%eax
80105fea:	78 74                	js     80106060 <create+0x180>
    panic("create: dirlink");

  iunlockput(dp);
80105fec:	89 1c 24             	mov    %ebx,(%esp)
80105fef:	e8 8c b9 ff ff       	call   80101980 <iunlockput>

  return ip;
80105ff4:	89 f0                	mov    %esi,%eax
}
80105ff6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105ff9:	8b 75 f8             	mov    -0x8(%ebp),%esi
80105ffc:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105fff:	89 ec                	mov    %ebp,%esp
80106001:	5d                   	pop    %ebp
80106002:	c3                   	ret    
80106003:	90                   	nop
80106004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80106008:	31 c0                	xor    %eax,%eax
8010600a:	e9 4c ff ff ff       	jmp    80105f5b <create+0x7b>
8010600f:	90                   	nop
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80106010:	66 ff 43 56          	incw   0x56(%ebx)
    iupdate(dp);
80106014:	89 1c 24             	mov    %ebx,(%esp)
80106017:	e8 14 b6 ff ff       	call   80101630 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010601c:	8b 46 04             	mov    0x4(%esi),%eax
8010601f:	ba e0 8e 10 80       	mov    $0x80108ee0,%edx
80106024:	89 54 24 04          	mov    %edx,0x4(%esp)
80106028:	89 34 24             	mov    %esi,(%esp)
8010602b:	89 44 24 08          	mov    %eax,0x8(%esp)
8010602f:	e8 7c be ff ff       	call   80101eb0 <dirlink>
80106034:	85 c0                	test   %eax,%eax
80106036:	78 1c                	js     80106054 <create+0x174>
80106038:	8b 43 04             	mov    0x4(%ebx),%eax
8010603b:	89 34 24             	mov    %esi,(%esp)
8010603e:	89 44 24 08          	mov    %eax,0x8(%esp)
80106042:	b8 df 8e 10 80       	mov    $0x80108edf,%eax
80106047:	89 44 24 04          	mov    %eax,0x4(%esp)
8010604b:	e8 60 be ff ff       	call   80101eb0 <dirlink>
80106050:	85 c0                	test   %eax,%eax
80106052:	79 81                	jns    80105fd5 <create+0xf5>
      panic("create dots");
80106054:	c7 04 24 d3 8e 10 80 	movl   $0x80108ed3,(%esp)
8010605b:	e8 e0 a2 ff ff       	call   80100340 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80106060:	c7 04 24 e2 8e 10 80 	movl   $0x80108ee2,(%esp)
80106067:	e8 d4 a2 ff ff       	call   80100340 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
8010606c:	c7 04 24 c4 8e 10 80 	movl   $0x80108ec4,(%esp)
80106073:	e8 c8 a2 ff ff       	call   80100340 <panic>
80106078:	90                   	nop
80106079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106080 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80106080:	55                   	push   %ebp
80106081:	89 e5                	mov    %esp,%ebp
80106083:	56                   	push   %esi
80106084:	89 c6                	mov    %eax,%esi
80106086:	53                   	push   %ebx
80106087:	89 d3                	mov    %edx,%ebx
80106089:	83 ec 20             	sub    $0x20,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010608c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010608f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106093:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010609a:	e8 d1 fc ff ff       	call   80105d70 <argint>
8010609f:	85 c0                	test   %eax,%eax
801060a1:	78 2d                	js     801060d0 <argfd.constprop.0+0x50>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801060a3:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801060a7:	77 27                	ja     801060d0 <argfd.constprop.0+0x50>
801060a9:	e8 b2 d8 ff ff       	call   80103960 <myproc>
801060ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
801060b1:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801060b5:	85 c0                	test   %eax,%eax
801060b7:	74 17                	je     801060d0 <argfd.constprop.0+0x50>
    return -1;
  if(pfd)
801060b9:	85 f6                	test   %esi,%esi
801060bb:	74 02                	je     801060bf <argfd.constprop.0+0x3f>
    *pfd = fd;
801060bd:	89 16                	mov    %edx,(%esi)
  if(pf)
801060bf:	85 db                	test   %ebx,%ebx
801060c1:	74 1d                	je     801060e0 <argfd.constprop.0+0x60>
    *pf = f;
801060c3:	89 03                	mov    %eax,(%ebx)
  return 0;
801060c5:	31 c0                	xor    %eax,%eax
}
801060c7:	83 c4 20             	add    $0x20,%esp
801060ca:	5b                   	pop    %ebx
801060cb:	5e                   	pop    %esi
801060cc:	5d                   	pop    %ebp
801060cd:	c3                   	ret    
801060ce:	66 90                	xchg   %ax,%ax
801060d0:	83 c4 20             	add    $0x20,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
801060d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}
801060d8:	5b                   	pop    %ebx
801060d9:	5e                   	pop    %esi
801060da:	5d                   	pop    %ebp
801060db:	c3                   	ret    
801060dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
801060e0:	31 c0                	xor    %eax,%eax
801060e2:	eb e3                	jmp    801060c7 <argfd.constprop.0+0x47>
801060e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801060ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801060f0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
801060f0:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801060f1:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
801060f3:	89 e5                	mov    %esp,%ebp
801060f5:	56                   	push   %esi
801060f6:	53                   	push   %ebx
801060f7:	83 ec 20             	sub    $0x20,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801060fa:	8d 55 f4             	lea    -0xc(%ebp),%edx
801060fd:	e8 7e ff ff ff       	call   80106080 <argfd.constprop.0>
80106102:	85 c0                	test   %eax,%eax
80106104:	78 18                	js     8010611e <sys_dup+0x2e>
    return -1;
  if((fd=fdalloc(f)) < 0)
80106106:	8b 75 f4             	mov    -0xc(%ebp),%esi
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106109:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
8010610b:	e8 50 d8 ff ff       	call   80103960 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
80106110:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106114:	85 d2                	test   %edx,%edx
80106116:	74 18                	je     80106130 <sys_dup+0x40>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106118:	43                   	inc    %ebx
80106119:	83 fb 10             	cmp    $0x10,%ebx
8010611c:	75 f2                	jne    80106110 <sys_dup+0x20>
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
8010611e:	83 c4 20             	add    $0x20,%esp
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80106121:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80106126:	5b                   	pop    %ebx
80106127:	5e                   	pop    %esi
80106128:	5d                   	pop    %ebp
80106129:	c3                   	ret    
8010612a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80106130:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80106134:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106137:	89 04 24             	mov    %eax,(%esp)
8010613a:	e8 91 ac ff ff       	call   80100dd0 <filedup>
  return fd;
}
8010613f:	83 c4 20             	add    $0x20,%esp
  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
80106142:	89 d8                	mov    %ebx,%eax
}
80106144:	5b                   	pop    %ebx
80106145:	5e                   	pop    %esi
80106146:	5d                   	pop    %ebp
80106147:	c3                   	ret    
80106148:	90                   	nop
80106149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106150 <sys_read>:

int
sys_read(void)
{
80106150:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106151:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80106153:	89 e5                	mov    %esp,%ebp
80106155:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106158:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010615b:	e8 20 ff ff ff       	call   80106080 <argfd.constprop.0>
80106160:	85 c0                	test   %eax,%eax
80106162:	78 54                	js     801061b8 <sys_read+0x68>
80106164:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106167:	89 44 24 04          	mov    %eax,0x4(%esp)
8010616b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80106172:	e8 f9 fb ff ff       	call   80105d70 <argint>
80106177:	85 c0                	test   %eax,%eax
80106179:	78 3d                	js     801061b8 <sys_read+0x68>
8010617b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010617e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106185:	89 44 24 08          	mov    %eax,0x8(%esp)
80106189:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010618c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106190:	e8 2b fc ff ff       	call   80105dc0 <argptr>
80106195:	85 c0                	test   %eax,%eax
80106197:	78 1f                	js     801061b8 <sys_read+0x68>
    return -1;
  return fileread(f, p, n);
80106199:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010619c:	89 44 24 08          	mov    %eax,0x8(%esp)
801061a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061a3:	89 44 24 04          	mov    %eax,0x4(%esp)
801061a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801061aa:	89 04 24             	mov    %eax,(%esp)
801061ad:	e8 9e ad ff ff       	call   80100f50 <fileread>
}
801061b2:	c9                   	leave  
801061b3:	c3                   	ret    
801061b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
801061b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
801061bd:	c9                   	leave  
801061be:	c3                   	ret    
801061bf:	90                   	nop

801061c0 <sys_write>:

int
sys_write(void)
{
801061c0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801061c1:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
801061c3:	89 e5                	mov    %esp,%ebp
801061c5:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801061c8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801061cb:	e8 b0 fe ff ff       	call   80106080 <argfd.constprop.0>
801061d0:	85 c0                	test   %eax,%eax
801061d2:	78 54                	js     80106228 <sys_write+0x68>
801061d4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061d7:	89 44 24 04          	mov    %eax,0x4(%esp)
801061db:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801061e2:	e8 89 fb ff ff       	call   80105d70 <argint>
801061e7:	85 c0                	test   %eax,%eax
801061e9:	78 3d                	js     80106228 <sys_write+0x68>
801061eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801061ee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801061f5:	89 44 24 08          	mov    %eax,0x8(%esp)
801061f9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061fc:	89 44 24 04          	mov    %eax,0x4(%esp)
80106200:	e8 bb fb ff ff       	call   80105dc0 <argptr>
80106205:	85 c0                	test   %eax,%eax
80106207:	78 1f                	js     80106228 <sys_write+0x68>
    return -1;
  return filewrite(f, p, n);
80106209:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010620c:	89 44 24 08          	mov    %eax,0x8(%esp)
80106210:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106213:	89 44 24 04          	mov    %eax,0x4(%esp)
80106217:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010621a:	89 04 24             	mov    %eax,(%esp)
8010621d:	e8 de ad ff ff       	call   80101000 <filewrite>
}
80106222:	c9                   	leave  
80106223:	c3                   	ret    
80106224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80106228:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
8010622d:	c9                   	leave  
8010622e:	c3                   	ret    
8010622f:	90                   	nop

80106230 <sys_close>:

int
sys_close(void)
{
80106230:	55                   	push   %ebp
80106231:	89 e5                	mov    %esp,%ebp
80106233:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80106236:	8d 55 f4             	lea    -0xc(%ebp),%edx
80106239:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010623c:	e8 3f fe ff ff       	call   80106080 <argfd.constprop.0>
80106241:	85 c0                	test   %eax,%eax
80106243:	78 23                	js     80106268 <sys_close+0x38>
    return -1;
  myproc()->ofile[fd] = 0;
80106245:	e8 16 d7 ff ff       	call   80103960 <myproc>
8010624a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010624d:	31 c9                	xor    %ecx,%ecx
8010624f:	89 4c 90 28          	mov    %ecx,0x28(%eax,%edx,4)
  fileclose(f);
80106253:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106256:	89 04 24             	mov    %eax,(%esp)
80106259:	e8 c2 ab ff ff       	call   80100e20 <fileclose>
  return 0;
8010625e:	31 c0                	xor    %eax,%eax
}
80106260:	c9                   	leave  
80106261:	c3                   	ret    
80106262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80106268:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  myproc()->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
8010626d:	c9                   	leave  
8010626e:	c3                   	ret    
8010626f:	90                   	nop

80106270 <sys_fstat>:

int
sys_fstat(void)
{
80106270:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106271:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80106273:	89 e5                	mov    %esp,%ebp
80106275:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80106278:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010627b:	e8 00 fe ff ff       	call   80106080 <argfd.constprop.0>
80106280:	85 c0                	test   %eax,%eax
80106282:	78 3c                	js     801062c0 <sys_fstat+0x50>
80106284:	b8 14 00 00 00       	mov    $0x14,%eax
80106289:	89 44 24 08          	mov    %eax,0x8(%esp)
8010628d:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106290:	89 44 24 04          	mov    %eax,0x4(%esp)
80106294:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010629b:	e8 20 fb ff ff       	call   80105dc0 <argptr>
801062a0:	85 c0                	test   %eax,%eax
801062a2:	78 1c                	js     801062c0 <sys_fstat+0x50>
    return -1;
  return filestat(f, st);
801062a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801062a7:	89 44 24 04          	mov    %eax,0x4(%esp)
801062ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
801062ae:	89 04 24             	mov    %eax,(%esp)
801062b1:	e8 4a ac ff ff       	call   80100f00 <filestat>
}
801062b6:	c9                   	leave  
801062b7:	c3                   	ret    
801062b8:	90                   	nop
801062b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
801062c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
801062c5:	c9                   	leave  
801062c6:	c3                   	ret    
801062c7:	89 f6                	mov    %esi,%esi
801062c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801062d0 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
801062d0:	55                   	push   %ebp
801062d1:	89 e5                	mov    %esp,%ebp
801062d3:	57                   	push   %edi
801062d4:	56                   	push   %esi
801062d5:	53                   	push   %ebx
801062d6:	83 ec 3c             	sub    $0x3c,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801062d9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801062dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801062e0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801062e7:	e8 34 fb ff ff       	call   80105e20 <argstr>
801062ec:	85 c0                	test   %eax,%eax
801062ee:	0f 88 e5 00 00 00    	js     801063d9 <sys_link+0x109>
801062f4:	8d 45 d0             	lea    -0x30(%ebp),%eax
801062f7:	89 44 24 04          	mov    %eax,0x4(%esp)
801062fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106302:	e8 19 fb ff ff       	call   80105e20 <argstr>
80106307:	85 c0                	test   %eax,%eax
80106309:	0f 88 ca 00 00 00    	js     801063d9 <sys_link+0x109>
    return -1;

  begin_op();
8010630f:	e8 ec c8 ff ff       	call   80102c00 <begin_op>
  if((ip = namei(old)) == 0){
80106314:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80106317:	89 04 24             	mov    %eax,(%esp)
8010631a:	e8 71 bc ff ff       	call   80101f90 <namei>
8010631f:	85 c0                	test   %eax,%eax
80106321:	89 c3                	mov    %eax,%ebx
80106323:	0f 84 ab 00 00 00    	je     801063d4 <sys_link+0x104>
    end_op();
    return -1;
  }

  ilock(ip);
80106329:	89 04 24             	mov    %eax,(%esp)
8010632c:	e8 bf b3 ff ff       	call   801016f0 <ilock>
  if(ip->type == T_DIR){
80106331:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106336:	0f 84 90 00 00 00    	je     801063cc <sys_link+0xfc>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
8010633c:	66 ff 43 56          	incw   0x56(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80106340:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80106343:	89 1c 24             	mov    %ebx,(%esp)
80106346:	e8 e5 b2 ff ff       	call   80101630 <iupdate>
  iunlock(ip);
8010634b:	89 1c 24             	mov    %ebx,(%esp)
8010634e:	e8 7d b4 ff ff       	call   801017d0 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80106353:	8b 45 d0             	mov    -0x30(%ebp),%eax
80106356:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010635a:	89 04 24             	mov    %eax,(%esp)
8010635d:	e8 4e bc ff ff       	call   80101fb0 <nameiparent>
80106362:	85 c0                	test   %eax,%eax
80106364:	89 c6                	mov    %eax,%esi
80106366:	74 50                	je     801063b8 <sys_link+0xe8>
    goto bad;
  ilock(dp);
80106368:	89 04 24             	mov    %eax,(%esp)
8010636b:	e8 80 b3 ff ff       	call   801016f0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80106370:	8b 03                	mov    (%ebx),%eax
80106372:	39 06                	cmp    %eax,(%esi)
80106374:	75 3a                	jne    801063b0 <sys_link+0xe0>
80106376:	8b 43 04             	mov    0x4(%ebx),%eax
80106379:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010637d:	89 34 24             	mov    %esi,(%esp)
80106380:	89 44 24 08          	mov    %eax,0x8(%esp)
80106384:	e8 27 bb ff ff       	call   80101eb0 <dirlink>
80106389:	85 c0                	test   %eax,%eax
8010638b:	78 23                	js     801063b0 <sys_link+0xe0>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
8010638d:	89 34 24             	mov    %esi,(%esp)
80106390:	e8 eb b5 ff ff       	call   80101980 <iunlockput>
  iput(ip);
80106395:	89 1c 24             	mov    %ebx,(%esp)
80106398:	e8 83 b4 ff ff       	call   80101820 <iput>

  end_op();
8010639d:	e8 ce c8 ff ff       	call   80102c70 <end_op>
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
801063a2:	83 c4 3c             	add    $0x3c,%esp
  iunlockput(dp);
  iput(ip);

  end_op();

  return 0;
801063a5:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
801063a7:	5b                   	pop    %ebx
801063a8:	5e                   	pop    %esi
801063a9:	5f                   	pop    %edi
801063aa:	5d                   	pop    %ebp
801063ab:	c3                   	ret    
801063ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
801063b0:	89 34 24             	mov    %esi,(%esp)
801063b3:	e8 c8 b5 ff ff       	call   80101980 <iunlockput>
  end_op();

  return 0;

bad:
  ilock(ip);
801063b8:	89 1c 24             	mov    %ebx,(%esp)
801063bb:	e8 30 b3 ff ff       	call   801016f0 <ilock>
  ip->nlink--;
801063c0:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
801063c4:	89 1c 24             	mov    %ebx,(%esp)
801063c7:	e8 64 b2 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
801063cc:	89 1c 24             	mov    %ebx,(%esp)
801063cf:	e8 ac b5 ff ff       	call   80101980 <iunlockput>
  end_op();
801063d4:	e8 97 c8 ff ff       	call   80102c70 <end_op>
  return -1;
}
801063d9:	83 c4 3c             	add    $0x3c,%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
801063dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063e1:	5b                   	pop    %ebx
801063e2:	5e                   	pop    %esi
801063e3:	5f                   	pop    %edi
801063e4:	5d                   	pop    %ebp
801063e5:	c3                   	ret    
801063e6:	8d 76 00             	lea    0x0(%esi),%esi
801063e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801063f0 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
801063f0:	55                   	push   %ebp
801063f1:	89 e5                	mov    %esp,%ebp
801063f3:	57                   	push   %edi
801063f4:	56                   	push   %esi
801063f5:	53                   	push   %ebx
801063f6:	83 ec 5c             	sub    $0x5c,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801063f9:	8d 45 c0             	lea    -0x40(%ebp),%eax
801063fc:	89 44 24 04          	mov    %eax,0x4(%esp)
80106400:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106407:	e8 14 fa ff ff       	call   80105e20 <argstr>
8010640c:	85 c0                	test   %eax,%eax
8010640e:	0f 88 75 01 00 00    	js     80106589 <sys_unlink+0x199>
    return -1;

  begin_op();
80106414:	e8 e7 c7 ff ff       	call   80102c00 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106419:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010641c:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010641f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80106423:	89 04 24             	mov    %eax,(%esp)
80106426:	e8 85 bb ff ff       	call   80101fb0 <nameiparent>
8010642b:	85 c0                	test   %eax,%eax
8010642d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80106430:	0f 84 4e 01 00 00    	je     80106584 <sys_unlink+0x194>
    end_op();
    return -1;
  }

  ilock(dp);
80106436:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80106439:	89 34 24             	mov    %esi,(%esp)
8010643c:	e8 af b2 ff ff       	call   801016f0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80106441:	b8 e0 8e 10 80       	mov    $0x80108ee0,%eax
80106446:	89 44 24 04          	mov    %eax,0x4(%esp)
8010644a:	89 1c 24             	mov    %ebx,(%esp)
8010644d:	e8 ce b7 ff ff       	call   80101c20 <namecmp>
80106452:	85 c0                	test   %eax,%eax
80106454:	0f 84 1f 01 00 00    	je     80106579 <sys_unlink+0x189>
8010645a:	b8 df 8e 10 80       	mov    $0x80108edf,%eax
8010645f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106463:	89 1c 24             	mov    %ebx,(%esp)
80106466:	e8 b5 b7 ff ff       	call   80101c20 <namecmp>
8010646b:	85 c0                	test   %eax,%eax
8010646d:	0f 84 06 01 00 00    	je     80106579 <sys_unlink+0x189>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80106473:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80106476:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010647a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010647e:	89 34 24             	mov    %esi,(%esp)
80106481:	e8 ca b7 ff ff       	call   80101c50 <dirlookup>
80106486:	85 c0                	test   %eax,%eax
80106488:	89 c3                	mov    %eax,%ebx
8010648a:	0f 84 e9 00 00 00    	je     80106579 <sys_unlink+0x189>
    goto bad;
  ilock(ip);
80106490:	89 04 24             	mov    %eax,(%esp)
80106493:	e8 58 b2 ff ff       	call   801016f0 <ilock>

  if(ip->nlink < 1)
80106498:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010649d:	0f 8e 29 01 00 00    	jle    801065cc <sys_unlink+0x1dc>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
801064a3:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801064a8:	8d 75 d8             	lea    -0x28(%ebp),%esi
801064ab:	74 7b                	je     80106528 <sys_unlink+0x138>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
801064ad:	31 d2                	xor    %edx,%edx
801064af:	b8 10 00 00 00       	mov    $0x10,%eax
801064b4:	89 54 24 04          	mov    %edx,0x4(%esp)
801064b8:	89 44 24 08          	mov    %eax,0x8(%esp)
801064bc:	89 34 24             	mov    %esi,(%esp)
801064bf:	e8 bc f5 ff ff       	call   80105a80 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801064c4:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801064c7:	b9 10 00 00 00       	mov    $0x10,%ecx
801064cc:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801064d0:	89 74 24 04          	mov    %esi,0x4(%esp)
801064d4:	89 44 24 08          	mov    %eax,0x8(%esp)
801064d8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801064db:	89 04 24             	mov    %eax,(%esp)
801064de:	e8 fd b5 ff ff       	call   80101ae0 <writei>
801064e3:	83 f8 10             	cmp    $0x10,%eax
801064e6:	0f 85 d4 00 00 00    	jne    801065c0 <sys_unlink+0x1d0>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801064ec:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801064f1:	0f 84 a9 00 00 00    	je     801065a0 <sys_unlink+0x1b0>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801064f7:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801064fa:	89 04 24             	mov    %eax,(%esp)
801064fd:	e8 7e b4 ff ff       	call   80101980 <iunlockput>

  ip->nlink--;
80106502:	66 ff 4b 56          	decw   0x56(%ebx)
  iupdate(ip);
80106506:	89 1c 24             	mov    %ebx,(%esp)
80106509:	e8 22 b1 ff ff       	call   80101630 <iupdate>
  iunlockput(ip);
8010650e:	89 1c 24             	mov    %ebx,(%esp)
80106511:	e8 6a b4 ff ff       	call   80101980 <iunlockput>

  end_op();
80106516:	e8 55 c7 ff ff       	call   80102c70 <end_op>

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
8010651b:	83 c4 5c             	add    $0x5c,%esp
  iupdate(ip);
  iunlockput(ip);

  end_op();

  return 0;
8010651e:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80106520:	5b                   	pop    %ebx
80106521:	5e                   	pop    %esi
80106522:	5f                   	pop    %edi
80106523:	5d                   	pop    %ebp
80106524:	c3                   	ret    
80106525:	8d 76 00             	lea    0x0(%esi),%esi
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106528:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
8010652c:	0f 86 7b ff ff ff    	jbe    801064ad <sys_unlink+0xbd>
80106532:	bf 20 00 00 00       	mov    $0x20,%edi
80106537:	eb 13                	jmp    8010654c <sys_unlink+0x15c>
80106539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106540:	83 c7 10             	add    $0x10,%edi
80106543:	3b 7b 58             	cmp    0x58(%ebx),%edi
80106546:	0f 83 61 ff ff ff    	jae    801064ad <sys_unlink+0xbd>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010654c:	b8 10 00 00 00       	mov    $0x10,%eax
80106551:	89 44 24 0c          	mov    %eax,0xc(%esp)
80106555:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106559:	89 74 24 04          	mov    %esi,0x4(%esp)
8010655d:	89 1c 24             	mov    %ebx,(%esp)
80106560:	e8 6b b4 ff ff       	call   801019d0 <readi>
80106565:	83 f8 10             	cmp    $0x10,%eax
80106568:	75 4a                	jne    801065b4 <sys_unlink+0x1c4>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010656a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010656f:	74 cf                	je     80106540 <sys_unlink+0x150>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80106571:	89 1c 24             	mov    %ebx,(%esp)
80106574:	e8 07 b4 ff ff       	call   80101980 <iunlockput>
  end_op();

  return 0;

bad:
  iunlockput(dp);
80106579:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010657c:	89 04 24             	mov    %eax,(%esp)
8010657f:	e8 fc b3 ff ff       	call   80101980 <iunlockput>
  end_op();
80106584:	e8 e7 c6 ff ff       	call   80102c70 <end_op>
  return -1;
}
80106589:	83 c4 5c             	add    $0x5c,%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
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

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801065a0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801065a3:	66 ff 48 56          	decw   0x56(%eax)
    iupdate(dp);
801065a7:	89 04 24             	mov    %eax,(%esp)
801065aa:	e8 81 b0 ff ff       	call   80101630 <iupdate>
801065af:	e9 43 ff ff ff       	jmp    801064f7 <sys_unlink+0x107>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
801065b4:	c7 04 24 04 8f 10 80 	movl   $0x80108f04,(%esp)
801065bb:	e8 80 9d ff ff       	call   80100340 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
801065c0:	c7 04 24 16 8f 10 80 	movl   $0x80108f16,(%esp)
801065c7:	e8 74 9d ff ff       	call   80100340 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
801065cc:	c7 04 24 f2 8e 10 80 	movl   $0x80108ef2,(%esp)
801065d3:	e8 68 9d ff ff       	call   80100340 <panic>
801065d8:	90                   	nop
801065d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801065e0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
801065e0:	55                   	push   %ebp
801065e1:	89 e5                	mov    %esp,%ebp
801065e3:	57                   	push   %edi
801065e4:	56                   	push   %esi
801065e5:	53                   	push   %ebx
801065e6:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801065e9:	8d 45 e0             	lea    -0x20(%ebp),%eax
801065ec:	89 44 24 04          	mov    %eax,0x4(%esp)
801065f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801065f7:	e8 24 f8 ff ff       	call   80105e20 <argstr>
801065fc:	85 c0                	test   %eax,%eax
801065fe:	0f 88 7f 00 00 00    	js     80106683 <sys_open+0xa3>
80106604:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106607:	89 44 24 04          	mov    %eax,0x4(%esp)
8010660b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106612:	e8 59 f7 ff ff       	call   80105d70 <argint>
80106617:	85 c0                	test   %eax,%eax
80106619:	78 68                	js     80106683 <sys_open+0xa3>
    return -1;

  begin_op();
8010661b:	e8 e0 c5 ff ff       	call   80102c00 <begin_op>

  if(omode & O_CREATE){
80106620:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80106624:	75 6a                	jne    80106690 <sys_open+0xb0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80106626:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106629:	89 04 24             	mov    %eax,(%esp)
8010662c:	e8 5f b9 ff ff       	call   80101f90 <namei>
80106631:	85 c0                	test   %eax,%eax
80106633:	89 c6                	mov    %eax,%esi
80106635:	74 47                	je     8010667e <sys_open+0x9e>
      end_op();
      return -1;
    }
    ilock(ip);
80106637:	89 04 24             	mov    %eax,(%esp)
8010663a:	e8 b1 b0 ff ff       	call   801016f0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010663f:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106644:	0f 84 a6 00 00 00    	je     801066f0 <sys_open+0x110>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010664a:	e8 11 a7 ff ff       	call   80100d60 <filealloc>
8010664f:	85 c0                	test   %eax,%eax
80106651:	89 c7                	mov    %eax,%edi
80106653:	74 21                	je     80106676 <sys_open+0x96>
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80106655:	e8 06 d3 ff ff       	call   80103960 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
8010665a:	31 db                	xor    %ebx,%ebx
8010665c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106660:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106664:	85 d2                	test   %edx,%edx
80106666:	74 48                	je     801066b0 <sys_open+0xd0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106668:	43                   	inc    %ebx
80106669:	83 fb 10             	cmp    $0x10,%ebx
8010666c:	75 f2                	jne    80106660 <sys_open+0x80>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
8010666e:	89 3c 24             	mov    %edi,(%esp)
80106671:	e8 aa a7 ff ff       	call   80100e20 <fileclose>
    iunlockput(ip);
80106676:	89 34 24             	mov    %esi,(%esp)
80106679:	e8 02 b3 ff ff       	call   80101980 <iunlockput>
    end_op();
8010667e:	e8 ed c5 ff ff       	call   80102c70 <end_op>
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80106683:	83 c4 2c             	add    $0x2c,%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80106686:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010668b:	5b                   	pop    %ebx
8010668c:	5e                   	pop    %esi
8010668d:	5f                   	pop    %edi
8010668e:	5d                   	pop    %ebp
8010668f:	c3                   	ret    
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80106690:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106693:	31 c9                	xor    %ecx,%ecx
80106695:	ba 02 00 00 00       	mov    $0x2,%edx
8010669a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801066a1:	e8 3a f8 ff ff       	call   80105ee0 <create>
    if(ip == 0){
801066a6:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801066a8:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801066aa:	75 9e                	jne    8010664a <sys_open+0x6a>
801066ac:	eb d0                	jmp    8010667e <sys_open+0x9e>
801066ae:	66 90                	xchg   %ax,%ax
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801066b0:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801066b4:	89 34 24             	mov    %esi,(%esp)
801066b7:	e8 14 b1 ff ff       	call   801017d0 <iunlock>
  end_op();
801066bc:	e8 af c5 ff ff       	call   80102c70 <end_op>

  f->type = FD_INODE;
801066c1:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801066c7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
801066ca:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
801066cd:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801066d4:	89 d0                	mov    %edx,%eax
801066d6:	83 e0 01             	and    $0x1,%eax
801066d9:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801066dc:	f6 c2 03             	test   $0x3,%dl
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801066df:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
801066e2:	89 d8                	mov    %ebx,%eax

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801066e4:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801066e8:	83 c4 2c             	add    $0x2c,%esp
801066eb:	5b                   	pop    %ebx
801066ec:	5e                   	pop    %esi
801066ed:	5f                   	pop    %edi
801066ee:	5d                   	pop    %ebp
801066ef:	c3                   	ret    
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
801066f0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801066f3:	85 c9                	test   %ecx,%ecx
801066f5:	0f 84 4f ff ff ff    	je     8010664a <sys_open+0x6a>
801066fb:	e9 76 ff ff ff       	jmp    80106676 <sys_open+0x96>

80106700 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80106700:	55                   	push   %ebp
80106701:	89 e5                	mov    %esp,%ebp
80106703:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106706:	e8 f5 c4 ff ff       	call   80102c00 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010670b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010670e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106712:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106719:	e8 02 f7 ff ff       	call   80105e20 <argstr>
8010671e:	85 c0                	test   %eax,%eax
80106720:	78 2e                	js     80106750 <sys_mkdir+0x50>
80106722:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106725:	31 c9                	xor    %ecx,%ecx
80106727:	ba 01 00 00 00       	mov    $0x1,%edx
8010672c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106733:	e8 a8 f7 ff ff       	call   80105ee0 <create>
80106738:	85 c0                	test   %eax,%eax
8010673a:	74 14                	je     80106750 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010673c:	89 04 24             	mov    %eax,(%esp)
8010673f:	e8 3c b2 ff ff       	call   80101980 <iunlockput>
  end_op();
80106744:	e8 27 c5 ff ff       	call   80102c70 <end_op>
  return 0;
80106749:	31 c0                	xor    %eax,%eax
}
8010674b:	c9                   	leave  
8010674c:	c3                   	ret    
8010674d:	8d 76 00             	lea    0x0(%esi),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80106750:	e8 1b c5 ff ff       	call   80102c70 <end_op>
    return -1;
80106755:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010675a:	c9                   	leave  
8010675b:	c3                   	ret    
8010675c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106760 <sys_mknod>:

int
sys_mknod(void)
{
80106760:	55                   	push   %ebp
80106761:	89 e5                	mov    %esp,%ebp
80106763:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80106766:	e8 95 c4 ff ff       	call   80102c00 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010676b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010676e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106772:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106779:	e8 a2 f6 ff ff       	call   80105e20 <argstr>
8010677e:	85 c0                	test   %eax,%eax
80106780:	78 5e                	js     801067e0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80106782:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106785:	89 44 24 04          	mov    %eax,0x4(%esp)
80106789:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80106790:	e8 db f5 ff ff       	call   80105d70 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80106795:	85 c0                	test   %eax,%eax
80106797:	78 47                	js     801067e0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80106799:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010679c:	89 44 24 04          	mov    %eax,0x4(%esp)
801067a0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801067a7:	e8 c4 f5 ff ff       	call   80105d70 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
801067ac:	85 c0                	test   %eax,%eax
801067ae:	78 30                	js     801067e0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801067b0:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801067b4:	ba 03 00 00 00       	mov    $0x3,%edx
801067b9:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801067bd:	89 04 24             	mov    %eax,(%esp)
801067c0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801067c3:	e8 18 f7 ff ff       	call   80105ee0 <create>
801067c8:	85 c0                	test   %eax,%eax
801067ca:	74 14                	je     801067e0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
801067cc:	89 04 24             	mov    %eax,(%esp)
801067cf:	e8 ac b1 ff ff       	call   80101980 <iunlockput>
  end_op();
801067d4:	e8 97 c4 ff ff       	call   80102c70 <end_op>
  return 0;
801067d9:	31 c0                	xor    %eax,%eax
}
801067db:	c9                   	leave  
801067dc:	c3                   	ret    
801067dd:	8d 76 00             	lea    0x0(%esi),%esi
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801067e0:	e8 8b c4 ff ff       	call   80102c70 <end_op>
    return -1;
801067e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801067ea:	c9                   	leave  
801067eb:	c3                   	ret    
801067ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801067f0 <sys_chdir>:

int
sys_chdir(void)
{
801067f0:	55                   	push   %ebp
801067f1:	89 e5                	mov    %esp,%ebp
801067f3:	56                   	push   %esi
801067f4:	53                   	push   %ebx
801067f5:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801067f8:	e8 63 d1 ff ff       	call   80103960 <myproc>
801067fd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801067ff:	e8 fc c3 ff ff       	call   80102c00 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106804:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106807:	89 44 24 04          	mov    %eax,0x4(%esp)
8010680b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106812:	e8 09 f6 ff ff       	call   80105e20 <argstr>
80106817:	85 c0                	test   %eax,%eax
80106819:	78 4a                	js     80106865 <sys_chdir+0x75>
8010681b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010681e:	89 04 24             	mov    %eax,(%esp)
80106821:	e8 6a b7 ff ff       	call   80101f90 <namei>
80106826:	85 c0                	test   %eax,%eax
80106828:	89 c3                	mov    %eax,%ebx
8010682a:	74 39                	je     80106865 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
8010682c:	89 04 24             	mov    %eax,(%esp)
8010682f:	e8 bc ae ff ff       	call   801016f0 <ilock>
  if(ip->type != T_DIR){
80106834:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80106839:	89 1c 24             	mov    %ebx,(%esp)
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
8010683c:	75 22                	jne    80106860 <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
8010683e:	e8 8d af ff ff       	call   801017d0 <iunlock>
  iput(curproc->cwd);
80106843:	8b 46 68             	mov    0x68(%esi),%eax
80106846:	89 04 24             	mov    %eax,(%esp)
80106849:	e8 d2 af ff ff       	call   80101820 <iput>
  end_op();
8010684e:	e8 1d c4 ff ff       	call   80102c70 <end_op>
  curproc->cwd = ip;
  return 0;
80106853:	31 c0                	xor    %eax,%eax
    return -1;
  }
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
80106855:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
}
80106858:	83 c4 20             	add    $0x20,%esp
8010685b:	5b                   	pop    %ebx
8010685c:	5e                   	pop    %esi
8010685d:	5d                   	pop    %ebp
8010685e:	c3                   	ret    
8010685f:	90                   	nop
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80106860:	e8 1b b1 ff ff       	call   80101980 <iunlockput>
    end_op();
80106865:	e8 06 c4 ff ff       	call   80102c70 <end_op>
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}
8010686a:	83 c4 20             	add    $0x20,%esp
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
8010686d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}
80106872:	5b                   	pop    %ebx
80106873:	5e                   	pop    %esi
80106874:	5d                   	pop    %ebp
80106875:	c3                   	ret    
80106876:	8d 76 00             	lea    0x0(%esi),%esi
80106879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106880 <sys_exec>:

int
sys_exec(void)
{
80106880:	55                   	push   %ebp
80106881:	89 e5                	mov    %esp,%ebp
80106883:	57                   	push   %edi
80106884:	56                   	push   %esi
80106885:	53                   	push   %ebx
80106886:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010688c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80106892:	89 44 24 04          	mov    %eax,0x4(%esp)
80106896:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010689d:	e8 7e f5 ff ff       	call   80105e20 <argstr>
801068a2:	85 c0                	test   %eax,%eax
801068a4:	0f 88 82 00 00 00    	js     8010692c <sys_exec+0xac>
801068aa:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801068b0:	89 44 24 04          	mov    %eax,0x4(%esp)
801068b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801068bb:	e8 b0 f4 ff ff       	call   80105d70 <argint>
801068c0:	85 c0                	test   %eax,%eax
801068c2:	78 68                	js     8010692c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801068c4:	ba 80 00 00 00       	mov    $0x80,%edx
801068c9:	31 c9                	xor    %ecx,%ecx
801068cb:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801068d1:	31 db                	xor    %ebx,%ebx
801068d3:	89 54 24 08          	mov    %edx,0x8(%esp)
801068d7:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801068dd:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801068e1:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801068e7:	89 04 24             	mov    %eax,(%esp)
801068ea:	e8 91 f1 ff ff       	call   80105a80 <memset>
801068ef:	90                   	nop
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801068f0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801068f6:	89 7c 24 04          	mov    %edi,0x4(%esp)
801068fa:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801068fd:	89 04 24             	mov    %eax,(%esp)
80106900:	e8 db f3 ff ff       	call   80105ce0 <fetchint>
80106905:	85 c0                	test   %eax,%eax
80106907:	78 23                	js     8010692c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106909:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010690f:	85 c0                	test   %eax,%eax
80106911:	74 2d                	je     80106940 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106913:	89 74 24 04          	mov    %esi,0x4(%esp)
80106917:	89 04 24             	mov    %eax,(%esp)
8010691a:	e8 01 f4 ff ff       	call   80105d20 <fetchstr>
8010691f:	85 c0                	test   %eax,%eax
80106921:	78 09                	js     8010692c <sys_exec+0xac>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80106923:	43                   	inc    %ebx
80106924:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
80106927:	83 fb 20             	cmp    $0x20,%ebx
8010692a:	75 c4                	jne    801068f0 <sys_exec+0x70>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
8010692c:	81 c4 ac 00 00 00    	add    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80106932:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80106937:	5b                   	pop    %ebx
80106938:	5e                   	pop    %esi
80106939:	5f                   	pop    %edi
8010693a:	5d                   	pop    %ebp
8010693b:	c3                   	ret    
8010693c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80106940:	31 c0                	xor    %eax,%eax
80106942:	89 84 9d 68 ff ff ff 	mov    %eax,-0x98(%ebp,%ebx,4)
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106949:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010694f:	89 44 24 04          	mov    %eax,0x4(%esp)
80106953:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80106959:	89 04 24             	mov    %eax,(%esp)
8010695c:	e8 4f a0 ff ff       	call   801009b0 <exec>
}
80106961:	81 c4 ac 00 00 00    	add    $0xac,%esp
80106967:	5b                   	pop    %ebx
80106968:	5e                   	pop    %esi
80106969:	5f                   	pop    %edi
8010696a:	5d                   	pop    %ebp
8010696b:	c3                   	ret    
8010696c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106970 <sys_pipe>:

int
sys_pipe(void)
{
80106970:	55                   	push   %ebp
80106971:	89 e5                	mov    %esp,%ebp
80106973:	57                   	push   %edi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106974:	bf 08 00 00 00       	mov    $0x8,%edi
  return exec(path, argv);
}

int
sys_pipe(void)
{
80106979:	56                   	push   %esi
8010697a:	53                   	push   %ebx
8010697b:	83 ec 2c             	sub    $0x2c,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010697e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106981:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106985:	89 44 24 04          	mov    %eax,0x4(%esp)
80106989:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106990:	e8 2b f4 ff ff       	call   80105dc0 <argptr>
80106995:	85 c0                	test   %eax,%eax
80106997:	78 4b                	js     801069e4 <sys_pipe+0x74>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106999:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010699c:	89 44 24 04          	mov    %eax,0x4(%esp)
801069a0:	8d 45 e0             	lea    -0x20(%ebp),%eax
801069a3:	89 04 24             	mov    %eax,(%esp)
801069a6:	e8 55 c9 ff ff       	call   80103300 <pipealloc>
801069ab:	85 c0                	test   %eax,%eax
801069ad:	78 35                	js     801069e4 <sys_pipe+0x74>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801069af:	8b 7d e0             	mov    -0x20(%ebp),%edi
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801069b2:	31 db                	xor    %ebx,%ebx
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
801069b4:	e8 a7 cf ff ff       	call   80103960 <myproc>
801069b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
801069c0:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801069c4:	85 f6                	test   %esi,%esi
801069c6:	74 30                	je     801069f8 <sys_pipe+0x88>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
801069c8:	43                   	inc    %ebx
801069c9:	83 fb 10             	cmp    $0x10,%ebx
801069cc:	75 f2                	jne    801069c0 <sys_pipe+0x50>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801069ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
801069d1:	89 04 24             	mov    %eax,(%esp)
801069d4:	e8 47 a4 ff ff       	call   80100e20 <fileclose>
    fileclose(wf);
801069d9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801069dc:	89 04 24             	mov    %eax,(%esp)
801069df:	e8 3c a4 ff ff       	call   80100e20 <fileclose>
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801069e4:	83 c4 2c             	add    $0x2c,%esp
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
801069e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}
801069ec:	5b                   	pop    %ebx
801069ed:	5e                   	pop    %esi
801069ee:	5f                   	pop    %edi
801069ef:	5d                   	pop    %ebp
801069f0:	c3                   	ret    
801069f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
801069f8:	8d 73 08             	lea    0x8(%ebx),%esi
801069fb:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801069ff:	8b 7d e4             	mov    -0x1c(%ebp),%edi
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();
80106a02:	e8 59 cf ff ff       	call   80103960 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80106a07:	31 d2                	xor    %edx,%edx
80106a09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106a10:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80106a14:	85 c9                	test   %ecx,%ecx
80106a16:	74 18                	je     80106a30 <sys_pipe+0xc0>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80106a18:	42                   	inc    %edx
80106a19:	83 fa 10             	cmp    $0x10,%edx
80106a1c:	75 f2                	jne    80106a10 <sys_pipe+0xa0>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80106a1e:	e8 3d cf ff ff       	call   80103960 <myproc>
80106a23:	31 d2                	xor    %edx,%edx
80106a25:	89 54 b0 08          	mov    %edx,0x8(%eax,%esi,4)
80106a29:	eb a3                	jmp    801069ce <sys_pipe+0x5e>
80106a2b:	90                   	nop
80106a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80106a30:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80106a34:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106a37:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106a39:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106a3c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
}
80106a3f:	83 c4 2c             	add    $0x2c,%esp
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
80106a42:	31 c0                	xor    %eax,%eax
}
80106a44:	5b                   	pop    %ebx
80106a45:	5e                   	pop    %esi
80106a46:	5f                   	pop    %edi
80106a47:	5d                   	pop    %ebp
80106a48:	c3                   	ret    
80106a49:	66 90                	xchg   %ax,%ax
80106a4b:	66 90                	xchg   %ax,%ax
80106a4d:	66 90                	xchg   %ax,%ax
80106a4f:	90                   	nop

80106a50 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80106a50:	55                   	push   %ebp
80106a51:	89 e5                	mov    %esp,%ebp
  return fork();
}
80106a53:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106a54:	e9 37 d2 ff ff       	jmp    80103c90 <fork>
80106a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a60 <sys_exit>:
}

int
sys_exit(void)
{
80106a60:	55                   	push   %ebp
80106a61:	89 e5                	mov    %esp,%ebp
80106a63:	83 ec 28             	sub    $0x28,%esp
    int stat;

    if(argint(0, &stat) < 0)
80106a66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106a69:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a6d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106a74:	e8 f7 f2 ff ff       	call   80105d70 <argint>
80106a79:	85 c0                	test   %eax,%eax
80106a7b:	78 13                	js     80106a90 <sys_exit+0x30>
        return -1;
    exit(stat);
80106a7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a80:	89 04 24             	mov    %eax,(%esp)
80106a83:	e8 a8 d6 ff ff       	call   80104130 <exit>
    return 0;
80106a88:	31 c0                	xor    %eax,%eax
}
80106a8a:	c9                   	leave  
80106a8b:	c3                   	ret    
80106a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_exit(void)
{
    int stat;

    if(argint(0, &stat) < 0)
        return -1;
80106a90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    exit(stat);
    return 0;
}
80106a95:	c9                   	leave  
80106a96:	c3                   	ret    
80106a97:	89 f6                	mov    %esi,%esi
80106a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106aa0 <sys_wait>:

int
sys_wait(void)
{
80106aa0:	55                   	push   %ebp
    int *status;

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106aa1:	b8 04 00 00 00       	mov    $0x4,%eax
    return 0;
}

int
sys_wait(void)
{
80106aa6:	89 e5                	mov    %esp,%ebp
80106aa8:	83 ec 28             	sub    $0x28,%esp
    int *status;

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
80106aab:	89 44 24 08          	mov    %eax,0x8(%esp)
80106aaf:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ab2:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ab6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106abd:	e8 fe f2 ff ff       	call   80105dc0 <argptr>
80106ac2:	85 c0                	test   %eax,%eax
80106ac4:	78 12                	js     80106ad8 <sys_wait+0x38>
        return -1;
    return wait(status);
80106ac6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ac9:	89 04 24             	mov    %eax,(%esp)
80106acc:	e8 3f d9 ff ff       	call   80104410 <wait>
}
80106ad1:	c9                   	leave  
80106ad2:	c3                   	ret    
80106ad3:	90                   	nop
80106ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
sys_wait(void)
{
    int *status;

    if(argptr(0, (void*)&status, sizeof(*status)) < 0)
        return -1;
80106ad8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    return wait(status);
}
80106add:	c9                   	leave  
80106ade:	c3                   	ret    
80106adf:	90                   	nop

80106ae0 <sys_kill>:

int
sys_kill(void)
{
80106ae0:	55                   	push   %ebp
80106ae1:	89 e5                	mov    %esp,%ebp
80106ae3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106ae6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ae9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106aed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106af4:	e8 77 f2 ff ff       	call   80105d70 <argint>
80106af9:	85 c0                	test   %eax,%eax
80106afb:	78 13                	js     80106b10 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106afd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b00:	89 04 24             	mov    %eax,(%esp)
80106b03:	e8 48 da ff ff       	call   80104550 <kill>
}
80106b08:	c9                   	leave  
80106b09:	c3                   	ret    
80106b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80106b10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80106b15:	c9                   	leave  
80106b16:	c3                   	ret    
80106b17:	89 f6                	mov    %esi,%esi
80106b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b20 <sys_getpid>:

int
sys_getpid(void)
{
80106b20:	55                   	push   %ebp
80106b21:	89 e5                	mov    %esp,%ebp
80106b23:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106b26:	e8 35 ce ff ff       	call   80103960 <myproc>
80106b2b:	8b 40 10             	mov    0x10(%eax),%eax
}
80106b2e:	c9                   	leave  
80106b2f:	c3                   	ret    

80106b30 <sys_sbrk>:

int
sys_sbrk(void)
{
80106b30:	55                   	push   %ebp
80106b31:	89 e5                	mov    %esp,%ebp
80106b33:	53                   	push   %ebx
80106b34:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106b37:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b3a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b3e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b45:	e8 26 f2 ff ff       	call   80105d70 <argint>
80106b4a:	85 c0                	test   %eax,%eax
80106b4c:	78 22                	js     80106b70 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106b4e:	e8 0d ce ff ff       	call   80103960 <myproc>
80106b53:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b58:	89 04 24             	mov    %eax,(%esp)
80106b5b:	e8 a0 d0 ff ff       	call   80103c00 <growproc>
80106b60:	85 c0                	test   %eax,%eax
80106b62:	78 0c                	js     80106b70 <sys_sbrk+0x40>
    return -1;
  return addr;
80106b64:	89 d8                	mov    %ebx,%eax
}
80106b66:	83 c4 24             	add    $0x24,%esp
80106b69:	5b                   	pop    %ebx
80106b6a:	5d                   	pop    %ebp
80106b6b:	c3                   	ret    
80106b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80106b70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b75:	eb ef                	jmp    80106b66 <sys_sbrk+0x36>
80106b77:	89 f6                	mov    %esi,%esi
80106b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b80 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80106b80:	55                   	push   %ebp
80106b81:	89 e5                	mov    %esp,%ebp
80106b83:	53                   	push   %ebx
80106b84:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106b87:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b8a:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b8e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106b95:	e8 d6 f1 ff ff       	call   80105d70 <argint>
80106b9a:	85 c0                	test   %eax,%eax
80106b9c:	78 7e                	js     80106c1c <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
80106b9e:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106ba5:	e8 e6 ed ff ff       	call   80105990 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106baa:	8b 4d f4             	mov    -0xc(%ebp),%ecx
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80106bad:	8b 1d 00 80 11 80    	mov    0x80118000,%ebx
  while(ticks - ticks0 < n){
80106bb3:	85 c9                	test   %ecx,%ecx
80106bb5:	75 2a                	jne    80106be1 <sys_sleep+0x61>
80106bb7:	eb 4f                	jmp    80106c08 <sys_sleep+0x88>
80106bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106bc0:	b8 c0 77 11 80       	mov    $0x801177c0,%eax
80106bc5:	89 44 24 04          	mov    %eax,0x4(%esp)
80106bc9:	c7 04 24 00 80 11 80 	movl   $0x80118000,(%esp)
80106bd0:	e8 4b d7 ff ff       	call   80104320 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106bd5:	a1 00 80 11 80       	mov    0x80118000,%eax
80106bda:	29 d8                	sub    %ebx,%eax
80106bdc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106bdf:	73 27                	jae    80106c08 <sys_sleep+0x88>
    if(myproc()->killed){
80106be1:	e8 7a cd ff ff       	call   80103960 <myproc>
80106be6:	8b 50 24             	mov    0x24(%eax),%edx
80106be9:	85 d2                	test   %edx,%edx
80106beb:	74 d3                	je     80106bc0 <sys_sleep+0x40>
      release(&tickslock);
80106bed:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106bf4:	e8 37 ee ff ff       	call   80105a30 <release>
      return -1;
80106bf9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80106bfe:	83 c4 24             	add    $0x24,%esp
80106c01:	5b                   	pop    %ebx
80106c02:	5d                   	pop    %ebp
80106c03:	c3                   	ret    
80106c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80106c08:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106c0f:	e8 1c ee ff ff       	call   80105a30 <release>
  return 0;
}
80106c14:	83 c4 24             	add    $0x24,%esp
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
80106c17:	31 c0                	xor    %eax,%eax
}
80106c19:	5b                   	pop    %ebx
80106c1a:	5d                   	pop    %ebp
80106c1b:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80106c1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c21:	eb db                	jmp    80106bfe <sys_sleep+0x7e>
80106c23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c30 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106c30:	55                   	push   %ebp
80106c31:	89 e5                	mov    %esp,%ebp
80106c33:	53                   	push   %ebx
80106c34:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80106c37:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106c3e:	e8 4d ed ff ff       	call   80105990 <acquire>
  xticks = ticks;
80106c43:	8b 1d 00 80 11 80    	mov    0x80118000,%ebx
  release(&tickslock);
80106c49:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80106c50:	e8 db ed ff ff       	call   80105a30 <release>
  return xticks;
}
80106c55:	83 c4 14             	add    $0x14,%esp
80106c58:	89 d8                	mov    %ebx,%eax
80106c5a:	5b                   	pop    %ebx
80106c5b:	5d                   	pop    %ebp
80106c5c:	c3                   	ret    
80106c5d:	8d 76 00             	lea    0x0(%esi),%esi

80106c60 <sys_detach>:

int
sys_detach(void){
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	83 ec 28             	sub    $0x28,%esp
    int pid;
  if(argint(0, &pid) < 0)
80106c66:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c69:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c6d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106c74:	e8 f7 f0 ff ff       	call   80105d70 <argint>
80106c79:	85 c0                	test   %eax,%eax
80106c7b:	78 13                	js     80106c90 <sys_detach+0x30>
    return -1;
  return detach(pid);
80106c7d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c80:	89 04 24             	mov    %eax,(%esp)
80106c83:	e8 58 da ff ff       	call   801046e0 <detach>
}
80106c88:	c9                   	leave  
80106c89:	c3                   	ret    
80106c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

int
sys_detach(void){
    int pid;
  if(argint(0, &pid) < 0)
    return -1;
80106c90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return detach(pid);
}
80106c95:	c9                   	leave  
80106c96:	c3                   	ret    
80106c97:	89 f6                	mov    %esi,%esi
80106c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ca0 <sys_policy>:

int
sys_policy(void){
80106ca0:	55                   	push   %ebp
80106ca1:	89 e5                	mov    %esp,%ebp
80106ca3:	83 ec 28             	sub    $0x28,%esp
    int pid;
    if(argint(0, &pid) < 0)
80106ca6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ca9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106cad:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106cb4:	e8 b7 f0 ff ff       	call   80105d70 <argint>
80106cb9:	85 c0                	test   %eax,%eax
80106cbb:	78 13                	js     80106cd0 <sys_policy+0x30>
        return -1;
    policy(pid);
80106cbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106cc0:	89 04 24             	mov    %eax,(%esp)
80106cc3:	e8 d8 db ff ff       	call   801048a0 <policy>
    return 0;
80106cc8:	31 c0                	xor    %eax,%eax
}
80106cca:	c9                   	leave  
80106ccb:	c3                   	ret    
80106ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

int
sys_policy(void){
    int pid;
    if(argint(0, &pid) < 0)
        return -1;
80106cd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    policy(pid);
    return 0;
}
80106cd5:	c9                   	leave  
80106cd6:	c3                   	ret    
80106cd7:	89 f6                	mov    %esi,%esi
80106cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106ce0 <sys_priority>:

//TODO -need to understand how to call this sys_call
int
sys_priority(void){
80106ce0:	55                   	push   %ebp
80106ce1:	89 e5                	mov    %esp,%ebp
80106ce3:	83 ec 28             	sub    $0x28,%esp
    int pid;
    if(argint(0, &pid) < 0)
80106ce6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ce9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ced:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106cf4:	e8 77 f0 ff ff       	call   80105d70 <argint>
80106cf9:	85 c0                	test   %eax,%eax
80106cfb:	78 13                	js     80106d10 <sys_priority+0x30>
        return -1;
    priority(pid);
80106cfd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d00:	89 04 24             	mov    %eax,(%esp)
80106d03:	e8 68 da ff ff       	call   80104770 <priority>
    return 0;
80106d08:	31 c0                	xor    %eax,%eax
}
80106d0a:	c9                   	leave  
80106d0b:	c3                   	ret    
80106d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
//TODO -need to understand how to call this sys_call
int
sys_priority(void){
    int pid;
    if(argint(0, &pid) < 0)
        return -1;
80106d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    priority(pid);
    return 0;
}
80106d15:	c9                   	leave  
80106d16:	c3                   	ret    
80106d17:	89 f6                	mov    %esi,%esi
80106d19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d20 <sys_wait_stat>:


int
sys_wait_stat(void)
{
80106d20:	55                   	push   %ebp
  //TODO - add perf struct to the args of the function
  return 0;
}
80106d21:	31 c0                	xor    %eax,%eax
}


int
sys_wait_stat(void)
{
80106d23:	89 e5                	mov    %esp,%ebp
  //TODO - add perf struct to the args of the function
  return 0;
}
80106d25:	5d                   	pop    %ebp
80106d26:	c3                   	ret    

80106d27 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106d27:	1e                   	push   %ds
  pushl %es
80106d28:	06                   	push   %es
  pushl %fs
80106d29:	0f a0                	push   %fs
  pushl %gs
80106d2b:	0f a8                	push   %gs
  pushal
80106d2d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106d2e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106d32:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106d34:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106d36:	54                   	push   %esp
  call trap
80106d37:	e8 e4 00 00 00       	call   80106e20 <trap>
  addl $4, %esp
80106d3c:	83 c4 04             	add    $0x4,%esp

80106d3f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106d3f:	61                   	popa   
  popl %gs
80106d40:	0f a9                	pop    %gs
  popl %fs
80106d42:	0f a1                	pop    %fs
  popl %es
80106d44:	07                   	pop    %es
  popl %ds
80106d45:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106d46:	83 c4 08             	add    $0x8,%esp
  iret
80106d49:	cf                   	iret   
80106d4a:	66 90                	xchg   %ax,%ax
80106d4c:	66 90                	xchg   %ax,%ax
80106d4e:	66 90                	xchg   %ax,%ax

80106d50 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106d50:	31 c0                	xor    %eax,%eax
80106d52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106d60:	8b 14 85 0c c0 10 80 	mov    -0x7fef3ff4(,%eax,4),%edx
80106d67:	b9 08 00 00 00       	mov    $0x8,%ecx
80106d6c:	66 89 0c c5 02 78 11 	mov    %cx,-0x7fee87fe(,%eax,8)
80106d73:	80 
80106d74:	31 c9                	xor    %ecx,%ecx
80106d76:	88 0c c5 04 78 11 80 	mov    %cl,-0x7fee87fc(,%eax,8)
80106d7d:	b1 8e                	mov    $0x8e,%cl
80106d7f:	88 0c c5 05 78 11 80 	mov    %cl,-0x7fee87fb(,%eax,8)
80106d86:	66 89 14 c5 00 78 11 	mov    %dx,-0x7fee8800(,%eax,8)
80106d8d:	80 
80106d8e:	c1 ea 10             	shr    $0x10,%edx
80106d91:	66 89 14 c5 06 78 11 	mov    %dx,-0x7fee87fa(,%eax,8)
80106d98:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106d99:	40                   	inc    %eax
80106d9a:	3d 00 01 00 00       	cmp    $0x100,%eax
80106d9f:	75 bf                	jne    80106d60 <tvinit+0x10>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106da1:	55                   	push   %ebp

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80106da2:	b9 25 8f 10 80       	mov    $0x80108f25,%ecx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106da7:	89 e5                	mov    %esp,%ebp
80106da9:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106dac:	a1 0c c1 10 80       	mov    0x8010c10c,%eax
80106db1:	ba 08 00 00 00       	mov    $0x8,%edx

  initlock(&tickslock, "time");
80106db6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106dba:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106dc1:	66 89 15 02 7a 11 80 	mov    %dx,0x80117a02
80106dc8:	66 a3 00 7a 11 80    	mov    %ax,0x80117a00
80106dce:	c1 e8 10             	shr    $0x10,%eax
80106dd1:	c6 05 04 7a 11 80 00 	movb   $0x0,0x80117a04
80106dd8:	c6 05 05 7a 11 80 ef 	movb   $0xef,0x80117a05
80106ddf:	66 a3 06 7a 11 80    	mov    %ax,0x80117a06

  initlock(&tickslock, "time");
80106de5:	e8 46 ea ff ff       	call   80105830 <initlock>
}
80106dea:	c9                   	leave  
80106deb:	c3                   	ret    
80106dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106df0 <idtinit>:

void
idtinit(void)
{
80106df0:	55                   	push   %ebp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
80106df1:	b8 00 78 11 80       	mov    $0x80117800,%eax
80106df6:	89 e5                	mov    %esp,%ebp
80106df8:	0f b7 d0             	movzwl %ax,%edx
  pd[2] = (uint)p >> 16;
80106dfb:	c1 e8 10             	shr    $0x10,%eax
80106dfe:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106e01:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80106e07:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106e0b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80106e0f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106e12:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106e15:	c9                   	leave  
80106e16:	c3                   	ret    
80106e17:	89 f6                	mov    %esi,%esi
80106e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e20 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106e20:	55                   	push   %ebp
80106e21:	89 e5                	mov    %esp,%ebp
80106e23:	83 ec 48             	sub    $0x48,%esp
80106e26:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106e2c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106e2f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
80106e32:	8b 43 30             	mov    0x30(%ebx),%eax
80106e35:	83 f8 40             	cmp    $0x40,%eax
80106e38:	0f 84 b2 01 00 00    	je     80106ff0 <trap+0x1d0>
    if(myproc()->killed)
      exit(0);
    return;
  }

  switch(tf->trapno){
80106e3e:	83 e8 20             	sub    $0x20,%eax
80106e41:	83 f8 1f             	cmp    $0x1f,%eax
80106e44:	77 0a                	ja     80106e50 <trap+0x30>
80106e46:	ff 24 85 cc 8f 10 80 	jmp    *-0x7fef7034(,%eax,4)
80106e4d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106e50:	e8 0b cb ff ff       	call   80103960 <myproc>
80106e55:	85 c0                	test   %eax,%eax
80106e57:	0f 84 22 02 00 00    	je     8010707f <trap+0x25f>
80106e5d:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106e61:	0f 84 18 02 00 00    	je     8010707f <trap+0x25f>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106e67:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e6a:	8b 53 38             	mov    0x38(%ebx),%edx
80106e6d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80106e70:	89 55 dc             	mov    %edx,-0x24(%ebp)
80106e73:	e8 c8 ca ff ff       	call   80103940 <cpuid>
80106e78:	8b 73 30             	mov    0x30(%ebx),%esi
80106e7b:	89 c7                	mov    %eax,%edi
80106e7d:	8b 43 34             	mov    0x34(%ebx),%eax
80106e80:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106e83:	e8 d8 ca ff ff       	call   80103960 <myproc>
80106e88:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106e8b:	e8 d0 ca ff ff       	call   80103960 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e90:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106e93:	89 74 24 0c          	mov    %esi,0xc(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106e97:	8b 75 e0             	mov    -0x20(%ebp),%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e9a:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106e9d:	89 7c 24 14          	mov    %edi,0x14(%esp)
80106ea1:	89 54 24 18          	mov    %edx,0x18(%esp)
80106ea5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106ea8:	83 c6 6c             	add    $0x6c,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106eab:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80106eaf:	89 74 24 08          	mov    %esi,0x8(%esp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106eb3:	89 54 24 10          	mov    %edx,0x10(%esp)
80106eb7:	8b 40 10             	mov    0x10(%eax),%eax
80106eba:	c7 04 24 88 8f 10 80 	movl   $0x80108f88,(%esp)
80106ec1:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ec5:	e8 76 97 ff ff       	call   80100640 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106eca:	e8 91 ca ff ff       	call   80103960 <myproc>
80106ecf:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106ed6:	8d 76 00             	lea    0x0(%esi),%esi
80106ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106ee0:	e8 7b ca ff ff       	call   80103960 <myproc>
80106ee5:	85 c0                	test   %eax,%eax
80106ee7:	74 0c                	je     80106ef5 <trap+0xd5>
80106ee9:	e8 72 ca ff ff       	call   80103960 <myproc>
80106eee:	8b 50 24             	mov    0x24(%eax),%edx
80106ef1:	85 d2                	test   %edx,%edx
80106ef3:	75 4b                	jne    80106f40 <trap+0x120>
    exit(0);

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106ef5:	e8 66 ca ff ff       	call   80103960 <myproc>
80106efa:	85 c0                	test   %eax,%eax
80106efc:	74 0f                	je     80106f0d <trap+0xed>
80106efe:	66 90                	xchg   %ax,%ax
80106f00:	e8 5b ca ff ff       	call   80103960 <myproc>
80106f05:	8b 40 0c             	mov    0xc(%eax),%eax
80106f08:	83 f8 04             	cmp    $0x4,%eax
80106f0b:	74 53                	je     80106f60 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106f0d:	e8 4e ca ff ff       	call   80103960 <myproc>
80106f12:	85 c0                	test   %eax,%eax
80106f14:	74 1b                	je     80106f31 <trap+0x111>
80106f16:	e8 45 ca ff ff       	call   80103960 <myproc>
80106f1b:	8b 40 24             	mov    0x24(%eax),%eax
80106f1e:	85 c0                	test   %eax,%eax
80106f20:	74 0f                	je     80106f31 <trap+0x111>
80106f22:	8b 43 3c             	mov    0x3c(%ebx),%eax
80106f25:	83 e0 03             	and    $0x3,%eax
80106f28:	83 f8 03             	cmp    $0x3,%eax
80106f2b:	0f 84 e8 00 00 00    	je     80107019 <trap+0x1f9>
    exit(0);
}
80106f31:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80106f34:	8b 75 f8             	mov    -0x8(%ebp),%esi
80106f37:	8b 7d fc             	mov    -0x4(%ebp),%edi
80106f3a:	89 ec                	mov    %ebp,%esp
80106f3c:	5d                   	pop    %ebp
80106f3d:	c3                   	ret    
80106f3e:	66 90                	xchg   %ax,%ax
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106f40:	8b 43 3c             	mov    0x3c(%ebx),%eax
80106f43:	83 e0 03             	and    $0x3,%eax
80106f46:	83 f8 03             	cmp    $0x3,%eax
80106f49:	75 aa                	jne    80106ef5 <trap+0xd5>
    exit(0);
80106f4b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106f52:	e8 d9 d1 ff ff       	call   80104130 <exit>
80106f57:	eb 9c                	jmp    80106ef5 <trap+0xd5>
80106f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106f60:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106f64:	75 a7                	jne    80106f0d <trap+0xed>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80106f66:	e8 c5 d2 ff ff       	call   80104230 <yield>
80106f6b:	eb a0                	jmp    80106f0d <trap+0xed>
80106f6d:	8d 76 00             	lea    0x0(%esi),%esi
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80106f70:	e8 cb c9 ff ff       	call   80103940 <cpuid>
80106f75:	85 c0                	test   %eax,%eax
80106f77:	0f 84 d3 00 00 00    	je     80107050 <trap+0x230>
80106f7d:	8d 76 00             	lea    0x0(%esi),%esi
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
80106f80:	e8 5b b8 ff ff       	call   801027e0 <lapiceoi>
    break;
80106f85:	e9 56 ff ff ff       	jmp    80106ee0 <trap+0xc0>
80106f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106f90:	e8 0b b7 ff ff       	call   801026a0 <kbdintr>
    lapiceoi();
80106f95:	e8 46 b8 ff ff       	call   801027e0 <lapiceoi>
    break;
80106f9a:	e9 41 ff ff ff       	jmp    80106ee0 <trap+0xc0>
80106f9f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106fa0:	e8 7b 02 00 00       	call   80107220 <uartintr>
    lapiceoi();
80106fa5:	e8 36 b8 ff ff       	call   801027e0 <lapiceoi>
    break;
80106faa:	e9 31 ff ff ff       	jmp    80106ee0 <trap+0xc0>
80106faf:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106fb0:	8b 7b 38             	mov    0x38(%ebx),%edi
80106fb3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106fb7:	e8 84 c9 ff ff       	call   80103940 <cpuid>
80106fbc:	c7 04 24 30 8f 10 80 	movl   $0x80108f30,(%esp)
80106fc3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80106fc7:	89 74 24 08          	mov    %esi,0x8(%esp)
80106fcb:	89 44 24 04          	mov    %eax,0x4(%esp)
80106fcf:	e8 6c 96 ff ff       	call   80100640 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
80106fd4:	e8 07 b8 ff ff       	call   801027e0 <lapiceoi>
    break;
80106fd9:	e9 02 ff ff ff       	jmp    80106ee0 <trap+0xc0>
80106fde:	66 90                	xchg   %ax,%ax
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106fe0:	e8 3b b1 ff ff       	call   80102120 <ideintr>
80106fe5:	eb 96                	jmp    80106f7d <trap+0x15d>
80106fe7:	89 f6                	mov    %esi,%esi
80106fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80106ff0:	e8 6b c9 ff ff       	call   80103960 <myproc>
80106ff5:	8b 70 24             	mov    0x24(%eax),%esi
80106ff8:	85 f6                	test   %esi,%esi
80106ffa:	75 3c                	jne    80107038 <trap+0x218>
      exit(0);
    myproc()->tf = tf;
80106ffc:	e8 5f c9 ff ff       	call   80103960 <myproc>
80107001:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80107004:	e8 57 ee ff ff       	call   80105e60 <syscall>
    if(myproc()->killed)
80107009:	e8 52 c9 ff ff       	call   80103960 <myproc>
8010700e:	8b 48 24             	mov    0x24(%eax),%ecx
80107011:	85 c9                	test   %ecx,%ecx
80107013:	0f 84 18 ff ff ff    	je     80106f31 <trap+0x111>
      exit(0);
80107019:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit(0);
}
80107020:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107023:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107026:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107029:	89 ec                	mov    %ebp,%esp
8010702b:	5d                   	pop    %ebp
    if(myproc()->killed)
      exit(0);
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit(0);
8010702c:	e9 ff d0 ff ff       	jmp    80104130 <exit>
80107031:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit(0);
80107038:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010703f:	e8 ec d0 ff ff       	call   80104130 <exit>
80107044:	eb b6                	jmp    80106ffc <trap+0x1dc>
80107046:	8d 76 00             	lea    0x0(%esi),%esi
80107049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
80107050:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80107057:	e8 34 e9 ff ff       	call   80105990 <acquire>
      ticks++;
      wakeup(&ticks);
8010705c:	c7 04 24 00 80 11 80 	movl   $0x80118000,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
80107063:	ff 05 00 80 11 80    	incl   0x80118000
      wakeup(&ticks);
80107069:	e8 b2 d4 ff ff       	call   80104520 <wakeup>
      release(&tickslock);
8010706e:	c7 04 24 c0 77 11 80 	movl   $0x801177c0,(%esp)
80107075:	e8 b6 e9 ff ff       	call   80105a30 <release>
8010707a:	e9 fe fe ff ff       	jmp    80106f7d <trap+0x15d>
8010707f:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107082:	8b 73 38             	mov    0x38(%ebx),%esi
80107085:	e8 b6 c8 ff ff       	call   80103940 <cpuid>
8010708a:	89 7c 24 10          	mov    %edi,0x10(%esp)
8010708e:	89 74 24 0c          	mov    %esi,0xc(%esp)
80107092:	89 44 24 08          	mov    %eax,0x8(%esp)
80107096:	8b 43 30             	mov    0x30(%ebx),%eax
80107099:	c7 04 24 54 8f 10 80 	movl   $0x80108f54,(%esp)
801070a0:	89 44 24 04          	mov    %eax,0x4(%esp)
801070a4:	e8 97 95 ff ff       	call   80100640 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
801070a9:	c7 04 24 2a 8f 10 80 	movl   $0x80108f2a,(%esp)
801070b0:	e8 8b 92 ff ff       	call   80100340 <panic>
801070b5:	66 90                	xchg   %ax,%ax
801070b7:	66 90                	xchg   %ax,%ax
801070b9:	66 90                	xchg   %ax,%ax
801070bb:	66 90                	xchg   %ax,%ax
801070bd:	66 90                	xchg   %ax,%ax
801070bf:	90                   	nop

801070c0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801070c0:	a1 18 c6 10 80       	mov    0x8010c618,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801070c5:	55                   	push   %ebp
801070c6:	89 e5                	mov    %esp,%ebp
  if(!uart)
801070c8:	85 c0                	test   %eax,%eax
801070ca:	74 1c                	je     801070e8 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801070cc:	ba fd 03 00 00       	mov    $0x3fd,%edx
801070d1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801070d2:	24 01                	and    $0x1,%al
801070d4:	84 c0                	test   %al,%al
801070d6:	74 10                	je     801070e8 <uartgetc+0x28>
801070d8:	ba f8 03 00 00       	mov    $0x3f8,%edx
801070dd:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801070de:	0f b6 c0             	movzbl %al,%eax
}
801070e1:	5d                   	pop    %ebp
801070e2:	c3                   	ret    
801070e3:	90                   	nop
801070e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
801070e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
801070ed:	5d                   	pop    %ebp
801070ee:	c3                   	ret    
801070ef:	90                   	nop

801070f0 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
801070f0:	55                   	push   %ebp
801070f1:	89 e5                	mov    %esp,%ebp
801070f3:	57                   	push   %edi
801070f4:	bf fd 03 00 00       	mov    $0x3fd,%edi
801070f9:	56                   	push   %esi
801070fa:	be 80 00 00 00       	mov    $0x80,%esi
801070ff:	53                   	push   %ebx
80107100:	89 c3                	mov    %eax,%ebx
80107102:	83 ec 1c             	sub    $0x1c,%esp
80107105:	eb 18                	jmp    8010711f <uartputc.part.0+0x2f>
80107107:	89 f6                	mov    %esi,%esi
80107109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80107110:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80107117:	e8 e4 b6 ff ff       	call   80102800 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010711c:	4e                   	dec    %esi
8010711d:	74 09                	je     80107128 <uartputc.part.0+0x38>
8010711f:	89 fa                	mov    %edi,%edx
80107121:	ec                   	in     (%dx),%al
80107122:	24 20                	and    $0x20,%al
80107124:	84 c0                	test   %al,%al
80107126:	74 e8                	je     80107110 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107128:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010712d:	88 d8                	mov    %bl,%al
8010712f:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80107130:	83 c4 1c             	add    $0x1c,%esp
80107133:	5b                   	pop    %ebx
80107134:	5e                   	pop    %esi
80107135:	5f                   	pop    %edi
80107136:	5d                   	pop    %ebp
80107137:	c3                   	ret    
80107138:	90                   	nop
80107139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107140 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80107140:	55                   	push   %ebp
80107141:	31 c9                	xor    %ecx,%ecx
80107143:	89 e5                	mov    %esp,%ebp
80107145:	88 c8                	mov    %cl,%al
80107147:	57                   	push   %edi
80107148:	56                   	push   %esi
80107149:	53                   	push   %ebx
8010714a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010714f:	83 ec 1c             	sub    $0x1c,%esp
80107152:	89 da                	mov    %ebx,%edx
80107154:	ee                   	out    %al,(%dx)
80107155:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010715a:	b0 80                	mov    $0x80,%al
8010715c:	89 fa                	mov    %edi,%edx
8010715e:	ee                   	out    %al,(%dx)
8010715f:	b0 0c                	mov    $0xc,%al
80107161:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107166:	ee                   	out    %al,(%dx)
80107167:	be f9 03 00 00       	mov    $0x3f9,%esi
8010716c:	88 c8                	mov    %cl,%al
8010716e:	89 f2                	mov    %esi,%edx
80107170:	ee                   	out    %al,(%dx)
80107171:	b0 03                	mov    $0x3,%al
80107173:	89 fa                	mov    %edi,%edx
80107175:	ee                   	out    %al,(%dx)
80107176:	ba fc 03 00 00       	mov    $0x3fc,%edx
8010717b:	88 c8                	mov    %cl,%al
8010717d:	ee                   	out    %al,(%dx)
8010717e:	b0 01                	mov    $0x1,%al
80107180:	89 f2                	mov    %esi,%edx
80107182:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107183:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107188:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80107189:	fe c0                	inc    %al
8010718b:	74 52                	je     801071df <uartinit+0x9f>
    return;
  uart = 1;
8010718d:	b9 01 00 00 00       	mov    $0x1,%ecx
80107192:	89 da                	mov    %ebx,%edx
80107194:	89 0d 18 c6 10 80    	mov    %ecx,0x8010c618
8010719a:	ec                   	in     (%dx),%al
8010719b:	ba f8 03 00 00       	mov    $0x3f8,%edx
801071a0:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
801071a1:	31 db                	xor    %ebx,%ebx
801071a3:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801071a7:	bb 4c 90 10 80       	mov    $0x8010904c,%ebx
801071ac:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
801071b3:	e8 98 b1 ff ff       	call   80102350 <ioapicenable>
801071b8:	b8 78 00 00 00       	mov    $0x78,%eax
801071bd:	eb 09                	jmp    801071c8 <uartinit+0x88>
801071bf:	90                   	nop

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801071c0:	43                   	inc    %ebx
801071c1:	0f be 03             	movsbl (%ebx),%eax
801071c4:	84 c0                	test   %al,%al
801071c6:	74 17                	je     801071df <uartinit+0x9f>
void
uartputc(int c)
{
  int i;

  if(!uart)
801071c8:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
801071ce:	85 d2                	test   %edx,%edx
801071d0:	74 ee                	je     801071c0 <uartinit+0x80>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801071d2:	43                   	inc    %ebx
801071d3:	e8 18 ff ff ff       	call   801070f0 <uartputc.part.0>
801071d8:	0f be 03             	movsbl (%ebx),%eax
801071db:	84 c0                	test   %al,%al
801071dd:	75 e9                	jne    801071c8 <uartinit+0x88>
    uartputc(*p);
}
801071df:	83 c4 1c             	add    $0x1c,%esp
801071e2:	5b                   	pop    %ebx
801071e3:	5e                   	pop    %esi
801071e4:	5f                   	pop    %edi
801071e5:	5d                   	pop    %ebp
801071e6:	c3                   	ret    
801071e7:	89 f6                	mov    %esi,%esi
801071e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801071f0 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
801071f0:	8b 15 18 c6 10 80    	mov    0x8010c618,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
801071f6:	55                   	push   %ebp
801071f7:	89 e5                	mov    %esp,%ebp
801071f9:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
801071fc:	85 d2                	test   %edx,%edx
801071fe:	74 10                	je     80107210 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80107200:	5d                   	pop    %ebp
80107201:	e9 ea fe ff ff       	jmp    801070f0 <uartputc.part.0>
80107206:	8d 76 00             	lea    0x0(%esi),%esi
80107209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107210:	5d                   	pop    %ebp
80107211:	c3                   	ret    
80107212:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107220 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80107220:	55                   	push   %ebp
80107221:	89 e5                	mov    %esp,%ebp
80107223:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80107226:	c7 04 24 c0 70 10 80 	movl   $0x801070c0,(%esp)
8010722d:	e8 7e 95 ff ff       	call   801007b0 <consoleintr>
}
80107232:	c9                   	leave  
80107233:	c3                   	ret    

80107234 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80107234:	6a 00                	push   $0x0
  pushl $0
80107236:	6a 00                	push   $0x0
  jmp alltraps
80107238:	e9 ea fa ff ff       	jmp    80106d27 <alltraps>

8010723d <vector1>:
.globl vector1
vector1:
  pushl $0
8010723d:	6a 00                	push   $0x0
  pushl $1
8010723f:	6a 01                	push   $0x1
  jmp alltraps
80107241:	e9 e1 fa ff ff       	jmp    80106d27 <alltraps>

80107246 <vector2>:
.globl vector2
vector2:
  pushl $0
80107246:	6a 00                	push   $0x0
  pushl $2
80107248:	6a 02                	push   $0x2
  jmp alltraps
8010724a:	e9 d8 fa ff ff       	jmp    80106d27 <alltraps>

8010724f <vector3>:
.globl vector3
vector3:
  pushl $0
8010724f:	6a 00                	push   $0x0
  pushl $3
80107251:	6a 03                	push   $0x3
  jmp alltraps
80107253:	e9 cf fa ff ff       	jmp    80106d27 <alltraps>

80107258 <vector4>:
.globl vector4
vector4:
  pushl $0
80107258:	6a 00                	push   $0x0
  pushl $4
8010725a:	6a 04                	push   $0x4
  jmp alltraps
8010725c:	e9 c6 fa ff ff       	jmp    80106d27 <alltraps>

80107261 <vector5>:
.globl vector5
vector5:
  pushl $0
80107261:	6a 00                	push   $0x0
  pushl $5
80107263:	6a 05                	push   $0x5
  jmp alltraps
80107265:	e9 bd fa ff ff       	jmp    80106d27 <alltraps>

8010726a <vector6>:
.globl vector6
vector6:
  pushl $0
8010726a:	6a 00                	push   $0x0
  pushl $6
8010726c:	6a 06                	push   $0x6
  jmp alltraps
8010726e:	e9 b4 fa ff ff       	jmp    80106d27 <alltraps>

80107273 <vector7>:
.globl vector7
vector7:
  pushl $0
80107273:	6a 00                	push   $0x0
  pushl $7
80107275:	6a 07                	push   $0x7
  jmp alltraps
80107277:	e9 ab fa ff ff       	jmp    80106d27 <alltraps>

8010727c <vector8>:
.globl vector8
vector8:
  pushl $8
8010727c:	6a 08                	push   $0x8
  jmp alltraps
8010727e:	e9 a4 fa ff ff       	jmp    80106d27 <alltraps>

80107283 <vector9>:
.globl vector9
vector9:
  pushl $0
80107283:	6a 00                	push   $0x0
  pushl $9
80107285:	6a 09                	push   $0x9
  jmp alltraps
80107287:	e9 9b fa ff ff       	jmp    80106d27 <alltraps>

8010728c <vector10>:
.globl vector10
vector10:
  pushl $10
8010728c:	6a 0a                	push   $0xa
  jmp alltraps
8010728e:	e9 94 fa ff ff       	jmp    80106d27 <alltraps>

80107293 <vector11>:
.globl vector11
vector11:
  pushl $11
80107293:	6a 0b                	push   $0xb
  jmp alltraps
80107295:	e9 8d fa ff ff       	jmp    80106d27 <alltraps>

8010729a <vector12>:
.globl vector12
vector12:
  pushl $12
8010729a:	6a 0c                	push   $0xc
  jmp alltraps
8010729c:	e9 86 fa ff ff       	jmp    80106d27 <alltraps>

801072a1 <vector13>:
.globl vector13
vector13:
  pushl $13
801072a1:	6a 0d                	push   $0xd
  jmp alltraps
801072a3:	e9 7f fa ff ff       	jmp    80106d27 <alltraps>

801072a8 <vector14>:
.globl vector14
vector14:
  pushl $14
801072a8:	6a 0e                	push   $0xe
  jmp alltraps
801072aa:	e9 78 fa ff ff       	jmp    80106d27 <alltraps>

801072af <vector15>:
.globl vector15
vector15:
  pushl $0
801072af:	6a 00                	push   $0x0
  pushl $15
801072b1:	6a 0f                	push   $0xf
  jmp alltraps
801072b3:	e9 6f fa ff ff       	jmp    80106d27 <alltraps>

801072b8 <vector16>:
.globl vector16
vector16:
  pushl $0
801072b8:	6a 00                	push   $0x0
  pushl $16
801072ba:	6a 10                	push   $0x10
  jmp alltraps
801072bc:	e9 66 fa ff ff       	jmp    80106d27 <alltraps>

801072c1 <vector17>:
.globl vector17
vector17:
  pushl $17
801072c1:	6a 11                	push   $0x11
  jmp alltraps
801072c3:	e9 5f fa ff ff       	jmp    80106d27 <alltraps>

801072c8 <vector18>:
.globl vector18
vector18:
  pushl $0
801072c8:	6a 00                	push   $0x0
  pushl $18
801072ca:	6a 12                	push   $0x12
  jmp alltraps
801072cc:	e9 56 fa ff ff       	jmp    80106d27 <alltraps>

801072d1 <vector19>:
.globl vector19
vector19:
  pushl $0
801072d1:	6a 00                	push   $0x0
  pushl $19
801072d3:	6a 13                	push   $0x13
  jmp alltraps
801072d5:	e9 4d fa ff ff       	jmp    80106d27 <alltraps>

801072da <vector20>:
.globl vector20
vector20:
  pushl $0
801072da:	6a 00                	push   $0x0
  pushl $20
801072dc:	6a 14                	push   $0x14
  jmp alltraps
801072de:	e9 44 fa ff ff       	jmp    80106d27 <alltraps>

801072e3 <vector21>:
.globl vector21
vector21:
  pushl $0
801072e3:	6a 00                	push   $0x0
  pushl $21
801072e5:	6a 15                	push   $0x15
  jmp alltraps
801072e7:	e9 3b fa ff ff       	jmp    80106d27 <alltraps>

801072ec <vector22>:
.globl vector22
vector22:
  pushl $0
801072ec:	6a 00                	push   $0x0
  pushl $22
801072ee:	6a 16                	push   $0x16
  jmp alltraps
801072f0:	e9 32 fa ff ff       	jmp    80106d27 <alltraps>

801072f5 <vector23>:
.globl vector23
vector23:
  pushl $0
801072f5:	6a 00                	push   $0x0
  pushl $23
801072f7:	6a 17                	push   $0x17
  jmp alltraps
801072f9:	e9 29 fa ff ff       	jmp    80106d27 <alltraps>

801072fe <vector24>:
.globl vector24
vector24:
  pushl $0
801072fe:	6a 00                	push   $0x0
  pushl $24
80107300:	6a 18                	push   $0x18
  jmp alltraps
80107302:	e9 20 fa ff ff       	jmp    80106d27 <alltraps>

80107307 <vector25>:
.globl vector25
vector25:
  pushl $0
80107307:	6a 00                	push   $0x0
  pushl $25
80107309:	6a 19                	push   $0x19
  jmp alltraps
8010730b:	e9 17 fa ff ff       	jmp    80106d27 <alltraps>

80107310 <vector26>:
.globl vector26
vector26:
  pushl $0
80107310:	6a 00                	push   $0x0
  pushl $26
80107312:	6a 1a                	push   $0x1a
  jmp alltraps
80107314:	e9 0e fa ff ff       	jmp    80106d27 <alltraps>

80107319 <vector27>:
.globl vector27
vector27:
  pushl $0
80107319:	6a 00                	push   $0x0
  pushl $27
8010731b:	6a 1b                	push   $0x1b
  jmp alltraps
8010731d:	e9 05 fa ff ff       	jmp    80106d27 <alltraps>

80107322 <vector28>:
.globl vector28
vector28:
  pushl $0
80107322:	6a 00                	push   $0x0
  pushl $28
80107324:	6a 1c                	push   $0x1c
  jmp alltraps
80107326:	e9 fc f9 ff ff       	jmp    80106d27 <alltraps>

8010732b <vector29>:
.globl vector29
vector29:
  pushl $0
8010732b:	6a 00                	push   $0x0
  pushl $29
8010732d:	6a 1d                	push   $0x1d
  jmp alltraps
8010732f:	e9 f3 f9 ff ff       	jmp    80106d27 <alltraps>

80107334 <vector30>:
.globl vector30
vector30:
  pushl $0
80107334:	6a 00                	push   $0x0
  pushl $30
80107336:	6a 1e                	push   $0x1e
  jmp alltraps
80107338:	e9 ea f9 ff ff       	jmp    80106d27 <alltraps>

8010733d <vector31>:
.globl vector31
vector31:
  pushl $0
8010733d:	6a 00                	push   $0x0
  pushl $31
8010733f:	6a 1f                	push   $0x1f
  jmp alltraps
80107341:	e9 e1 f9 ff ff       	jmp    80106d27 <alltraps>

80107346 <vector32>:
.globl vector32
vector32:
  pushl $0
80107346:	6a 00                	push   $0x0
  pushl $32
80107348:	6a 20                	push   $0x20
  jmp alltraps
8010734a:	e9 d8 f9 ff ff       	jmp    80106d27 <alltraps>

8010734f <vector33>:
.globl vector33
vector33:
  pushl $0
8010734f:	6a 00                	push   $0x0
  pushl $33
80107351:	6a 21                	push   $0x21
  jmp alltraps
80107353:	e9 cf f9 ff ff       	jmp    80106d27 <alltraps>

80107358 <vector34>:
.globl vector34
vector34:
  pushl $0
80107358:	6a 00                	push   $0x0
  pushl $34
8010735a:	6a 22                	push   $0x22
  jmp alltraps
8010735c:	e9 c6 f9 ff ff       	jmp    80106d27 <alltraps>

80107361 <vector35>:
.globl vector35
vector35:
  pushl $0
80107361:	6a 00                	push   $0x0
  pushl $35
80107363:	6a 23                	push   $0x23
  jmp alltraps
80107365:	e9 bd f9 ff ff       	jmp    80106d27 <alltraps>

8010736a <vector36>:
.globl vector36
vector36:
  pushl $0
8010736a:	6a 00                	push   $0x0
  pushl $36
8010736c:	6a 24                	push   $0x24
  jmp alltraps
8010736e:	e9 b4 f9 ff ff       	jmp    80106d27 <alltraps>

80107373 <vector37>:
.globl vector37
vector37:
  pushl $0
80107373:	6a 00                	push   $0x0
  pushl $37
80107375:	6a 25                	push   $0x25
  jmp alltraps
80107377:	e9 ab f9 ff ff       	jmp    80106d27 <alltraps>

8010737c <vector38>:
.globl vector38
vector38:
  pushl $0
8010737c:	6a 00                	push   $0x0
  pushl $38
8010737e:	6a 26                	push   $0x26
  jmp alltraps
80107380:	e9 a2 f9 ff ff       	jmp    80106d27 <alltraps>

80107385 <vector39>:
.globl vector39
vector39:
  pushl $0
80107385:	6a 00                	push   $0x0
  pushl $39
80107387:	6a 27                	push   $0x27
  jmp alltraps
80107389:	e9 99 f9 ff ff       	jmp    80106d27 <alltraps>

8010738e <vector40>:
.globl vector40
vector40:
  pushl $0
8010738e:	6a 00                	push   $0x0
  pushl $40
80107390:	6a 28                	push   $0x28
  jmp alltraps
80107392:	e9 90 f9 ff ff       	jmp    80106d27 <alltraps>

80107397 <vector41>:
.globl vector41
vector41:
  pushl $0
80107397:	6a 00                	push   $0x0
  pushl $41
80107399:	6a 29                	push   $0x29
  jmp alltraps
8010739b:	e9 87 f9 ff ff       	jmp    80106d27 <alltraps>

801073a0 <vector42>:
.globl vector42
vector42:
  pushl $0
801073a0:	6a 00                	push   $0x0
  pushl $42
801073a2:	6a 2a                	push   $0x2a
  jmp alltraps
801073a4:	e9 7e f9 ff ff       	jmp    80106d27 <alltraps>

801073a9 <vector43>:
.globl vector43
vector43:
  pushl $0
801073a9:	6a 00                	push   $0x0
  pushl $43
801073ab:	6a 2b                	push   $0x2b
  jmp alltraps
801073ad:	e9 75 f9 ff ff       	jmp    80106d27 <alltraps>

801073b2 <vector44>:
.globl vector44
vector44:
  pushl $0
801073b2:	6a 00                	push   $0x0
  pushl $44
801073b4:	6a 2c                	push   $0x2c
  jmp alltraps
801073b6:	e9 6c f9 ff ff       	jmp    80106d27 <alltraps>

801073bb <vector45>:
.globl vector45
vector45:
  pushl $0
801073bb:	6a 00                	push   $0x0
  pushl $45
801073bd:	6a 2d                	push   $0x2d
  jmp alltraps
801073bf:	e9 63 f9 ff ff       	jmp    80106d27 <alltraps>

801073c4 <vector46>:
.globl vector46
vector46:
  pushl $0
801073c4:	6a 00                	push   $0x0
  pushl $46
801073c6:	6a 2e                	push   $0x2e
  jmp alltraps
801073c8:	e9 5a f9 ff ff       	jmp    80106d27 <alltraps>

801073cd <vector47>:
.globl vector47
vector47:
  pushl $0
801073cd:	6a 00                	push   $0x0
  pushl $47
801073cf:	6a 2f                	push   $0x2f
  jmp alltraps
801073d1:	e9 51 f9 ff ff       	jmp    80106d27 <alltraps>

801073d6 <vector48>:
.globl vector48
vector48:
  pushl $0
801073d6:	6a 00                	push   $0x0
  pushl $48
801073d8:	6a 30                	push   $0x30
  jmp alltraps
801073da:	e9 48 f9 ff ff       	jmp    80106d27 <alltraps>

801073df <vector49>:
.globl vector49
vector49:
  pushl $0
801073df:	6a 00                	push   $0x0
  pushl $49
801073e1:	6a 31                	push   $0x31
  jmp alltraps
801073e3:	e9 3f f9 ff ff       	jmp    80106d27 <alltraps>

801073e8 <vector50>:
.globl vector50
vector50:
  pushl $0
801073e8:	6a 00                	push   $0x0
  pushl $50
801073ea:	6a 32                	push   $0x32
  jmp alltraps
801073ec:	e9 36 f9 ff ff       	jmp    80106d27 <alltraps>

801073f1 <vector51>:
.globl vector51
vector51:
  pushl $0
801073f1:	6a 00                	push   $0x0
  pushl $51
801073f3:	6a 33                	push   $0x33
  jmp alltraps
801073f5:	e9 2d f9 ff ff       	jmp    80106d27 <alltraps>

801073fa <vector52>:
.globl vector52
vector52:
  pushl $0
801073fa:	6a 00                	push   $0x0
  pushl $52
801073fc:	6a 34                	push   $0x34
  jmp alltraps
801073fe:	e9 24 f9 ff ff       	jmp    80106d27 <alltraps>

80107403 <vector53>:
.globl vector53
vector53:
  pushl $0
80107403:	6a 00                	push   $0x0
  pushl $53
80107405:	6a 35                	push   $0x35
  jmp alltraps
80107407:	e9 1b f9 ff ff       	jmp    80106d27 <alltraps>

8010740c <vector54>:
.globl vector54
vector54:
  pushl $0
8010740c:	6a 00                	push   $0x0
  pushl $54
8010740e:	6a 36                	push   $0x36
  jmp alltraps
80107410:	e9 12 f9 ff ff       	jmp    80106d27 <alltraps>

80107415 <vector55>:
.globl vector55
vector55:
  pushl $0
80107415:	6a 00                	push   $0x0
  pushl $55
80107417:	6a 37                	push   $0x37
  jmp alltraps
80107419:	e9 09 f9 ff ff       	jmp    80106d27 <alltraps>

8010741e <vector56>:
.globl vector56
vector56:
  pushl $0
8010741e:	6a 00                	push   $0x0
  pushl $56
80107420:	6a 38                	push   $0x38
  jmp alltraps
80107422:	e9 00 f9 ff ff       	jmp    80106d27 <alltraps>

80107427 <vector57>:
.globl vector57
vector57:
  pushl $0
80107427:	6a 00                	push   $0x0
  pushl $57
80107429:	6a 39                	push   $0x39
  jmp alltraps
8010742b:	e9 f7 f8 ff ff       	jmp    80106d27 <alltraps>

80107430 <vector58>:
.globl vector58
vector58:
  pushl $0
80107430:	6a 00                	push   $0x0
  pushl $58
80107432:	6a 3a                	push   $0x3a
  jmp alltraps
80107434:	e9 ee f8 ff ff       	jmp    80106d27 <alltraps>

80107439 <vector59>:
.globl vector59
vector59:
  pushl $0
80107439:	6a 00                	push   $0x0
  pushl $59
8010743b:	6a 3b                	push   $0x3b
  jmp alltraps
8010743d:	e9 e5 f8 ff ff       	jmp    80106d27 <alltraps>

80107442 <vector60>:
.globl vector60
vector60:
  pushl $0
80107442:	6a 00                	push   $0x0
  pushl $60
80107444:	6a 3c                	push   $0x3c
  jmp alltraps
80107446:	e9 dc f8 ff ff       	jmp    80106d27 <alltraps>

8010744b <vector61>:
.globl vector61
vector61:
  pushl $0
8010744b:	6a 00                	push   $0x0
  pushl $61
8010744d:	6a 3d                	push   $0x3d
  jmp alltraps
8010744f:	e9 d3 f8 ff ff       	jmp    80106d27 <alltraps>

80107454 <vector62>:
.globl vector62
vector62:
  pushl $0
80107454:	6a 00                	push   $0x0
  pushl $62
80107456:	6a 3e                	push   $0x3e
  jmp alltraps
80107458:	e9 ca f8 ff ff       	jmp    80106d27 <alltraps>

8010745d <vector63>:
.globl vector63
vector63:
  pushl $0
8010745d:	6a 00                	push   $0x0
  pushl $63
8010745f:	6a 3f                	push   $0x3f
  jmp alltraps
80107461:	e9 c1 f8 ff ff       	jmp    80106d27 <alltraps>

80107466 <vector64>:
.globl vector64
vector64:
  pushl $0
80107466:	6a 00                	push   $0x0
  pushl $64
80107468:	6a 40                	push   $0x40
  jmp alltraps
8010746a:	e9 b8 f8 ff ff       	jmp    80106d27 <alltraps>

8010746f <vector65>:
.globl vector65
vector65:
  pushl $0
8010746f:	6a 00                	push   $0x0
  pushl $65
80107471:	6a 41                	push   $0x41
  jmp alltraps
80107473:	e9 af f8 ff ff       	jmp    80106d27 <alltraps>

80107478 <vector66>:
.globl vector66
vector66:
  pushl $0
80107478:	6a 00                	push   $0x0
  pushl $66
8010747a:	6a 42                	push   $0x42
  jmp alltraps
8010747c:	e9 a6 f8 ff ff       	jmp    80106d27 <alltraps>

80107481 <vector67>:
.globl vector67
vector67:
  pushl $0
80107481:	6a 00                	push   $0x0
  pushl $67
80107483:	6a 43                	push   $0x43
  jmp alltraps
80107485:	e9 9d f8 ff ff       	jmp    80106d27 <alltraps>

8010748a <vector68>:
.globl vector68
vector68:
  pushl $0
8010748a:	6a 00                	push   $0x0
  pushl $68
8010748c:	6a 44                	push   $0x44
  jmp alltraps
8010748e:	e9 94 f8 ff ff       	jmp    80106d27 <alltraps>

80107493 <vector69>:
.globl vector69
vector69:
  pushl $0
80107493:	6a 00                	push   $0x0
  pushl $69
80107495:	6a 45                	push   $0x45
  jmp alltraps
80107497:	e9 8b f8 ff ff       	jmp    80106d27 <alltraps>

8010749c <vector70>:
.globl vector70
vector70:
  pushl $0
8010749c:	6a 00                	push   $0x0
  pushl $70
8010749e:	6a 46                	push   $0x46
  jmp alltraps
801074a0:	e9 82 f8 ff ff       	jmp    80106d27 <alltraps>

801074a5 <vector71>:
.globl vector71
vector71:
  pushl $0
801074a5:	6a 00                	push   $0x0
  pushl $71
801074a7:	6a 47                	push   $0x47
  jmp alltraps
801074a9:	e9 79 f8 ff ff       	jmp    80106d27 <alltraps>

801074ae <vector72>:
.globl vector72
vector72:
  pushl $0
801074ae:	6a 00                	push   $0x0
  pushl $72
801074b0:	6a 48                	push   $0x48
  jmp alltraps
801074b2:	e9 70 f8 ff ff       	jmp    80106d27 <alltraps>

801074b7 <vector73>:
.globl vector73
vector73:
  pushl $0
801074b7:	6a 00                	push   $0x0
  pushl $73
801074b9:	6a 49                	push   $0x49
  jmp alltraps
801074bb:	e9 67 f8 ff ff       	jmp    80106d27 <alltraps>

801074c0 <vector74>:
.globl vector74
vector74:
  pushl $0
801074c0:	6a 00                	push   $0x0
  pushl $74
801074c2:	6a 4a                	push   $0x4a
  jmp alltraps
801074c4:	e9 5e f8 ff ff       	jmp    80106d27 <alltraps>

801074c9 <vector75>:
.globl vector75
vector75:
  pushl $0
801074c9:	6a 00                	push   $0x0
  pushl $75
801074cb:	6a 4b                	push   $0x4b
  jmp alltraps
801074cd:	e9 55 f8 ff ff       	jmp    80106d27 <alltraps>

801074d2 <vector76>:
.globl vector76
vector76:
  pushl $0
801074d2:	6a 00                	push   $0x0
  pushl $76
801074d4:	6a 4c                	push   $0x4c
  jmp alltraps
801074d6:	e9 4c f8 ff ff       	jmp    80106d27 <alltraps>

801074db <vector77>:
.globl vector77
vector77:
  pushl $0
801074db:	6a 00                	push   $0x0
  pushl $77
801074dd:	6a 4d                	push   $0x4d
  jmp alltraps
801074df:	e9 43 f8 ff ff       	jmp    80106d27 <alltraps>

801074e4 <vector78>:
.globl vector78
vector78:
  pushl $0
801074e4:	6a 00                	push   $0x0
  pushl $78
801074e6:	6a 4e                	push   $0x4e
  jmp alltraps
801074e8:	e9 3a f8 ff ff       	jmp    80106d27 <alltraps>

801074ed <vector79>:
.globl vector79
vector79:
  pushl $0
801074ed:	6a 00                	push   $0x0
  pushl $79
801074ef:	6a 4f                	push   $0x4f
  jmp alltraps
801074f1:	e9 31 f8 ff ff       	jmp    80106d27 <alltraps>

801074f6 <vector80>:
.globl vector80
vector80:
  pushl $0
801074f6:	6a 00                	push   $0x0
  pushl $80
801074f8:	6a 50                	push   $0x50
  jmp alltraps
801074fa:	e9 28 f8 ff ff       	jmp    80106d27 <alltraps>

801074ff <vector81>:
.globl vector81
vector81:
  pushl $0
801074ff:	6a 00                	push   $0x0
  pushl $81
80107501:	6a 51                	push   $0x51
  jmp alltraps
80107503:	e9 1f f8 ff ff       	jmp    80106d27 <alltraps>

80107508 <vector82>:
.globl vector82
vector82:
  pushl $0
80107508:	6a 00                	push   $0x0
  pushl $82
8010750a:	6a 52                	push   $0x52
  jmp alltraps
8010750c:	e9 16 f8 ff ff       	jmp    80106d27 <alltraps>

80107511 <vector83>:
.globl vector83
vector83:
  pushl $0
80107511:	6a 00                	push   $0x0
  pushl $83
80107513:	6a 53                	push   $0x53
  jmp alltraps
80107515:	e9 0d f8 ff ff       	jmp    80106d27 <alltraps>

8010751a <vector84>:
.globl vector84
vector84:
  pushl $0
8010751a:	6a 00                	push   $0x0
  pushl $84
8010751c:	6a 54                	push   $0x54
  jmp alltraps
8010751e:	e9 04 f8 ff ff       	jmp    80106d27 <alltraps>

80107523 <vector85>:
.globl vector85
vector85:
  pushl $0
80107523:	6a 00                	push   $0x0
  pushl $85
80107525:	6a 55                	push   $0x55
  jmp alltraps
80107527:	e9 fb f7 ff ff       	jmp    80106d27 <alltraps>

8010752c <vector86>:
.globl vector86
vector86:
  pushl $0
8010752c:	6a 00                	push   $0x0
  pushl $86
8010752e:	6a 56                	push   $0x56
  jmp alltraps
80107530:	e9 f2 f7 ff ff       	jmp    80106d27 <alltraps>

80107535 <vector87>:
.globl vector87
vector87:
  pushl $0
80107535:	6a 00                	push   $0x0
  pushl $87
80107537:	6a 57                	push   $0x57
  jmp alltraps
80107539:	e9 e9 f7 ff ff       	jmp    80106d27 <alltraps>

8010753e <vector88>:
.globl vector88
vector88:
  pushl $0
8010753e:	6a 00                	push   $0x0
  pushl $88
80107540:	6a 58                	push   $0x58
  jmp alltraps
80107542:	e9 e0 f7 ff ff       	jmp    80106d27 <alltraps>

80107547 <vector89>:
.globl vector89
vector89:
  pushl $0
80107547:	6a 00                	push   $0x0
  pushl $89
80107549:	6a 59                	push   $0x59
  jmp alltraps
8010754b:	e9 d7 f7 ff ff       	jmp    80106d27 <alltraps>

80107550 <vector90>:
.globl vector90
vector90:
  pushl $0
80107550:	6a 00                	push   $0x0
  pushl $90
80107552:	6a 5a                	push   $0x5a
  jmp alltraps
80107554:	e9 ce f7 ff ff       	jmp    80106d27 <alltraps>

80107559 <vector91>:
.globl vector91
vector91:
  pushl $0
80107559:	6a 00                	push   $0x0
  pushl $91
8010755b:	6a 5b                	push   $0x5b
  jmp alltraps
8010755d:	e9 c5 f7 ff ff       	jmp    80106d27 <alltraps>

80107562 <vector92>:
.globl vector92
vector92:
  pushl $0
80107562:	6a 00                	push   $0x0
  pushl $92
80107564:	6a 5c                	push   $0x5c
  jmp alltraps
80107566:	e9 bc f7 ff ff       	jmp    80106d27 <alltraps>

8010756b <vector93>:
.globl vector93
vector93:
  pushl $0
8010756b:	6a 00                	push   $0x0
  pushl $93
8010756d:	6a 5d                	push   $0x5d
  jmp alltraps
8010756f:	e9 b3 f7 ff ff       	jmp    80106d27 <alltraps>

80107574 <vector94>:
.globl vector94
vector94:
  pushl $0
80107574:	6a 00                	push   $0x0
  pushl $94
80107576:	6a 5e                	push   $0x5e
  jmp alltraps
80107578:	e9 aa f7 ff ff       	jmp    80106d27 <alltraps>

8010757d <vector95>:
.globl vector95
vector95:
  pushl $0
8010757d:	6a 00                	push   $0x0
  pushl $95
8010757f:	6a 5f                	push   $0x5f
  jmp alltraps
80107581:	e9 a1 f7 ff ff       	jmp    80106d27 <alltraps>

80107586 <vector96>:
.globl vector96
vector96:
  pushl $0
80107586:	6a 00                	push   $0x0
  pushl $96
80107588:	6a 60                	push   $0x60
  jmp alltraps
8010758a:	e9 98 f7 ff ff       	jmp    80106d27 <alltraps>

8010758f <vector97>:
.globl vector97
vector97:
  pushl $0
8010758f:	6a 00                	push   $0x0
  pushl $97
80107591:	6a 61                	push   $0x61
  jmp alltraps
80107593:	e9 8f f7 ff ff       	jmp    80106d27 <alltraps>

80107598 <vector98>:
.globl vector98
vector98:
  pushl $0
80107598:	6a 00                	push   $0x0
  pushl $98
8010759a:	6a 62                	push   $0x62
  jmp alltraps
8010759c:	e9 86 f7 ff ff       	jmp    80106d27 <alltraps>

801075a1 <vector99>:
.globl vector99
vector99:
  pushl $0
801075a1:	6a 00                	push   $0x0
  pushl $99
801075a3:	6a 63                	push   $0x63
  jmp alltraps
801075a5:	e9 7d f7 ff ff       	jmp    80106d27 <alltraps>

801075aa <vector100>:
.globl vector100
vector100:
  pushl $0
801075aa:	6a 00                	push   $0x0
  pushl $100
801075ac:	6a 64                	push   $0x64
  jmp alltraps
801075ae:	e9 74 f7 ff ff       	jmp    80106d27 <alltraps>

801075b3 <vector101>:
.globl vector101
vector101:
  pushl $0
801075b3:	6a 00                	push   $0x0
  pushl $101
801075b5:	6a 65                	push   $0x65
  jmp alltraps
801075b7:	e9 6b f7 ff ff       	jmp    80106d27 <alltraps>

801075bc <vector102>:
.globl vector102
vector102:
  pushl $0
801075bc:	6a 00                	push   $0x0
  pushl $102
801075be:	6a 66                	push   $0x66
  jmp alltraps
801075c0:	e9 62 f7 ff ff       	jmp    80106d27 <alltraps>

801075c5 <vector103>:
.globl vector103
vector103:
  pushl $0
801075c5:	6a 00                	push   $0x0
  pushl $103
801075c7:	6a 67                	push   $0x67
  jmp alltraps
801075c9:	e9 59 f7 ff ff       	jmp    80106d27 <alltraps>

801075ce <vector104>:
.globl vector104
vector104:
  pushl $0
801075ce:	6a 00                	push   $0x0
  pushl $104
801075d0:	6a 68                	push   $0x68
  jmp alltraps
801075d2:	e9 50 f7 ff ff       	jmp    80106d27 <alltraps>

801075d7 <vector105>:
.globl vector105
vector105:
  pushl $0
801075d7:	6a 00                	push   $0x0
  pushl $105
801075d9:	6a 69                	push   $0x69
  jmp alltraps
801075db:	e9 47 f7 ff ff       	jmp    80106d27 <alltraps>

801075e0 <vector106>:
.globl vector106
vector106:
  pushl $0
801075e0:	6a 00                	push   $0x0
  pushl $106
801075e2:	6a 6a                	push   $0x6a
  jmp alltraps
801075e4:	e9 3e f7 ff ff       	jmp    80106d27 <alltraps>

801075e9 <vector107>:
.globl vector107
vector107:
  pushl $0
801075e9:	6a 00                	push   $0x0
  pushl $107
801075eb:	6a 6b                	push   $0x6b
  jmp alltraps
801075ed:	e9 35 f7 ff ff       	jmp    80106d27 <alltraps>

801075f2 <vector108>:
.globl vector108
vector108:
  pushl $0
801075f2:	6a 00                	push   $0x0
  pushl $108
801075f4:	6a 6c                	push   $0x6c
  jmp alltraps
801075f6:	e9 2c f7 ff ff       	jmp    80106d27 <alltraps>

801075fb <vector109>:
.globl vector109
vector109:
  pushl $0
801075fb:	6a 00                	push   $0x0
  pushl $109
801075fd:	6a 6d                	push   $0x6d
  jmp alltraps
801075ff:	e9 23 f7 ff ff       	jmp    80106d27 <alltraps>

80107604 <vector110>:
.globl vector110
vector110:
  pushl $0
80107604:	6a 00                	push   $0x0
  pushl $110
80107606:	6a 6e                	push   $0x6e
  jmp alltraps
80107608:	e9 1a f7 ff ff       	jmp    80106d27 <alltraps>

8010760d <vector111>:
.globl vector111
vector111:
  pushl $0
8010760d:	6a 00                	push   $0x0
  pushl $111
8010760f:	6a 6f                	push   $0x6f
  jmp alltraps
80107611:	e9 11 f7 ff ff       	jmp    80106d27 <alltraps>

80107616 <vector112>:
.globl vector112
vector112:
  pushl $0
80107616:	6a 00                	push   $0x0
  pushl $112
80107618:	6a 70                	push   $0x70
  jmp alltraps
8010761a:	e9 08 f7 ff ff       	jmp    80106d27 <alltraps>

8010761f <vector113>:
.globl vector113
vector113:
  pushl $0
8010761f:	6a 00                	push   $0x0
  pushl $113
80107621:	6a 71                	push   $0x71
  jmp alltraps
80107623:	e9 ff f6 ff ff       	jmp    80106d27 <alltraps>

80107628 <vector114>:
.globl vector114
vector114:
  pushl $0
80107628:	6a 00                	push   $0x0
  pushl $114
8010762a:	6a 72                	push   $0x72
  jmp alltraps
8010762c:	e9 f6 f6 ff ff       	jmp    80106d27 <alltraps>

80107631 <vector115>:
.globl vector115
vector115:
  pushl $0
80107631:	6a 00                	push   $0x0
  pushl $115
80107633:	6a 73                	push   $0x73
  jmp alltraps
80107635:	e9 ed f6 ff ff       	jmp    80106d27 <alltraps>

8010763a <vector116>:
.globl vector116
vector116:
  pushl $0
8010763a:	6a 00                	push   $0x0
  pushl $116
8010763c:	6a 74                	push   $0x74
  jmp alltraps
8010763e:	e9 e4 f6 ff ff       	jmp    80106d27 <alltraps>

80107643 <vector117>:
.globl vector117
vector117:
  pushl $0
80107643:	6a 00                	push   $0x0
  pushl $117
80107645:	6a 75                	push   $0x75
  jmp alltraps
80107647:	e9 db f6 ff ff       	jmp    80106d27 <alltraps>

8010764c <vector118>:
.globl vector118
vector118:
  pushl $0
8010764c:	6a 00                	push   $0x0
  pushl $118
8010764e:	6a 76                	push   $0x76
  jmp alltraps
80107650:	e9 d2 f6 ff ff       	jmp    80106d27 <alltraps>

80107655 <vector119>:
.globl vector119
vector119:
  pushl $0
80107655:	6a 00                	push   $0x0
  pushl $119
80107657:	6a 77                	push   $0x77
  jmp alltraps
80107659:	e9 c9 f6 ff ff       	jmp    80106d27 <alltraps>

8010765e <vector120>:
.globl vector120
vector120:
  pushl $0
8010765e:	6a 00                	push   $0x0
  pushl $120
80107660:	6a 78                	push   $0x78
  jmp alltraps
80107662:	e9 c0 f6 ff ff       	jmp    80106d27 <alltraps>

80107667 <vector121>:
.globl vector121
vector121:
  pushl $0
80107667:	6a 00                	push   $0x0
  pushl $121
80107669:	6a 79                	push   $0x79
  jmp alltraps
8010766b:	e9 b7 f6 ff ff       	jmp    80106d27 <alltraps>

80107670 <vector122>:
.globl vector122
vector122:
  pushl $0
80107670:	6a 00                	push   $0x0
  pushl $122
80107672:	6a 7a                	push   $0x7a
  jmp alltraps
80107674:	e9 ae f6 ff ff       	jmp    80106d27 <alltraps>

80107679 <vector123>:
.globl vector123
vector123:
  pushl $0
80107679:	6a 00                	push   $0x0
  pushl $123
8010767b:	6a 7b                	push   $0x7b
  jmp alltraps
8010767d:	e9 a5 f6 ff ff       	jmp    80106d27 <alltraps>

80107682 <vector124>:
.globl vector124
vector124:
  pushl $0
80107682:	6a 00                	push   $0x0
  pushl $124
80107684:	6a 7c                	push   $0x7c
  jmp alltraps
80107686:	e9 9c f6 ff ff       	jmp    80106d27 <alltraps>

8010768b <vector125>:
.globl vector125
vector125:
  pushl $0
8010768b:	6a 00                	push   $0x0
  pushl $125
8010768d:	6a 7d                	push   $0x7d
  jmp alltraps
8010768f:	e9 93 f6 ff ff       	jmp    80106d27 <alltraps>

80107694 <vector126>:
.globl vector126
vector126:
  pushl $0
80107694:	6a 00                	push   $0x0
  pushl $126
80107696:	6a 7e                	push   $0x7e
  jmp alltraps
80107698:	e9 8a f6 ff ff       	jmp    80106d27 <alltraps>

8010769d <vector127>:
.globl vector127
vector127:
  pushl $0
8010769d:	6a 00                	push   $0x0
  pushl $127
8010769f:	6a 7f                	push   $0x7f
  jmp alltraps
801076a1:	e9 81 f6 ff ff       	jmp    80106d27 <alltraps>

801076a6 <vector128>:
.globl vector128
vector128:
  pushl $0
801076a6:	6a 00                	push   $0x0
  pushl $128
801076a8:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801076ad:	e9 75 f6 ff ff       	jmp    80106d27 <alltraps>

801076b2 <vector129>:
.globl vector129
vector129:
  pushl $0
801076b2:	6a 00                	push   $0x0
  pushl $129
801076b4:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801076b9:	e9 69 f6 ff ff       	jmp    80106d27 <alltraps>

801076be <vector130>:
.globl vector130
vector130:
  pushl $0
801076be:	6a 00                	push   $0x0
  pushl $130
801076c0:	68 82 00 00 00       	push   $0x82
  jmp alltraps
801076c5:	e9 5d f6 ff ff       	jmp    80106d27 <alltraps>

801076ca <vector131>:
.globl vector131
vector131:
  pushl $0
801076ca:	6a 00                	push   $0x0
  pushl $131
801076cc:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801076d1:	e9 51 f6 ff ff       	jmp    80106d27 <alltraps>

801076d6 <vector132>:
.globl vector132
vector132:
  pushl $0
801076d6:	6a 00                	push   $0x0
  pushl $132
801076d8:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801076dd:	e9 45 f6 ff ff       	jmp    80106d27 <alltraps>

801076e2 <vector133>:
.globl vector133
vector133:
  pushl $0
801076e2:	6a 00                	push   $0x0
  pushl $133
801076e4:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801076e9:	e9 39 f6 ff ff       	jmp    80106d27 <alltraps>

801076ee <vector134>:
.globl vector134
vector134:
  pushl $0
801076ee:	6a 00                	push   $0x0
  pushl $134
801076f0:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801076f5:	e9 2d f6 ff ff       	jmp    80106d27 <alltraps>

801076fa <vector135>:
.globl vector135
vector135:
  pushl $0
801076fa:	6a 00                	push   $0x0
  pushl $135
801076fc:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107701:	e9 21 f6 ff ff       	jmp    80106d27 <alltraps>

80107706 <vector136>:
.globl vector136
vector136:
  pushl $0
80107706:	6a 00                	push   $0x0
  pushl $136
80107708:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010770d:	e9 15 f6 ff ff       	jmp    80106d27 <alltraps>

80107712 <vector137>:
.globl vector137
vector137:
  pushl $0
80107712:	6a 00                	push   $0x0
  pushl $137
80107714:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80107719:	e9 09 f6 ff ff       	jmp    80106d27 <alltraps>

8010771e <vector138>:
.globl vector138
vector138:
  pushl $0
8010771e:	6a 00                	push   $0x0
  pushl $138
80107720:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107725:	e9 fd f5 ff ff       	jmp    80106d27 <alltraps>

8010772a <vector139>:
.globl vector139
vector139:
  pushl $0
8010772a:	6a 00                	push   $0x0
  pushl $139
8010772c:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107731:	e9 f1 f5 ff ff       	jmp    80106d27 <alltraps>

80107736 <vector140>:
.globl vector140
vector140:
  pushl $0
80107736:	6a 00                	push   $0x0
  pushl $140
80107738:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010773d:	e9 e5 f5 ff ff       	jmp    80106d27 <alltraps>

80107742 <vector141>:
.globl vector141
vector141:
  pushl $0
80107742:	6a 00                	push   $0x0
  pushl $141
80107744:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107749:	e9 d9 f5 ff ff       	jmp    80106d27 <alltraps>

8010774e <vector142>:
.globl vector142
vector142:
  pushl $0
8010774e:	6a 00                	push   $0x0
  pushl $142
80107750:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107755:	e9 cd f5 ff ff       	jmp    80106d27 <alltraps>

8010775a <vector143>:
.globl vector143
vector143:
  pushl $0
8010775a:	6a 00                	push   $0x0
  pushl $143
8010775c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107761:	e9 c1 f5 ff ff       	jmp    80106d27 <alltraps>

80107766 <vector144>:
.globl vector144
vector144:
  pushl $0
80107766:	6a 00                	push   $0x0
  pushl $144
80107768:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010776d:	e9 b5 f5 ff ff       	jmp    80106d27 <alltraps>

80107772 <vector145>:
.globl vector145
vector145:
  pushl $0
80107772:	6a 00                	push   $0x0
  pushl $145
80107774:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107779:	e9 a9 f5 ff ff       	jmp    80106d27 <alltraps>

8010777e <vector146>:
.globl vector146
vector146:
  pushl $0
8010777e:	6a 00                	push   $0x0
  pushl $146
80107780:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107785:	e9 9d f5 ff ff       	jmp    80106d27 <alltraps>

8010778a <vector147>:
.globl vector147
vector147:
  pushl $0
8010778a:	6a 00                	push   $0x0
  pushl $147
8010778c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107791:	e9 91 f5 ff ff       	jmp    80106d27 <alltraps>

80107796 <vector148>:
.globl vector148
vector148:
  pushl $0
80107796:	6a 00                	push   $0x0
  pushl $148
80107798:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010779d:	e9 85 f5 ff ff       	jmp    80106d27 <alltraps>

801077a2 <vector149>:
.globl vector149
vector149:
  pushl $0
801077a2:	6a 00                	push   $0x0
  pushl $149
801077a4:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801077a9:	e9 79 f5 ff ff       	jmp    80106d27 <alltraps>

801077ae <vector150>:
.globl vector150
vector150:
  pushl $0
801077ae:	6a 00                	push   $0x0
  pushl $150
801077b0:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801077b5:	e9 6d f5 ff ff       	jmp    80106d27 <alltraps>

801077ba <vector151>:
.globl vector151
vector151:
  pushl $0
801077ba:	6a 00                	push   $0x0
  pushl $151
801077bc:	68 97 00 00 00       	push   $0x97
  jmp alltraps
801077c1:	e9 61 f5 ff ff       	jmp    80106d27 <alltraps>

801077c6 <vector152>:
.globl vector152
vector152:
  pushl $0
801077c6:	6a 00                	push   $0x0
  pushl $152
801077c8:	68 98 00 00 00       	push   $0x98
  jmp alltraps
801077cd:	e9 55 f5 ff ff       	jmp    80106d27 <alltraps>

801077d2 <vector153>:
.globl vector153
vector153:
  pushl $0
801077d2:	6a 00                	push   $0x0
  pushl $153
801077d4:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801077d9:	e9 49 f5 ff ff       	jmp    80106d27 <alltraps>

801077de <vector154>:
.globl vector154
vector154:
  pushl $0
801077de:	6a 00                	push   $0x0
  pushl $154
801077e0:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801077e5:	e9 3d f5 ff ff       	jmp    80106d27 <alltraps>

801077ea <vector155>:
.globl vector155
vector155:
  pushl $0
801077ea:	6a 00                	push   $0x0
  pushl $155
801077ec:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801077f1:	e9 31 f5 ff ff       	jmp    80106d27 <alltraps>

801077f6 <vector156>:
.globl vector156
vector156:
  pushl $0
801077f6:	6a 00                	push   $0x0
  pushl $156
801077f8:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801077fd:	e9 25 f5 ff ff       	jmp    80106d27 <alltraps>

80107802 <vector157>:
.globl vector157
vector157:
  pushl $0
80107802:	6a 00                	push   $0x0
  pushl $157
80107804:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80107809:	e9 19 f5 ff ff       	jmp    80106d27 <alltraps>

8010780e <vector158>:
.globl vector158
vector158:
  pushl $0
8010780e:	6a 00                	push   $0x0
  pushl $158
80107810:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107815:	e9 0d f5 ff ff       	jmp    80106d27 <alltraps>

8010781a <vector159>:
.globl vector159
vector159:
  pushl $0
8010781a:	6a 00                	push   $0x0
  pushl $159
8010781c:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107821:	e9 01 f5 ff ff       	jmp    80106d27 <alltraps>

80107826 <vector160>:
.globl vector160
vector160:
  pushl $0
80107826:	6a 00                	push   $0x0
  pushl $160
80107828:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010782d:	e9 f5 f4 ff ff       	jmp    80106d27 <alltraps>

80107832 <vector161>:
.globl vector161
vector161:
  pushl $0
80107832:	6a 00                	push   $0x0
  pushl $161
80107834:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107839:	e9 e9 f4 ff ff       	jmp    80106d27 <alltraps>

8010783e <vector162>:
.globl vector162
vector162:
  pushl $0
8010783e:	6a 00                	push   $0x0
  pushl $162
80107840:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107845:	e9 dd f4 ff ff       	jmp    80106d27 <alltraps>

8010784a <vector163>:
.globl vector163
vector163:
  pushl $0
8010784a:	6a 00                	push   $0x0
  pushl $163
8010784c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107851:	e9 d1 f4 ff ff       	jmp    80106d27 <alltraps>

80107856 <vector164>:
.globl vector164
vector164:
  pushl $0
80107856:	6a 00                	push   $0x0
  pushl $164
80107858:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010785d:	e9 c5 f4 ff ff       	jmp    80106d27 <alltraps>

80107862 <vector165>:
.globl vector165
vector165:
  pushl $0
80107862:	6a 00                	push   $0x0
  pushl $165
80107864:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107869:	e9 b9 f4 ff ff       	jmp    80106d27 <alltraps>

8010786e <vector166>:
.globl vector166
vector166:
  pushl $0
8010786e:	6a 00                	push   $0x0
  pushl $166
80107870:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107875:	e9 ad f4 ff ff       	jmp    80106d27 <alltraps>

8010787a <vector167>:
.globl vector167
vector167:
  pushl $0
8010787a:	6a 00                	push   $0x0
  pushl $167
8010787c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107881:	e9 a1 f4 ff ff       	jmp    80106d27 <alltraps>

80107886 <vector168>:
.globl vector168
vector168:
  pushl $0
80107886:	6a 00                	push   $0x0
  pushl $168
80107888:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010788d:	e9 95 f4 ff ff       	jmp    80106d27 <alltraps>

80107892 <vector169>:
.globl vector169
vector169:
  pushl $0
80107892:	6a 00                	push   $0x0
  pushl $169
80107894:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107899:	e9 89 f4 ff ff       	jmp    80106d27 <alltraps>

8010789e <vector170>:
.globl vector170
vector170:
  pushl $0
8010789e:	6a 00                	push   $0x0
  pushl $170
801078a0:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
801078a5:	e9 7d f4 ff ff       	jmp    80106d27 <alltraps>

801078aa <vector171>:
.globl vector171
vector171:
  pushl $0
801078aa:	6a 00                	push   $0x0
  pushl $171
801078ac:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
801078b1:	e9 71 f4 ff ff       	jmp    80106d27 <alltraps>

801078b6 <vector172>:
.globl vector172
vector172:
  pushl $0
801078b6:	6a 00                	push   $0x0
  pushl $172
801078b8:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
801078bd:	e9 65 f4 ff ff       	jmp    80106d27 <alltraps>

801078c2 <vector173>:
.globl vector173
vector173:
  pushl $0
801078c2:	6a 00                	push   $0x0
  pushl $173
801078c4:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
801078c9:	e9 59 f4 ff ff       	jmp    80106d27 <alltraps>

801078ce <vector174>:
.globl vector174
vector174:
  pushl $0
801078ce:	6a 00                	push   $0x0
  pushl $174
801078d0:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801078d5:	e9 4d f4 ff ff       	jmp    80106d27 <alltraps>

801078da <vector175>:
.globl vector175
vector175:
  pushl $0
801078da:	6a 00                	push   $0x0
  pushl $175
801078dc:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801078e1:	e9 41 f4 ff ff       	jmp    80106d27 <alltraps>

801078e6 <vector176>:
.globl vector176
vector176:
  pushl $0
801078e6:	6a 00                	push   $0x0
  pushl $176
801078e8:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801078ed:	e9 35 f4 ff ff       	jmp    80106d27 <alltraps>

801078f2 <vector177>:
.globl vector177
vector177:
  pushl $0
801078f2:	6a 00                	push   $0x0
  pushl $177
801078f4:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801078f9:	e9 29 f4 ff ff       	jmp    80106d27 <alltraps>

801078fe <vector178>:
.globl vector178
vector178:
  pushl $0
801078fe:	6a 00                	push   $0x0
  pushl $178
80107900:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107905:	e9 1d f4 ff ff       	jmp    80106d27 <alltraps>

8010790a <vector179>:
.globl vector179
vector179:
  pushl $0
8010790a:	6a 00                	push   $0x0
  pushl $179
8010790c:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107911:	e9 11 f4 ff ff       	jmp    80106d27 <alltraps>

80107916 <vector180>:
.globl vector180
vector180:
  pushl $0
80107916:	6a 00                	push   $0x0
  pushl $180
80107918:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010791d:	e9 05 f4 ff ff       	jmp    80106d27 <alltraps>

80107922 <vector181>:
.globl vector181
vector181:
  pushl $0
80107922:	6a 00                	push   $0x0
  pushl $181
80107924:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80107929:	e9 f9 f3 ff ff       	jmp    80106d27 <alltraps>

8010792e <vector182>:
.globl vector182
vector182:
  pushl $0
8010792e:	6a 00                	push   $0x0
  pushl $182
80107930:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107935:	e9 ed f3 ff ff       	jmp    80106d27 <alltraps>

8010793a <vector183>:
.globl vector183
vector183:
  pushl $0
8010793a:	6a 00                	push   $0x0
  pushl $183
8010793c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107941:	e9 e1 f3 ff ff       	jmp    80106d27 <alltraps>

80107946 <vector184>:
.globl vector184
vector184:
  pushl $0
80107946:	6a 00                	push   $0x0
  pushl $184
80107948:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010794d:	e9 d5 f3 ff ff       	jmp    80106d27 <alltraps>

80107952 <vector185>:
.globl vector185
vector185:
  pushl $0
80107952:	6a 00                	push   $0x0
  pushl $185
80107954:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107959:	e9 c9 f3 ff ff       	jmp    80106d27 <alltraps>

8010795e <vector186>:
.globl vector186
vector186:
  pushl $0
8010795e:	6a 00                	push   $0x0
  pushl $186
80107960:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107965:	e9 bd f3 ff ff       	jmp    80106d27 <alltraps>

8010796a <vector187>:
.globl vector187
vector187:
  pushl $0
8010796a:	6a 00                	push   $0x0
  pushl $187
8010796c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107971:	e9 b1 f3 ff ff       	jmp    80106d27 <alltraps>

80107976 <vector188>:
.globl vector188
vector188:
  pushl $0
80107976:	6a 00                	push   $0x0
  pushl $188
80107978:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010797d:	e9 a5 f3 ff ff       	jmp    80106d27 <alltraps>

80107982 <vector189>:
.globl vector189
vector189:
  pushl $0
80107982:	6a 00                	push   $0x0
  pushl $189
80107984:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107989:	e9 99 f3 ff ff       	jmp    80106d27 <alltraps>

8010798e <vector190>:
.globl vector190
vector190:
  pushl $0
8010798e:	6a 00                	push   $0x0
  pushl $190
80107990:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107995:	e9 8d f3 ff ff       	jmp    80106d27 <alltraps>

8010799a <vector191>:
.globl vector191
vector191:
  pushl $0
8010799a:	6a 00                	push   $0x0
  pushl $191
8010799c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
801079a1:	e9 81 f3 ff ff       	jmp    80106d27 <alltraps>

801079a6 <vector192>:
.globl vector192
vector192:
  pushl $0
801079a6:	6a 00                	push   $0x0
  pushl $192
801079a8:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
801079ad:	e9 75 f3 ff ff       	jmp    80106d27 <alltraps>

801079b2 <vector193>:
.globl vector193
vector193:
  pushl $0
801079b2:	6a 00                	push   $0x0
  pushl $193
801079b4:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
801079b9:	e9 69 f3 ff ff       	jmp    80106d27 <alltraps>

801079be <vector194>:
.globl vector194
vector194:
  pushl $0
801079be:	6a 00                	push   $0x0
  pushl $194
801079c0:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
801079c5:	e9 5d f3 ff ff       	jmp    80106d27 <alltraps>

801079ca <vector195>:
.globl vector195
vector195:
  pushl $0
801079ca:	6a 00                	push   $0x0
  pushl $195
801079cc:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801079d1:	e9 51 f3 ff ff       	jmp    80106d27 <alltraps>

801079d6 <vector196>:
.globl vector196
vector196:
  pushl $0
801079d6:	6a 00                	push   $0x0
  pushl $196
801079d8:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801079dd:	e9 45 f3 ff ff       	jmp    80106d27 <alltraps>

801079e2 <vector197>:
.globl vector197
vector197:
  pushl $0
801079e2:	6a 00                	push   $0x0
  pushl $197
801079e4:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801079e9:	e9 39 f3 ff ff       	jmp    80106d27 <alltraps>

801079ee <vector198>:
.globl vector198
vector198:
  pushl $0
801079ee:	6a 00                	push   $0x0
  pushl $198
801079f0:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801079f5:	e9 2d f3 ff ff       	jmp    80106d27 <alltraps>

801079fa <vector199>:
.globl vector199
vector199:
  pushl $0
801079fa:	6a 00                	push   $0x0
  pushl $199
801079fc:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107a01:	e9 21 f3 ff ff       	jmp    80106d27 <alltraps>

80107a06 <vector200>:
.globl vector200
vector200:
  pushl $0
80107a06:	6a 00                	push   $0x0
  pushl $200
80107a08:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107a0d:	e9 15 f3 ff ff       	jmp    80106d27 <alltraps>

80107a12 <vector201>:
.globl vector201
vector201:
  pushl $0
80107a12:	6a 00                	push   $0x0
  pushl $201
80107a14:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107a19:	e9 09 f3 ff ff       	jmp    80106d27 <alltraps>

80107a1e <vector202>:
.globl vector202
vector202:
  pushl $0
80107a1e:	6a 00                	push   $0x0
  pushl $202
80107a20:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107a25:	e9 fd f2 ff ff       	jmp    80106d27 <alltraps>

80107a2a <vector203>:
.globl vector203
vector203:
  pushl $0
80107a2a:	6a 00                	push   $0x0
  pushl $203
80107a2c:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107a31:	e9 f1 f2 ff ff       	jmp    80106d27 <alltraps>

80107a36 <vector204>:
.globl vector204
vector204:
  pushl $0
80107a36:	6a 00                	push   $0x0
  pushl $204
80107a38:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107a3d:	e9 e5 f2 ff ff       	jmp    80106d27 <alltraps>

80107a42 <vector205>:
.globl vector205
vector205:
  pushl $0
80107a42:	6a 00                	push   $0x0
  pushl $205
80107a44:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107a49:	e9 d9 f2 ff ff       	jmp    80106d27 <alltraps>

80107a4e <vector206>:
.globl vector206
vector206:
  pushl $0
80107a4e:	6a 00                	push   $0x0
  pushl $206
80107a50:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107a55:	e9 cd f2 ff ff       	jmp    80106d27 <alltraps>

80107a5a <vector207>:
.globl vector207
vector207:
  pushl $0
80107a5a:	6a 00                	push   $0x0
  pushl $207
80107a5c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107a61:	e9 c1 f2 ff ff       	jmp    80106d27 <alltraps>

80107a66 <vector208>:
.globl vector208
vector208:
  pushl $0
80107a66:	6a 00                	push   $0x0
  pushl $208
80107a68:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107a6d:	e9 b5 f2 ff ff       	jmp    80106d27 <alltraps>

80107a72 <vector209>:
.globl vector209
vector209:
  pushl $0
80107a72:	6a 00                	push   $0x0
  pushl $209
80107a74:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107a79:	e9 a9 f2 ff ff       	jmp    80106d27 <alltraps>

80107a7e <vector210>:
.globl vector210
vector210:
  pushl $0
80107a7e:	6a 00                	push   $0x0
  pushl $210
80107a80:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107a85:	e9 9d f2 ff ff       	jmp    80106d27 <alltraps>

80107a8a <vector211>:
.globl vector211
vector211:
  pushl $0
80107a8a:	6a 00                	push   $0x0
  pushl $211
80107a8c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107a91:	e9 91 f2 ff ff       	jmp    80106d27 <alltraps>

80107a96 <vector212>:
.globl vector212
vector212:
  pushl $0
80107a96:	6a 00                	push   $0x0
  pushl $212
80107a98:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107a9d:	e9 85 f2 ff ff       	jmp    80106d27 <alltraps>

80107aa2 <vector213>:
.globl vector213
vector213:
  pushl $0
80107aa2:	6a 00                	push   $0x0
  pushl $213
80107aa4:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107aa9:	e9 79 f2 ff ff       	jmp    80106d27 <alltraps>

80107aae <vector214>:
.globl vector214
vector214:
  pushl $0
80107aae:	6a 00                	push   $0x0
  pushl $214
80107ab0:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107ab5:	e9 6d f2 ff ff       	jmp    80106d27 <alltraps>

80107aba <vector215>:
.globl vector215
vector215:
  pushl $0
80107aba:	6a 00                	push   $0x0
  pushl $215
80107abc:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107ac1:	e9 61 f2 ff ff       	jmp    80106d27 <alltraps>

80107ac6 <vector216>:
.globl vector216
vector216:
  pushl $0
80107ac6:	6a 00                	push   $0x0
  pushl $216
80107ac8:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107acd:	e9 55 f2 ff ff       	jmp    80106d27 <alltraps>

80107ad2 <vector217>:
.globl vector217
vector217:
  pushl $0
80107ad2:	6a 00                	push   $0x0
  pushl $217
80107ad4:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107ad9:	e9 49 f2 ff ff       	jmp    80106d27 <alltraps>

80107ade <vector218>:
.globl vector218
vector218:
  pushl $0
80107ade:	6a 00                	push   $0x0
  pushl $218
80107ae0:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107ae5:	e9 3d f2 ff ff       	jmp    80106d27 <alltraps>

80107aea <vector219>:
.globl vector219
vector219:
  pushl $0
80107aea:	6a 00                	push   $0x0
  pushl $219
80107aec:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107af1:	e9 31 f2 ff ff       	jmp    80106d27 <alltraps>

80107af6 <vector220>:
.globl vector220
vector220:
  pushl $0
80107af6:	6a 00                	push   $0x0
  pushl $220
80107af8:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107afd:	e9 25 f2 ff ff       	jmp    80106d27 <alltraps>

80107b02 <vector221>:
.globl vector221
vector221:
  pushl $0
80107b02:	6a 00                	push   $0x0
  pushl $221
80107b04:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107b09:	e9 19 f2 ff ff       	jmp    80106d27 <alltraps>

80107b0e <vector222>:
.globl vector222
vector222:
  pushl $0
80107b0e:	6a 00                	push   $0x0
  pushl $222
80107b10:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107b15:	e9 0d f2 ff ff       	jmp    80106d27 <alltraps>

80107b1a <vector223>:
.globl vector223
vector223:
  pushl $0
80107b1a:	6a 00                	push   $0x0
  pushl $223
80107b1c:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107b21:	e9 01 f2 ff ff       	jmp    80106d27 <alltraps>

80107b26 <vector224>:
.globl vector224
vector224:
  pushl $0
80107b26:	6a 00                	push   $0x0
  pushl $224
80107b28:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107b2d:	e9 f5 f1 ff ff       	jmp    80106d27 <alltraps>

80107b32 <vector225>:
.globl vector225
vector225:
  pushl $0
80107b32:	6a 00                	push   $0x0
  pushl $225
80107b34:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107b39:	e9 e9 f1 ff ff       	jmp    80106d27 <alltraps>

80107b3e <vector226>:
.globl vector226
vector226:
  pushl $0
80107b3e:	6a 00                	push   $0x0
  pushl $226
80107b40:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107b45:	e9 dd f1 ff ff       	jmp    80106d27 <alltraps>

80107b4a <vector227>:
.globl vector227
vector227:
  pushl $0
80107b4a:	6a 00                	push   $0x0
  pushl $227
80107b4c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107b51:	e9 d1 f1 ff ff       	jmp    80106d27 <alltraps>

80107b56 <vector228>:
.globl vector228
vector228:
  pushl $0
80107b56:	6a 00                	push   $0x0
  pushl $228
80107b58:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107b5d:	e9 c5 f1 ff ff       	jmp    80106d27 <alltraps>

80107b62 <vector229>:
.globl vector229
vector229:
  pushl $0
80107b62:	6a 00                	push   $0x0
  pushl $229
80107b64:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107b69:	e9 b9 f1 ff ff       	jmp    80106d27 <alltraps>

80107b6e <vector230>:
.globl vector230
vector230:
  pushl $0
80107b6e:	6a 00                	push   $0x0
  pushl $230
80107b70:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107b75:	e9 ad f1 ff ff       	jmp    80106d27 <alltraps>

80107b7a <vector231>:
.globl vector231
vector231:
  pushl $0
80107b7a:	6a 00                	push   $0x0
  pushl $231
80107b7c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107b81:	e9 a1 f1 ff ff       	jmp    80106d27 <alltraps>

80107b86 <vector232>:
.globl vector232
vector232:
  pushl $0
80107b86:	6a 00                	push   $0x0
  pushl $232
80107b88:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107b8d:	e9 95 f1 ff ff       	jmp    80106d27 <alltraps>

80107b92 <vector233>:
.globl vector233
vector233:
  pushl $0
80107b92:	6a 00                	push   $0x0
  pushl $233
80107b94:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107b99:	e9 89 f1 ff ff       	jmp    80106d27 <alltraps>

80107b9e <vector234>:
.globl vector234
vector234:
  pushl $0
80107b9e:	6a 00                	push   $0x0
  pushl $234
80107ba0:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107ba5:	e9 7d f1 ff ff       	jmp    80106d27 <alltraps>

80107baa <vector235>:
.globl vector235
vector235:
  pushl $0
80107baa:	6a 00                	push   $0x0
  pushl $235
80107bac:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107bb1:	e9 71 f1 ff ff       	jmp    80106d27 <alltraps>

80107bb6 <vector236>:
.globl vector236
vector236:
  pushl $0
80107bb6:	6a 00                	push   $0x0
  pushl $236
80107bb8:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107bbd:	e9 65 f1 ff ff       	jmp    80106d27 <alltraps>

80107bc2 <vector237>:
.globl vector237
vector237:
  pushl $0
80107bc2:	6a 00                	push   $0x0
  pushl $237
80107bc4:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107bc9:	e9 59 f1 ff ff       	jmp    80106d27 <alltraps>

80107bce <vector238>:
.globl vector238
vector238:
  pushl $0
80107bce:	6a 00                	push   $0x0
  pushl $238
80107bd0:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107bd5:	e9 4d f1 ff ff       	jmp    80106d27 <alltraps>

80107bda <vector239>:
.globl vector239
vector239:
  pushl $0
80107bda:	6a 00                	push   $0x0
  pushl $239
80107bdc:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107be1:	e9 41 f1 ff ff       	jmp    80106d27 <alltraps>

80107be6 <vector240>:
.globl vector240
vector240:
  pushl $0
80107be6:	6a 00                	push   $0x0
  pushl $240
80107be8:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107bed:	e9 35 f1 ff ff       	jmp    80106d27 <alltraps>

80107bf2 <vector241>:
.globl vector241
vector241:
  pushl $0
80107bf2:	6a 00                	push   $0x0
  pushl $241
80107bf4:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107bf9:	e9 29 f1 ff ff       	jmp    80106d27 <alltraps>

80107bfe <vector242>:
.globl vector242
vector242:
  pushl $0
80107bfe:	6a 00                	push   $0x0
  pushl $242
80107c00:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107c05:	e9 1d f1 ff ff       	jmp    80106d27 <alltraps>

80107c0a <vector243>:
.globl vector243
vector243:
  pushl $0
80107c0a:	6a 00                	push   $0x0
  pushl $243
80107c0c:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107c11:	e9 11 f1 ff ff       	jmp    80106d27 <alltraps>

80107c16 <vector244>:
.globl vector244
vector244:
  pushl $0
80107c16:	6a 00                	push   $0x0
  pushl $244
80107c18:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107c1d:	e9 05 f1 ff ff       	jmp    80106d27 <alltraps>

80107c22 <vector245>:
.globl vector245
vector245:
  pushl $0
80107c22:	6a 00                	push   $0x0
  pushl $245
80107c24:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107c29:	e9 f9 f0 ff ff       	jmp    80106d27 <alltraps>

80107c2e <vector246>:
.globl vector246
vector246:
  pushl $0
80107c2e:	6a 00                	push   $0x0
  pushl $246
80107c30:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107c35:	e9 ed f0 ff ff       	jmp    80106d27 <alltraps>

80107c3a <vector247>:
.globl vector247
vector247:
  pushl $0
80107c3a:	6a 00                	push   $0x0
  pushl $247
80107c3c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107c41:	e9 e1 f0 ff ff       	jmp    80106d27 <alltraps>

80107c46 <vector248>:
.globl vector248
vector248:
  pushl $0
80107c46:	6a 00                	push   $0x0
  pushl $248
80107c48:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107c4d:	e9 d5 f0 ff ff       	jmp    80106d27 <alltraps>

80107c52 <vector249>:
.globl vector249
vector249:
  pushl $0
80107c52:	6a 00                	push   $0x0
  pushl $249
80107c54:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107c59:	e9 c9 f0 ff ff       	jmp    80106d27 <alltraps>

80107c5e <vector250>:
.globl vector250
vector250:
  pushl $0
80107c5e:	6a 00                	push   $0x0
  pushl $250
80107c60:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107c65:	e9 bd f0 ff ff       	jmp    80106d27 <alltraps>

80107c6a <vector251>:
.globl vector251
vector251:
  pushl $0
80107c6a:	6a 00                	push   $0x0
  pushl $251
80107c6c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107c71:	e9 b1 f0 ff ff       	jmp    80106d27 <alltraps>

80107c76 <vector252>:
.globl vector252
vector252:
  pushl $0
80107c76:	6a 00                	push   $0x0
  pushl $252
80107c78:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107c7d:	e9 a5 f0 ff ff       	jmp    80106d27 <alltraps>

80107c82 <vector253>:
.globl vector253
vector253:
  pushl $0
80107c82:	6a 00                	push   $0x0
  pushl $253
80107c84:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107c89:	e9 99 f0 ff ff       	jmp    80106d27 <alltraps>

80107c8e <vector254>:
.globl vector254
vector254:
  pushl $0
80107c8e:	6a 00                	push   $0x0
  pushl $254
80107c90:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107c95:	e9 8d f0 ff ff       	jmp    80106d27 <alltraps>

80107c9a <vector255>:
.globl vector255
vector255:
  pushl $0
80107c9a:	6a 00                	push   $0x0
  pushl $255
80107c9c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107ca1:	e9 81 f0 ff ff       	jmp    80106d27 <alltraps>
80107ca6:	66 90                	xchg   %ax,%ax
80107ca8:	66 90                	xchg   %ax,%ax
80107caa:	66 90                	xchg   %ax,%ax
80107cac:	66 90                	xchg   %ax,%ax
80107cae:	66 90                	xchg   %ax,%ax

80107cb0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107cb0:	55                   	push   %ebp
80107cb1:	89 e5                	mov    %esp,%ebp
80107cb3:	83 ec 28             	sub    $0x28,%esp
80107cb6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80107cb9:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107cbb:	c1 ea 16             	shr    $0x16,%edx
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107cbe:	89 7d fc             	mov    %edi,-0x4(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107cc1:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107cc4:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80107cc7:	8b 07                	mov    (%edi),%eax
80107cc9:	a8 01                	test   $0x1,%al
80107ccb:	74 2b                	je     80107cf8 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107ccd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107cd2:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107cd8:	c1 eb 0a             	shr    $0xa,%ebx
}
80107cdb:	8b 7d fc             	mov    -0x4(%ebp),%edi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107cde:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
80107ce4:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80107ce7:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80107cea:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107ced:	89 ec                	mov    %ebp,%esp
80107cef:	5d                   	pop    %ebp
80107cf0:	c3                   	ret    
80107cf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107cf8:	85 c9                	test   %ecx,%ecx
80107cfa:	74 34                	je     80107d30 <walkpgdir+0x80>
80107cfc:	e8 5f a8 ff ff       	call   80102560 <kalloc>
80107d01:	85 c0                	test   %eax,%eax
80107d03:	89 c6                	mov    %eax,%esi
80107d05:	74 29                	je     80107d30 <walkpgdir+0x80>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107d07:	b8 00 10 00 00       	mov    $0x1000,%eax
80107d0c:	31 d2                	xor    %edx,%edx
80107d0e:	89 44 24 08          	mov    %eax,0x8(%esp)
80107d12:	89 54 24 04          	mov    %edx,0x4(%esp)
80107d16:	89 34 24             	mov    %esi,(%esp)
80107d19:	e8 62 dd ff ff       	call   80105a80 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107d1e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107d24:	83 c8 07             	or     $0x7,%eax
80107d27:	89 07                	mov    %eax,(%edi)
80107d29:	eb ad                	jmp    80107cd8 <walkpgdir+0x28>
80107d2b:	90                   	nop
80107d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  return &pgtab[PTX(va)];
}
80107d30:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
80107d33:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80107d35:	8b 75 f8             	mov    -0x8(%ebp),%esi
80107d38:	8b 7d fc             	mov    -0x4(%ebp),%edi
80107d3b:	89 ec                	mov    %ebp,%esp
80107d3d:	5d                   	pop    %ebp
80107d3e:	c3                   	ret    
80107d3f:	90                   	nop

80107d40 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107d40:	55                   	push   %ebp
80107d41:	89 e5                	mov    %esp,%ebp
80107d43:	57                   	push   %edi
80107d44:	56                   	push   %esi
80107d45:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107d46:	89 d3                	mov    %edx,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107d48:	83 ec 2c             	sub    $0x2c,%esp
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80107d4b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107d51:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107d54:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107d58:	8b 7d 08             	mov    0x8(%ebp),%edi
80107d5b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d60:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107d63:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d66:	29 df                	sub    %ebx,%edi
80107d68:	83 c8 01             	or     $0x1,%eax
80107d6b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107d6e:	eb 17                	jmp    80107d87 <mappages+0x47>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80107d70:	f6 00 01             	testb  $0x1,(%eax)
80107d73:	75 45                	jne    80107dba <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80107d75:	8b 55 dc             	mov    -0x24(%ebp),%edx
80107d78:	09 d6                	or     %edx,%esi
    if(a == last)
80107d7a:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80107d7d:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107d7f:	74 2f                	je     80107db0 <mappages+0x70>
      break;
    a += PGSIZE;
80107d81:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107d87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107d8a:	b9 01 00 00 00       	mov    $0x1,%ecx
80107d8f:	89 da                	mov    %ebx,%edx
80107d91:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107d94:	e8 17 ff ff ff       	call   80107cb0 <walkpgdir>
80107d99:	85 c0                	test   %eax,%eax
80107d9b:	75 d3                	jne    80107d70 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80107d9d:	83 c4 2c             	add    $0x2c,%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
80107da0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80107da5:	5b                   	pop    %ebx
80107da6:	5e                   	pop    %esi
80107da7:	5f                   	pop    %edi
80107da8:	5d                   	pop    %ebp
80107da9:	c3                   	ret    
80107daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107db0:	83 c4 2c             	add    $0x2c,%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107db3:	31 c0                	xor    %eax,%eax
}
80107db5:	5b                   	pop    %ebx
80107db6:	5e                   	pop    %esi
80107db7:	5f                   	pop    %edi
80107db8:	5d                   	pop    %ebp
80107db9:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80107dba:	c7 04 24 54 90 10 80 	movl   $0x80109054,(%esp)
80107dc1:	e8 7a 85 ff ff       	call   80100340 <panic>
80107dc6:	8d 76 00             	lea    0x0(%esi),%esi
80107dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107dd0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107dd0:	55                   	push   %ebp
80107dd1:	89 e5                	mov    %esp,%ebp
80107dd3:	57                   	push   %edi
80107dd4:	89 c7                	mov    %eax,%edi
80107dd6:	56                   	push   %esi
80107dd7:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107dd8:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107dde:	83 ec 2c             	sub    $0x2c,%esp
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107de1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107de7:	39 d3                	cmp    %edx,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107de9:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80107dec:	73 62                	jae    80107e50 <deallocuvm.part.0+0x80>
80107dee:	89 d6                	mov    %edx,%esi
80107df0:	eb 39                	jmp    80107e2b <deallocuvm.part.0+0x5b>
80107df2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107df8:	8b 10                	mov    (%eax),%edx
80107dfa:	f6 c2 01             	test   $0x1,%dl
80107dfd:	74 22                	je     80107e21 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107dff:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107e05:	74 54                	je     80107e5b <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107e07:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107e0d:	89 14 24             	mov    %edx,(%esp)
80107e10:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107e13:	e8 78 a5 ff ff       	call   80102390 <kfree>
      *pte = 0;
80107e18:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107e1b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80107e21:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107e27:	39 f3                	cmp    %esi,%ebx
80107e29:	73 25                	jae    80107e50 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107e2b:	31 c9                	xor    %ecx,%ecx
80107e2d:	89 da                	mov    %ebx,%edx
80107e2f:	89 f8                	mov    %edi,%eax
80107e31:	e8 7a fe ff ff       	call   80107cb0 <walkpgdir>
    if(!pte)
80107e36:	85 c0                	test   %eax,%eax
80107e38:	75 be                	jne    80107df8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107e3a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107e40:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80107e46:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107e4c:	39 f3                	cmp    %esi,%ebx
80107e4e:	72 db                	jb     80107e2b <deallocuvm.part.0+0x5b>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107e50:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107e53:	83 c4 2c             	add    $0x2c,%esp
80107e56:	5b                   	pop    %ebx
80107e57:	5e                   	pop    %esi
80107e58:	5f                   	pop    %edi
80107e59:	5d                   	pop    %ebp
80107e5a:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80107e5b:	c7 04 24 c6 88 10 80 	movl   $0x801088c6,(%esp)
80107e62:	e8 d9 84 ff ff       	call   80100340 <panic>
80107e67:	89 f6                	mov    %esi,%esi
80107e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107e70 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107e70:	55                   	push   %ebp
80107e71:	89 e5                	mov    %esp,%ebp
80107e73:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80107e76:	e8 c5 ba ff ff       	call   80103940 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107e7b:	31 c9                	xor    %ecx,%ecx
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80107e7d:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
80107e83:	8d 14 80             	lea    (%eax,%eax,4),%edx
80107e86:	8d 14 50             	lea    (%eax,%edx,2),%edx
80107e89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e8e:	c1 e2 04             	shl    $0x4,%edx
80107e91:	66 89 82 58 48 11 80 	mov    %ax,-0x7feeb7a8(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107e98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e9d:	66 89 82 60 48 11 80 	mov    %ax,-0x7feeb7a0(%edx)
80107ea4:	31 c0                	xor    %eax,%eax
80107ea6:	66 89 82 62 48 11 80 	mov    %ax,-0x7feeb79e(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107ead:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107eb2:	66 89 82 68 48 11 80 	mov    %ax,-0x7feeb798(%edx)
80107eb9:	31 c0                	xor    %eax,%eax
80107ebb:	66 89 82 6a 48 11 80 	mov    %ax,-0x7feeb796(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107ec2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107ec7:	66 89 82 70 48 11 80 	mov    %ax,-0x7feeb790(%edx)
80107ece:	31 c0                	xor    %eax,%eax
80107ed0:	66 89 82 72 48 11 80 	mov    %ax,-0x7feeb78e(%edx)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107ed7:	66 89 8a 5a 48 11 80 	mov    %cx,-0x7feeb7a6(%edx)
80107ede:	c6 82 5c 48 11 80 00 	movb   $0x0,-0x7feeb7a4(%edx)
80107ee5:	c6 82 5d 48 11 80 9a 	movb   $0x9a,-0x7feeb7a3(%edx)
80107eec:	c6 82 5e 48 11 80 cf 	movb   $0xcf,-0x7feeb7a2(%edx)
80107ef3:	c6 82 5f 48 11 80 00 	movb   $0x0,-0x7feeb7a1(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107efa:	c6 82 64 48 11 80 00 	movb   $0x0,-0x7feeb79c(%edx)
80107f01:	c6 82 65 48 11 80 92 	movb   $0x92,-0x7feeb79b(%edx)
80107f08:	c6 82 66 48 11 80 cf 	movb   $0xcf,-0x7feeb79a(%edx)
80107f0f:	c6 82 67 48 11 80 00 	movb   $0x0,-0x7feeb799(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107f16:	c6 82 6c 48 11 80 00 	movb   $0x0,-0x7feeb794(%edx)
80107f1d:	c6 82 6d 48 11 80 fa 	movb   $0xfa,-0x7feeb793(%edx)
80107f24:	c6 82 6e 48 11 80 cf 	movb   $0xcf,-0x7feeb792(%edx)
80107f2b:	c6 82 6f 48 11 80 00 	movb   $0x0,-0x7feeb791(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107f32:	c6 82 74 48 11 80 00 	movb   $0x0,-0x7feeb78c(%edx)
80107f39:	c6 82 75 48 11 80 f2 	movb   $0xf2,-0x7feeb78b(%edx)
80107f40:	c6 82 76 48 11 80 cf 	movb   $0xcf,-0x7feeb78a(%edx)
80107f47:	c6 82 77 48 11 80 00 	movb   $0x0,-0x7feeb789(%edx)
  lgdt(c->gdt, sizeof(c->gdt));
80107f4e:	81 c2 50 48 11 80    	add    $0x80114850,%edx
  pd[1] = (uint)p;
80107f54:	0f b7 c2             	movzwl %dx,%eax
  pd[2] = (uint)p >> 16;
80107f57:	c1 ea 10             	shr    $0x10,%edx
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
80107f5a:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;

  asm volatile("lgdt (%0)" : : "r" (pd));
80107f5e:	8d 45 f2             	lea    -0xe(%ebp),%eax
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
  pd[2] = (uint)p >> 16;
80107f61:	66 89 55 f6          	mov    %dx,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107f65:	0f 01 10             	lgdtl  (%eax)
}
80107f68:	c9                   	leave  
80107f69:	c3                   	ret    
80107f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107f70 <switchkvm>:
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107f70:	a1 04 80 11 80       	mov    0x80118004,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107f75:	55                   	push   %ebp
80107f76:	89 e5                	mov    %esp,%ebp
80107f78:	05 00 00 00 80       	add    $0x80000000,%eax
80107f7d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80107f80:	5d                   	pop    %ebp
80107f81:	c3                   	ret    
80107f82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107f90 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107f90:	55                   	push   %ebp
80107f91:	89 e5                	mov    %esp,%ebp
80107f93:	57                   	push   %edi
80107f94:	56                   	push   %esi
80107f95:	53                   	push   %ebx
80107f96:	83 ec 2c             	sub    $0x2c,%esp
80107f99:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107f9c:	85 f6                	test   %esi,%esi
80107f9e:	0f 84 c7 00 00 00    	je     8010806b <switchuvm+0xdb>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80107fa4:	8b 5e 08             	mov    0x8(%esi),%ebx
80107fa7:	85 db                	test   %ebx,%ebx
80107fa9:	0f 84 d4 00 00 00    	je     80108083 <switchuvm+0xf3>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80107faf:	8b 4e 04             	mov    0x4(%esi),%ecx
80107fb2:	85 c9                	test   %ecx,%ecx
80107fb4:	0f 84 bd 00 00 00    	je     80108077 <switchuvm+0xe7>
    panic("switchuvm: no pgdir");

  pushcli();
80107fba:	e8 e1 d8 ff ff       	call   801058a0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107fbf:	e8 fc b8 ff ff       	call   801038c0 <mycpu>
80107fc4:	89 c3                	mov    %eax,%ebx
80107fc6:	e8 f5 b8 ff ff       	call   801038c0 <mycpu>
80107fcb:	89 c7                	mov    %eax,%edi
80107fcd:	e8 ee b8 ff ff       	call   801038c0 <mycpu>
80107fd2:	83 c7 08             	add    $0x8,%edi
80107fd5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107fd8:	e8 e3 b8 ff ff       	call   801038c0 <mycpu>
80107fdd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107fe0:	ba 67 00 00 00       	mov    $0x67,%edx
80107fe5:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80107fec:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107ff3:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80107ffa:	83 c1 08             	add    $0x8,%ecx
80107ffd:	c1 e9 10             	shr    $0x10,%ecx
80108000:	83 c0 08             	add    $0x8,%eax
80108003:	c1 e8 18             	shr    $0x18,%eax
80108006:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
8010800c:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80108013:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80108019:	e8 a2 b8 ff ff       	call   801038c0 <mycpu>
8010801e:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80108025:	e8 96 b8 ff ff       	call   801038c0 <mycpu>
8010802a:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80108030:	e8 8b b8 ff ff       	call   801038c0 <mycpu>
80108035:	8b 56 08             	mov    0x8(%esi),%edx
80108038:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
8010803e:	89 48 0c             	mov    %ecx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108041:	e8 7a b8 ff ff       	call   801038c0 <mycpu>
80108046:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
8010804c:	b8 28 00 00 00       	mov    $0x28,%eax
80108051:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80108054:	8b 46 04             	mov    0x4(%esi),%eax
80108057:	05 00 00 00 80       	add    $0x80000000,%eax
8010805c:	0f 22 d8             	mov    %eax,%cr3
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
8010805f:	83 c4 2c             	add    $0x2c,%esp
80108062:	5b                   	pop    %ebx
80108063:	5e                   	pop    %esi
80108064:	5f                   	pop    %edi
80108065:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80108066:	e9 75 d8 ff ff       	jmp    801058e0 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
8010806b:	c7 04 24 5a 90 10 80 	movl   $0x8010905a,(%esp)
80108072:	e8 c9 82 ff ff       	call   80100340 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80108077:	c7 04 24 85 90 10 80 	movl   $0x80109085,(%esp)
8010807e:	e8 bd 82 ff ff       	call   80100340 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80108083:	c7 04 24 70 90 10 80 	movl   $0x80109070,(%esp)
8010808a:	e8 b1 82 ff ff       	call   80100340 <panic>
8010808f:	90                   	nop

80108090 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80108090:	55                   	push   %ebp
80108091:	89 e5                	mov    %esp,%ebp
80108093:	83 ec 38             	sub    $0x38,%esp
80108096:	89 75 f8             	mov    %esi,-0x8(%ebp)
80108099:	8b 75 10             	mov    0x10(%ebp),%esi
8010809c:	8b 45 08             	mov    0x8(%ebp),%eax
8010809f:	89 7d fc             	mov    %edi,-0x4(%ebp)
801080a2:	8b 7d 0c             	mov    0xc(%ebp),%edi
801080a5:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  char *mem;

  if(sz >= PGSIZE)
801080a8:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801080ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
801080b1:	77 59                	ja     8010810c <inituvm+0x7c>
    panic("inituvm: more than a page");
  mem = kalloc();
801080b3:	e8 a8 a4 ff ff       	call   80102560 <kalloc>
  memset(mem, 0, PGSIZE);
801080b8:	31 d2                	xor    %edx,%edx
801080ba:	89 54 24 04          	mov    %edx,0x4(%esp)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
801080be:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801080c0:	b8 00 10 00 00       	mov    $0x1000,%eax
801080c5:	89 1c 24             	mov    %ebx,(%esp)
801080c8:	89 44 24 08          	mov    %eax,0x8(%esp)
801080cc:	e8 af d9 ff ff       	call   80105a80 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801080d1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801080d7:	b9 06 00 00 00       	mov    $0x6,%ecx
801080dc:	89 04 24             	mov    %eax,(%esp)
801080df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801080e2:	31 d2                	xor    %edx,%edx
801080e4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801080e8:	b9 00 10 00 00       	mov    $0x1000,%ecx
801080ed:	e8 4e fc ff ff       	call   80107d40 <mappages>
  memmove(mem, init, sz);
801080f2:	89 75 10             	mov    %esi,0x10(%ebp)
}
801080f5:	8b 75 f8             	mov    -0x8(%ebp),%esi
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
801080f8:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
801080fb:	8b 7d fc             	mov    -0x4(%ebp),%edi
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
801080fe:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80108101:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80108104:	89 ec                	mov    %ebp,%esp
80108106:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80108107:	e9 34 da ff ff       	jmp    80105b40 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
8010810c:	c7 04 24 99 90 10 80 	movl   $0x80109099,(%esp)
80108113:	e8 28 82 ff ff       	call   80100340 <panic>
80108118:	90                   	nop
80108119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108120 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80108120:	55                   	push   %ebp
80108121:	89 e5                	mov    %esp,%ebp
80108123:	57                   	push   %edi
80108124:	56                   	push   %esi
80108125:	53                   	push   %ebx
80108126:	83 ec 1c             	sub    $0x1c,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80108129:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80108130:	0f 85 98 00 00 00    	jne    801081ce <loaduvm+0xae>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80108136:	8b 75 18             	mov    0x18(%ebp),%esi
80108139:	31 db                	xor    %ebx,%ebx
8010813b:	85 f6                	test   %esi,%esi
8010813d:	75 1a                	jne    80108159 <loaduvm+0x39>
8010813f:	eb 77                	jmp    801081b8 <loaduvm+0x98>
80108141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108148:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010814e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80108154:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80108157:	76 5f                	jbe    801081b8 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80108159:	8b 55 0c             	mov    0xc(%ebp),%edx
8010815c:	31 c9                	xor    %ecx,%ecx
8010815e:	8b 45 08             	mov    0x8(%ebp),%eax
80108161:	01 da                	add    %ebx,%edx
80108163:	e8 48 fb ff ff       	call   80107cb0 <walkpgdir>
80108168:	85 c0                	test   %eax,%eax
8010816a:	74 56                	je     801081c2 <loaduvm+0xa2>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
8010816c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
8010816e:	bf 00 10 00 00       	mov    $0x1000,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108173:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80108176:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010817b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80108181:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80108184:	05 00 00 00 80       	add    $0x80000000,%eax
80108189:	89 44 24 04          	mov    %eax,0x4(%esp)
8010818d:	8b 45 10             	mov    0x10(%ebp),%eax
80108190:	01 d9                	add    %ebx,%ecx
80108192:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80108196:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010819a:	89 04 24             	mov    %eax,(%esp)
8010819d:	e8 2e 98 ff ff       	call   801019d0 <readi>
801081a2:	39 c7                	cmp    %eax,%edi
801081a4:	74 a2                	je     80108148 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
801081a6:	83 c4 1c             	add    $0x1c,%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
801081a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
801081ae:	5b                   	pop    %ebx
801081af:	5e                   	pop    %esi
801081b0:	5f                   	pop    %edi
801081b1:	5d                   	pop    %ebp
801081b2:	c3                   	ret    
801081b3:	90                   	nop
801081b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801081b8:	83 c4 1c             	add    $0x1c,%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
801081bb:	31 c0                	xor    %eax,%eax
}
801081bd:	5b                   	pop    %ebx
801081be:	5e                   	pop    %esi
801081bf:	5f                   	pop    %edi
801081c0:	5d                   	pop    %ebp
801081c1:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
801081c2:	c7 04 24 b3 90 10 80 	movl   $0x801090b3,(%esp)
801081c9:	e8 72 81 ff ff       	call   80100340 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
801081ce:	c7 04 24 54 91 10 80 	movl   $0x80109154,(%esp)
801081d5:	e8 66 81 ff ff       	call   80100340 <panic>
801081da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801081e0 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801081e0:	55                   	push   %ebp
801081e1:	89 e5                	mov    %esp,%ebp
801081e3:	57                   	push   %edi
801081e4:	56                   	push   %esi
801081e5:	53                   	push   %ebx
801081e6:	83 ec 1c             	sub    $0x1c,%esp
801081e9:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
801081ec:	85 ff                	test   %edi,%edi
801081ee:	0f 88 ca 00 00 00    	js     801082be <allocuvm+0xde>
    return 0;
  if(newsz < oldsz)
801081f4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
801081f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
801081fa:	0f 82 89 00 00 00    	jb     80108289 <allocuvm+0xa9>
    return oldsz;

  a = PGROUNDUP(oldsz);
80108200:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80108206:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010820c:	39 df                	cmp    %ebx,%edi
8010820e:	77 4e                	ja     8010825e <allocuvm+0x7e>
80108210:	e9 bb 00 00 00       	jmp    801082d0 <allocuvm+0xf0>
80108215:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80108218:	31 d2                	xor    %edx,%edx
8010821a:	b8 00 10 00 00       	mov    $0x1000,%eax
8010821f:	89 54 24 04          	mov    %edx,0x4(%esp)
80108223:	89 44 24 08          	mov    %eax,0x8(%esp)
80108227:	89 34 24             	mov    %esi,(%esp)
8010822a:	e8 51 d8 ff ff       	call   80105a80 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
8010822f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80108235:	b9 06 00 00 00       	mov    $0x6,%ecx
8010823a:	89 04 24             	mov    %eax,(%esp)
8010823d:	8b 45 08             	mov    0x8(%ebp),%eax
80108240:	89 da                	mov    %ebx,%edx
80108242:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80108246:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010824b:	e8 f0 fa ff ff       	call   80107d40 <mappages>
80108250:	85 c0                	test   %eax,%eax
80108252:	78 44                	js     80108298 <allocuvm+0xb8>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80108254:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010825a:	39 df                	cmp    %ebx,%edi
8010825c:	76 72                	jbe    801082d0 <allocuvm+0xf0>
    mem = kalloc();
8010825e:	e8 fd a2 ff ff       	call   80102560 <kalloc>
    if(mem == 0){
80108263:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80108265:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80108267:	75 af                	jne    80108218 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80108269:	c7 04 24 d1 90 10 80 	movl   $0x801090d1,(%esp)
80108270:	e8 cb 83 ff ff       	call   80100640 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80108275:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80108278:	76 44                	jbe    801082be <allocuvm+0xde>
8010827a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010827d:	89 fa                	mov    %edi,%edx
8010827f:	8b 45 08             	mov    0x8(%ebp),%eax
80108282:	e8 49 fb ff ff       	call   80107dd0 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80108287:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80108289:	83 c4 1c             	add    $0x1c,%esp
8010828c:	5b                   	pop    %ebx
8010828d:	5e                   	pop    %esi
8010828e:	5f                   	pop    %edi
8010828f:	5d                   	pop    %ebp
80108290:	c3                   	ret    
80108291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80108298:	c7 04 24 e9 90 10 80 	movl   $0x801090e9,(%esp)
8010829f:	e8 9c 83 ff ff       	call   80100640 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801082a4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801082a7:	76 0d                	jbe    801082b6 <allocuvm+0xd6>
801082a9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801082ac:	89 fa                	mov    %edi,%edx
801082ae:	8b 45 08             	mov    0x8(%ebp),%eax
801082b1:	e8 1a fb ff ff       	call   80107dd0 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
801082b6:	89 34 24             	mov    %esi,(%esp)
801082b9:	e8 d2 a0 ff ff       	call   80102390 <kfree>
      return 0;
    }
  }
  return newsz;
}
801082be:	83 c4 1c             	add    $0x1c,%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
801082c1:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
801082c3:	5b                   	pop    %ebx
801082c4:	5e                   	pop    %esi
801082c5:	5f                   	pop    %edi
801082c6:	5d                   	pop    %ebp
801082c7:	c3                   	ret    
801082c8:	90                   	nop
801082c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801082d0:	83 c4 1c             	add    $0x1c,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801082d3:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
801082d5:	5b                   	pop    %ebx
801082d6:	5e                   	pop    %esi
801082d7:	5f                   	pop    %edi
801082d8:	5d                   	pop    %ebp
801082d9:	c3                   	ret    
801082da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801082e0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801082e0:	55                   	push   %ebp
801082e1:	89 e5                	mov    %esp,%ebp
801082e3:	8b 55 0c             	mov    0xc(%ebp),%edx
801082e6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801082e9:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801082ec:	39 d1                	cmp    %edx,%ecx
801082ee:	73 10                	jae    80108300 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801082f0:	5d                   	pop    %ebp
801082f1:	e9 da fa ff ff       	jmp    80107dd0 <deallocuvm.part.0>
801082f6:	8d 76 00             	lea    0x0(%esi),%esi
801082f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80108300:	89 d0                	mov    %edx,%eax
80108302:	5d                   	pop    %ebp
80108303:	c3                   	ret    
80108304:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010830a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108310 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108310:	55                   	push   %ebp
80108311:	89 e5                	mov    %esp,%ebp
80108313:	57                   	push   %edi
80108314:	56                   	push   %esi
80108315:	53                   	push   %ebx
80108316:	83 ec 1c             	sub    $0x1c,%esp
80108319:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010831c:	85 f6                	test   %esi,%esi
8010831e:	74 55                	je     80108375 <freevm+0x65>
80108320:	31 c9                	xor    %ecx,%ecx
80108322:	ba 00 00 00 80       	mov    $0x80000000,%edx
80108327:	89 f0                	mov    %esi,%eax
80108329:	89 f3                	mov    %esi,%ebx
8010832b:	e8 a0 fa ff ff       	call   80107dd0 <deallocuvm.part.0>
80108330:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108336:	eb 0f                	jmp    80108347 <freevm+0x37>
80108338:	90                   	nop
80108339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108340:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108343:	39 fb                	cmp    %edi,%ebx
80108345:	74 1f                	je     80108366 <freevm+0x56>
    if(pgdir[i] & PTE_P){
80108347:	8b 03                	mov    (%ebx),%eax
80108349:	a8 01                	test   $0x1,%al
8010834b:	74 f3                	je     80108340 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
8010834d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108352:	83 c3 04             	add    $0x4,%ebx
80108355:	05 00 00 00 80       	add    $0x80000000,%eax
8010835a:	89 04 24             	mov    %eax,(%esp)
8010835d:	e8 2e a0 ff ff       	call   80102390 <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108362:	39 fb                	cmp    %edi,%ebx
80108364:	75 e1                	jne    80108347 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80108366:	89 75 08             	mov    %esi,0x8(%ebp)
}
80108369:	83 c4 1c             	add    $0x1c,%esp
8010836c:	5b                   	pop    %ebx
8010836d:	5e                   	pop    %esi
8010836e:	5f                   	pop    %edi
8010836f:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80108370:	e9 1b a0 ff ff       	jmp    80102390 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80108375:	c7 04 24 05 91 10 80 	movl   $0x80109105,(%esp)
8010837c:	e8 bf 7f ff ff       	call   80100340 <panic>
80108381:	eb 0d                	jmp    80108390 <setupkvm>
80108383:	90                   	nop
80108384:	90                   	nop
80108385:	90                   	nop
80108386:	90                   	nop
80108387:	90                   	nop
80108388:	90                   	nop
80108389:	90                   	nop
8010838a:	90                   	nop
8010838b:	90                   	nop
8010838c:	90                   	nop
8010838d:	90                   	nop
8010838e:	90                   	nop
8010838f:	90                   	nop

80108390 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80108390:	55                   	push   %ebp
80108391:	89 e5                	mov    %esp,%ebp
80108393:	56                   	push   %esi
80108394:	53                   	push   %ebx
80108395:	83 ec 10             	sub    $0x10,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80108398:	e8 c3 a1 ff ff       	call   80102560 <kalloc>
8010839d:	85 c0                	test   %eax,%eax
8010839f:	74 6f                	je     80108410 <setupkvm+0x80>
801083a1:	89 c6                	mov    %eax,%esi
    return 0;
  memset(pgdir, 0, PGSIZE);
801083a3:	31 d2                	xor    %edx,%edx
801083a5:	b8 00 10 00 00       	mov    $0x1000,%eax
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801083aa:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
801083af:	89 44 24 08          	mov    %eax,0x8(%esp)
801083b3:	89 54 24 04          	mov    %edx,0x4(%esp)
801083b7:	89 34 24             	mov    %esi,(%esp)
801083ba:	e8 c1 d6 ff ff       	call   80105a80 <memset>
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801083bf:	8b 53 0c             	mov    0xc(%ebx),%edx
801083c2:	8b 43 04             	mov    0x4(%ebx),%eax
801083c5:	8b 4b 08             	mov    0x8(%ebx),%ecx
801083c8:	89 54 24 04          	mov    %edx,0x4(%esp)
801083cc:	8b 13                	mov    (%ebx),%edx
801083ce:	89 04 24             	mov    %eax,(%esp)
801083d1:	29 c1                	sub    %eax,%ecx
801083d3:	89 f0                	mov    %esi,%eax
801083d5:	e8 66 f9 ff ff       	call   80107d40 <mappages>
801083da:	85 c0                	test   %eax,%eax
801083dc:	78 1a                	js     801083f8 <setupkvm+0x68>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801083de:	83 c3 10             	add    $0x10,%ebx
801083e1:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
801083e7:	75 d6                	jne    801083bf <setupkvm+0x2f>
801083e9:	89 f0                	mov    %esi,%eax
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
801083eb:	83 c4 10             	add    $0x10,%esp
801083ee:	5b                   	pop    %ebx
801083ef:	5e                   	pop    %esi
801083f0:	5d                   	pop    %ebp
801083f1:	c3                   	ret    
801083f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
801083f8:	89 34 24             	mov    %esi,(%esp)
801083fb:	e8 10 ff ff ff       	call   80108310 <freevm>
      return 0;
    }
  return pgdir;
}
80108400:	83 c4 10             	add    $0x10,%esp
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
80108403:	31 c0                	xor    %eax,%eax
    }
  return pgdir;
}
80108405:	5b                   	pop    %ebx
80108406:	5e                   	pop    %esi
80108407:	5d                   	pop    %ebp
80108408:	c3                   	ret    
80108409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80108410:	31 c0                	xor    %eax,%eax
80108412:	eb d7                	jmp    801083eb <setupkvm+0x5b>
80108414:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010841a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80108420 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80108420:	55                   	push   %ebp
80108421:	89 e5                	mov    %esp,%ebp
80108423:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108426:	e8 65 ff ff ff       	call   80108390 <setupkvm>
8010842b:	a3 04 80 11 80       	mov    %eax,0x80118004
80108430:	05 00 00 00 80       	add    $0x80000000,%eax
80108435:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80108438:	c9                   	leave  
80108439:	c3                   	ret    
8010843a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108440 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108440:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108441:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108443:	89 e5                	mov    %esp,%ebp
80108445:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108448:	8b 55 0c             	mov    0xc(%ebp),%edx
8010844b:	8b 45 08             	mov    0x8(%ebp),%eax
8010844e:	e8 5d f8 ff ff       	call   80107cb0 <walkpgdir>
  if(pte == 0)
80108453:	85 c0                	test   %eax,%eax
80108455:	74 05                	je     8010845c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80108457:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010845a:	c9                   	leave  
8010845b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
8010845c:	c7 04 24 16 91 10 80 	movl   $0x80109116,(%esp)
80108463:	e8 d8 7e ff ff       	call   80100340 <panic>
80108468:	90                   	nop
80108469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80108470 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108470:	55                   	push   %ebp
80108471:	89 e5                	mov    %esp,%ebp
80108473:	57                   	push   %edi
80108474:	56                   	push   %esi
80108475:	53                   	push   %ebx
80108476:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108479:	e8 12 ff ff ff       	call   80108390 <setupkvm>
8010847e:	85 c0                	test   %eax,%eax
80108480:	89 45 e0             	mov    %eax,-0x20(%ebp)
80108483:	0f 84 c1 00 00 00    	je     8010854a <copyuvm+0xda>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108489:	8b 55 0c             	mov    0xc(%ebp),%edx
8010848c:	85 d2                	test   %edx,%edx
8010848e:	0f 84 9c 00 00 00    	je     80108530 <copyuvm+0xc0>
80108494:	31 ff                	xor    %edi,%edi
80108496:	eb 50                	jmp    801084e8 <copyuvm+0x78>
80108498:	90                   	nop
80108499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801084a0:	b8 00 10 00 00       	mov    $0x1000,%eax
801084a5:	89 44 24 08          	mov    %eax,0x8(%esp)
801084a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801084ac:	89 34 24             	mov    %esi,(%esp)
801084af:	05 00 00 00 80       	add    $0x80000000,%eax
801084b4:	89 44 24 04          	mov    %eax,0x4(%esp)
801084b8:	e8 83 d6 ff ff       	call   80105b40 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801084bd:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801084c3:	b9 00 10 00 00       	mov    $0x1000,%ecx
801084c8:	89 04 24             	mov    %eax,(%esp)
801084cb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801084ce:	89 fa                	mov    %edi,%edx
801084d0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801084d4:	e8 67 f8 ff ff       	call   80107d40 <mappages>
801084d9:	85 c0                	test   %eax,%eax
801084db:	78 63                	js     80108540 <copyuvm+0xd0>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801084dd:	81 c7 00 10 00 00    	add    $0x1000,%edi
801084e3:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801084e6:	76 48                	jbe    80108530 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801084e8:	8b 45 08             	mov    0x8(%ebp),%eax
801084eb:	31 c9                	xor    %ecx,%ecx
801084ed:	89 fa                	mov    %edi,%edx
801084ef:	e8 bc f7 ff ff       	call   80107cb0 <walkpgdir>
801084f4:	85 c0                	test   %eax,%eax
801084f6:	74 62                	je     8010855a <copyuvm+0xea>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
801084f8:	8b 18                	mov    (%eax),%ebx
801084fa:	f6 c3 01             	test   $0x1,%bl
801084fd:	74 4f                	je     8010854e <copyuvm+0xde>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801084ff:	89 d8                	mov    %ebx,%eax
    flags = PTE_FLAGS(*pte);
80108501:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80108507:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010850c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
8010850f:	e8 4c a0 ff ff       	call   80102560 <kalloc>
80108514:	85 c0                	test   %eax,%eax
80108516:	89 c6                	mov    %eax,%esi
80108518:	75 86                	jne    801084a0 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
8010851a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010851d:	89 04 24             	mov    %eax,(%esp)
80108520:	e8 eb fd ff ff       	call   80108310 <freevm>
  return 0;
80108525:	31 c0                	xor    %eax,%eax
}
80108527:	83 c4 2c             	add    $0x2c,%esp
8010852a:	5b                   	pop    %ebx
8010852b:	5e                   	pop    %esi
8010852c:	5f                   	pop    %edi
8010852d:	5d                   	pop    %ebp
8010852e:	c3                   	ret    
8010852f:	90                   	nop
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108530:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
80108533:	83 c4 2c             	add    $0x2c,%esp
80108536:	5b                   	pop    %ebx
80108537:	5e                   	pop    %esi
80108538:	5f                   	pop    %edi
80108539:	5d                   	pop    %ebp
8010853a:	c3                   	ret    
8010853b:	90                   	nop
8010853c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
80108540:	89 34 24             	mov    %esi,(%esp)
80108543:	e8 48 9e ff ff       	call   80102390 <kfree>
      goto bad;
80108548:	eb d0                	jmp    8010851a <copyuvm+0xaa>
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
8010854a:	31 c0                	xor    %eax,%eax
8010854c:	eb d9                	jmp    80108527 <copyuvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
8010854e:	c7 04 24 3a 91 10 80 	movl   $0x8010913a,(%esp)
80108555:	e8 e6 7d ff ff       	call   80100340 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010855a:	c7 04 24 20 91 10 80 	movl   $0x80109120,(%esp)
80108561:	e8 da 7d ff ff       	call   80100340 <panic>
80108566:	8d 76 00             	lea    0x0(%esi),%esi
80108569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80108570 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108570:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108571:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108573:	89 e5                	mov    %esp,%ebp
80108575:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80108578:	8b 55 0c             	mov    0xc(%ebp),%edx
8010857b:	8b 45 08             	mov    0x8(%ebp),%eax
8010857e:	e8 2d f7 ff ff       	call   80107cb0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80108583:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80108585:	89 c2                	mov    %eax,%edx
80108587:	83 e2 05             	and    $0x5,%edx
8010858a:	83 fa 05             	cmp    $0x5,%edx
8010858d:	75 11                	jne    801085a0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010858f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108594:	05 00 00 00 80       	add    $0x80000000,%eax
}
80108599:	c9                   	leave  
8010859a:	c3                   	ret    
8010859b:	90                   	nop
8010859c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
801085a0:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
801085a2:	c9                   	leave  
801085a3:	c3                   	ret    
801085a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801085aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801085b0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801085b0:	55                   	push   %ebp
801085b1:	89 e5                	mov    %esp,%ebp
801085b3:	57                   	push   %edi
801085b4:	56                   	push   %esi
801085b5:	53                   	push   %ebx
801085b6:	83 ec 2c             	sub    $0x2c,%esp
801085b9:	8b 75 14             	mov    0x14(%ebp),%esi
801085bc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801085bf:	85 f6                	test   %esi,%esi
801085c1:	89 da                	mov    %ebx,%edx
801085c3:	75 41                	jne    80108606 <copyout+0x56>
801085c5:	eb 71                	jmp    80108638 <copyout+0x88>
801085c7:	89 f6                	mov    %esi,%esi
801085c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801085d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801085d3:	89 df                	mov    %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801085d5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801085d8:	29 d7                	sub    %edx,%edi
801085da:	81 c7 00 10 00 00    	add    $0x1000,%edi
801085e0:	39 f7                	cmp    %esi,%edi
801085e2:	0f 47 fe             	cmova  %esi,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801085e5:	29 da                	sub    %ebx,%edx
801085e7:	01 c2                	add    %eax,%edx
801085e9:	89 14 24             	mov    %edx,(%esp)
801085ec:	89 7c 24 08          	mov    %edi,0x8(%esp)
801085f0:	89 4c 24 04          	mov    %ecx,0x4(%esp)
801085f4:	e8 47 d5 ff ff       	call   80105b40 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801085f9:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
801085ff:	01 7d 10             	add    %edi,0x10(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108602:	29 fe                	sub    %edi,%esi
80108604:	74 32                	je     80108638 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
80108606:	8b 45 08             	mov    0x8(%ebp),%eax
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80108609:	89 d3                	mov    %edx,%ebx
8010860b:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    pa0 = uva2ka(pgdir, (char*)va0);
80108611:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80108615:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80108618:	89 04 24             	mov    %eax,(%esp)
8010861b:	e8 50 ff ff ff       	call   80108570 <uva2ka>
    if(pa0 == 0)
80108620:	85 c0                	test   %eax,%eax
80108622:	75 ac                	jne    801085d0 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80108624:	83 c4 2c             	add    $0x2c,%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80108627:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
8010862c:	5b                   	pop    %ebx
8010862d:	5e                   	pop    %esi
8010862e:	5f                   	pop    %edi
8010862f:	5d                   	pop    %ebp
80108630:	c3                   	ret    
80108631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80108638:	83 c4 2c             	add    $0x2c,%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
8010863b:	31 c0                	xor    %eax,%eax
}
8010863d:	5b                   	pop    %ebx
8010863e:	5e                   	pop    %esi
8010863f:	5f                   	pop    %edi
80108640:	5d                   	pop    %ebp
80108641:	c3                   	ret    
