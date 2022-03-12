
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
80100028:	bc d0 c5 10 80       	mov    $0x8010c5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 40 2f 10 80       	mov    $0x80102f40,%eax
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
80100041:	89 e5                	mov    %esp,%ebp
80100043:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
80100046:	68 80 7c 10 80       	push   $0x80107c80
8010004b:	68 e0 c5 10 80       	push   $0x8010c5e0
80100050:	e8 8b 4a 00 00       	call   80104ae0 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100055:	c7 05 f0 04 11 80 e4 	movl   $0x801104e4,0x801104f0
8010005c:	04 11 80 
  bcache.head.next = &bcache.head;
8010005f:	c7 05 f4 04 11 80 e4 	movl   $0x801104e4,0x801104f4
80100066:	04 11 80 
80100069:	83 c4 10             	add    $0x10,%esp
8010006c:	b9 e4 04 11 80       	mov    $0x801104e4,%ecx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100071:	b8 14 c6 10 80       	mov    $0x8010c614,%eax
80100076:	eb 0a                	jmp    80100082 <binit+0x42>
80100078:	90                   	nop
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d0                	mov    %edx,%eax
    b->next = bcache.head.next;
80100082:	89 48 10             	mov    %ecx,0x10(%eax)
    b->prev = &bcache.head;
80100085:	c7 40 0c e4 04 11 80 	movl   $0x801104e4,0xc(%eax)
8010008c:	89 c1                	mov    %eax,%ecx
    b->dev = -1;
8010008e:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
80100095:	8b 15 f4 04 11 80    	mov    0x801104f4,%edx
8010009b:	89 42 0c             	mov    %eax,0xc(%edx)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009e:	8d 90 18 02 00 00    	lea    0x218(%eax),%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000a4:	a3 f4 04 11 80       	mov    %eax,0x801104f4

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a9:	81 fa e4 04 11 80    	cmp    $0x801104e4,%edx
801000af:	75 cf                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000b1:	c9                   	leave  
801000b2:	c3                   	ret    
801000b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801000b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000c0 <bread>:
}

// Return a B_BUSY buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000c0:	55                   	push   %ebp
801000c1:	89 e5                	mov    %esp,%ebp
801000c3:	57                   	push   %edi
801000c4:	56                   	push   %esi
801000c5:	53                   	push   %ebx
801000c6:	83 ec 18             	sub    $0x18,%esp
801000c9:	8b 75 08             	mov    0x8(%ebp),%esi
801000cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000cf:	68 e0 c5 10 80       	push   $0x8010c5e0
801000d4:	e8 27 4a 00 00       	call   80104b00 <acquire>
801000d9:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000dc:	8b 1d f4 04 11 80    	mov    0x801104f4,%ebx
801000e2:	81 fb e4 04 11 80    	cmp    $0x801104e4,%ebx
801000e8:	75 11                	jne    801000fb <bread+0x3b>
801000ea:	eb 34                	jmp    80100120 <bread+0x60>
801000ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801000f0:	8b 5b 10             	mov    0x10(%ebx),%ebx
801000f3:	81 fb e4 04 11 80    	cmp    $0x801104e4,%ebx
801000f9:	74 25                	je     80100120 <bread+0x60>
    if(b->dev == dev && b->blockno == blockno){
801000fb:	3b 73 04             	cmp    0x4(%ebx),%esi
801000fe:	75 f0                	jne    801000f0 <bread+0x30>
80100100:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100103:	75 eb                	jne    801000f0 <bread+0x30>
      if(!(b->flags & B_BUSY)){
80100105:	8b 03                	mov    (%ebx),%eax
80100107:	a8 01                	test   $0x1,%al
80100109:	74 6c                	je     80100177 <bread+0xb7>
		  
        b->flags |= B_BUSY;
        release(&bcache.lock);
        return b;
      }
      sleep(b, &bcache.lock);
8010010b:	83 ec 08             	sub    $0x8,%esp
8010010e:	68 e0 c5 10 80       	push   $0x8010c5e0
80100113:	53                   	push   %ebx
80100114:	e8 f7 3f 00 00       	call   80104110 <sleep>
80100119:	83 c4 10             	add    $0x10,%esp
8010011c:	eb be                	jmp    801000dc <bread+0x1c>
8010011e:	66 90                	xchg   %ax,%ax
  }

  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d f0 04 11 80    	mov    0x801104f0,%ebx
80100126:	81 fb e4 04 11 80    	cmp    $0x801104e4,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x7b>
8010012e:	eb 5e                	jmp    8010018e <bread+0xce>
80100130:	8b 5b 0c             	mov    0xc(%ebx),%ebx
80100133:	81 fb e4 04 11 80    	cmp    $0x801104e4,%ebx
80100139:	74 53                	je     8010018e <bread+0xce>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
8010013b:	f6 03 05             	testb  $0x5,(%ebx)
8010013e:	75 f0                	jne    80100130 <bread+0x70>
      b->blockno = blockno;
      b->flags = B_BUSY;
	  

	  
      release(&bcache.lock);
80100140:	83 ec 0c             	sub    $0xc,%esp
  // Not cached; recycle some non-busy and clean buffer.
  // "clean" because B_DIRTY and !B_BUSY means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
      b->dev = dev;
80100143:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
80100146:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = B_BUSY;
80100149:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
	  

	  
      release(&bcache.lock);
8010014f:	68 e0 c5 10 80       	push   $0x8010c5e0
80100154:	e8 87 4b 00 00       	call   80104ce0 <release>
80100159:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

    //cprintf("bread dev=%d\n",dev);
  
  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)) {
8010015c:	f6 03 02             	testb  $0x2,(%ebx)
8010015f:	75 0c                	jne    8010016d <bread+0xad>
	iderw(b);
80100161:	83 ec 0c             	sub    $0xc,%esp
80100164:	53                   	push   %ebx
80100165:	e8 e6 1f 00 00       	call   80102150 <iderw>
8010016a:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
8010016d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100170:	89 d8                	mov    %ebx,%eax
80100172:	5b                   	pop    %ebx
80100173:	5e                   	pop    %esi
80100174:	5f                   	pop    %edi
80100175:	5d                   	pop    %ebp
80100176:	c3                   	ret    
      if(!(b->flags & B_BUSY)){
		  

		  
        b->flags |= B_BUSY;
        release(&bcache.lock);
80100177:	83 ec 0c             	sub    $0xc,%esp
    if(b->dev == dev && b->blockno == blockno){
      if(!(b->flags & B_BUSY)){
		  

		  
        b->flags |= B_BUSY;
8010017a:	83 c8 01             	or     $0x1,%eax
8010017d:	89 03                	mov    %eax,(%ebx)
        release(&bcache.lock);
8010017f:	68 e0 c5 10 80       	push   $0x8010c5e0
80100184:	e8 57 4b 00 00       	call   80104ce0 <release>
80100189:	83 c4 10             	add    $0x10,%esp
8010018c:	eb ce                	jmp    8010015c <bread+0x9c>
	  
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
8010018e:	83 ec 0c             	sub    $0xc,%esp
80100191:	68 87 7c 10 80       	push   $0x80107c87
80100196:	e8 b5 01 00 00       	call   80100350 <panic>
8010019b:	90                   	nop
8010019c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	83 ec 08             	sub    $0x8,%esp
801001a6:	8b 55 08             	mov    0x8(%ebp),%edx
  if((b->flags & B_BUSY) == 0)
801001a9:	8b 02                	mov    (%edx),%eax
801001ab:	a8 01                	test   $0x1,%al
801001ad:	74 0e                	je     801001bd <bwrite+0x1d>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001af:	83 c8 04             	or     $0x4,%eax
801001b2:	89 02                	mov    %eax,(%edx)
  iderw(b);
801001b4:	89 55 08             	mov    %edx,0x8(%ebp)
}
801001b7:	c9                   	leave  
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001b8:	e9 93 1f 00 00       	jmp    80102150 <iderw>
// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("bwrite");
801001bd:	83 ec 0c             	sub    $0xc,%esp
801001c0:	68 98 7c 10 80       	push   $0x80107c98
801001c5:	e8 86 01 00 00       	call   80100350 <panic>
801001ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801001d0 <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001d0:	55                   	push   %ebp
801001d1:	89 e5                	mov    %esp,%ebp
801001d3:	53                   	push   %ebx
801001d4:	83 ec 04             	sub    $0x4,%esp
801001d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((b->flags & B_BUSY) == 0)
801001da:	f6 03 01             	testb  $0x1,(%ebx)
801001dd:	74 5a                	je     80100239 <brelse+0x69>
    panic("brelse");

  acquire(&bcache.lock);
801001df:	83 ec 0c             	sub    $0xc,%esp
801001e2:	68 e0 c5 10 80       	push   $0x8010c5e0
801001e7:	e8 14 49 00 00       	call   80104b00 <acquire>

  b->next->prev = b->prev;
801001ec:	8b 43 10             	mov    0x10(%ebx),%eax
801001ef:	8b 53 0c             	mov    0xc(%ebx),%edx
801001f2:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
801001f5:	8b 43 0c             	mov    0xc(%ebx),%eax
801001f8:	8b 53 10             	mov    0x10(%ebx),%edx
801001fb:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
801001fe:	a1 f4 04 11 80       	mov    0x801104f4,%eax
  b->prev = &bcache.head;
80100203:	c7 43 0c e4 04 11 80 	movl   $0x801104e4,0xc(%ebx)

  acquire(&bcache.lock);

  b->next->prev = b->prev;
  b->prev->next = b->next;
  b->next = bcache.head.next;
8010020a:	89 43 10             	mov    %eax,0x10(%ebx)
  b->prev = &bcache.head;
  bcache.head.next->prev = b;
8010020d:	a1 f4 04 11 80       	mov    0x801104f4,%eax
80100212:	89 58 0c             	mov    %ebx,0xc(%eax)
  bcache.head.next = b;
80100215:	89 1d f4 04 11 80    	mov    %ebx,0x801104f4

  b->flags &= ~B_BUSY;
8010021b:	83 23 fe             	andl   $0xfffffffe,(%ebx)
  wakeup(b);
8010021e:	89 1c 24             	mov    %ebx,(%esp)
80100221:	e8 5a 41 00 00       	call   80104380 <wakeup>

  release(&bcache.lock);
80100226:	83 c4 10             	add    $0x10,%esp
80100229:	c7 45 08 e0 c5 10 80 	movl   $0x8010c5e0,0x8(%ebp)
}
80100230:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100233:	c9                   	leave  
  bcache.head.next = b;

  b->flags &= ~B_BUSY;
  wakeup(b);

  release(&bcache.lock);
80100234:	e9 a7 4a 00 00       	jmp    80104ce0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if((b->flags & B_BUSY) == 0)
    panic("brelse");
80100239:	83 ec 0c             	sub    $0xc,%esp
8010023c:	68 9f 7c 10 80       	push   $0x80107c9f
80100241:	e8 0a 01 00 00       	call   80100350 <panic>
80100246:	66 90                	xchg   %ax,%ax
80100248:	66 90                	xchg   %ax,%ax
8010024a:	66 90                	xchg   %ax,%ax
8010024c:	66 90                	xchg   %ax,%ax
8010024e:	66 90                	xchg   %ax,%ax

80100250 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100250:	55                   	push   %ebp
80100251:	89 e5                	mov    %esp,%ebp
80100253:	57                   	push   %edi
80100254:	56                   	push   %esi
80100255:	53                   	push   %ebx
80100256:	83 ec 28             	sub    $0x28,%esp
80100259:	8b 7d 08             	mov    0x8(%ebp),%edi
8010025c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010025f:	57                   	push   %edi
80100260:	e8 2b 15 00 00       	call   80101790 <iunlock>
  target = n;
  acquire(&cons.lock);
80100265:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010026c:	e8 8f 48 00 00       	call   80104b00 <acquire>
  while(n > 0){
80100271:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100274:	83 c4 10             	add    $0x10,%esp
80100277:	31 c0                	xor    %eax,%eax
80100279:	85 db                	test   %ebx,%ebx
8010027b:	0f 8e 9a 00 00 00    	jle    8010031b <consoleread+0xcb>
    while(input.r == input.w){
80100281:	a1 80 07 11 80       	mov    0x80110780,%eax
80100286:	3b 05 84 07 11 80    	cmp    0x80110784,%eax
8010028c:	74 24                	je     801002b2 <consoleread+0x62>
8010028e:	eb 58                	jmp    801002e8 <consoleread+0x98>
      if(proc->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
80100290:	83 ec 08             	sub    $0x8,%esp
80100293:	68 20 b5 10 80       	push   $0x8010b520
80100298:	68 80 07 11 80       	push   $0x80110780
8010029d:	e8 6e 3e 00 00       	call   80104110 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002a2:	a1 80 07 11 80       	mov    0x80110780,%eax
801002a7:	83 c4 10             	add    $0x10,%esp
801002aa:	3b 05 84 07 11 80    	cmp    0x80110784,%eax
801002b0:	75 36                	jne    801002e8 <consoleread+0x98>
      if(proc->killed){
801002b2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801002b8:	8b 40 14             	mov    0x14(%eax),%eax
801002bb:	85 c0                	test   %eax,%eax
801002bd:	74 d1                	je     80100290 <consoleread+0x40>
        release(&cons.lock);
801002bf:	83 ec 0c             	sub    $0xc,%esp
801002c2:	68 20 b5 10 80       	push   $0x8010b520
801002c7:	e8 14 4a 00 00       	call   80104ce0 <release>
        ilock(ip);
801002cc:	89 3c 24             	mov    %edi,(%esp)
801002cf:	e8 ac 13 00 00       	call   80101680 <ilock>
        return -1;
801002d4:	83 c4 10             	add    $0x10,%esp
801002d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002df:	5b                   	pop    %ebx
801002e0:	5e                   	pop    %esi
801002e1:	5f                   	pop    %edi
801002e2:	5d                   	pop    %ebp
801002e3:	c3                   	ret    
801002e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801002e8:	8d 50 01             	lea    0x1(%eax),%edx
801002eb:	89 15 80 07 11 80    	mov    %edx,0x80110780
801002f1:	89 c2                	mov    %eax,%edx
801002f3:	83 e2 7f             	and    $0x7f,%edx
801002f6:	0f be 92 00 07 11 80 	movsbl -0x7feef900(%edx),%edx
    if(c == C('D')){  // EOF
801002fd:	83 fa 04             	cmp    $0x4,%edx
80100300:	74 39                	je     8010033b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100302:	83 c6 01             	add    $0x1,%esi
    --n;
80100305:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100308:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010030b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010030e:	74 35                	je     80100345 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100310:	85 db                	test   %ebx,%ebx
80100312:	0f 85 69 ff ff ff    	jne    80100281 <consoleread+0x31>
80100318:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010031b:	83 ec 0c             	sub    $0xc,%esp
8010031e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100321:	68 20 b5 10 80       	push   $0x8010b520
80100326:	e8 b5 49 00 00       	call   80104ce0 <release>
  ilock(ip);
8010032b:	89 3c 24             	mov    %edi,(%esp)
8010032e:	e8 4d 13 00 00       	call   80101680 <ilock>

  return target - n;
80100333:	83 c4 10             	add    $0x10,%esp
80100336:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100339:	eb a1                	jmp    801002dc <consoleread+0x8c>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010033b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010033e:	76 05                	jbe    80100345 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100340:	a3 80 07 11 80       	mov    %eax,0x80110780
80100345:	8b 45 10             	mov    0x10(%ebp),%eax
80100348:	29 d8                	sub    %ebx,%eax
8010034a:	eb cf                	jmp    8010031b <consoleread+0xcb>
8010034c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100350 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100350:	55                   	push   %ebp
80100351:	89 e5                	mov    %esp,%ebp
80100353:	56                   	push   %esi
80100354:	53                   	push   %ebx
80100355:	83 ec 38             	sub    $0x38,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100358:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
80100359:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
8010035f:	c7 05 54 b5 10 80 00 	movl   $0x0,0x8010b554
80100366:	00 00 00 
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100369:	8d 5d d0             	lea    -0x30(%ebp),%ebx
8010036c:	8d 75 f8             	lea    -0x8(%ebp),%esi
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
8010036f:	0f b6 00             	movzbl (%eax),%eax
80100372:	50                   	push   %eax
80100373:	68 a6 7c 10 80       	push   $0x80107ca6
80100378:	e8 c3 02 00 00       	call   80100640 <cprintf>
  cprintf(s);
8010037d:	58                   	pop    %eax
8010037e:	ff 75 08             	pushl  0x8(%ebp)
80100381:	e8 ba 02 00 00       	call   80100640 <cprintf>
  cprintf("\n");
80100386:	c7 04 24 c6 81 10 80 	movl   $0x801081c6,(%esp)
8010038d:	e8 ae 02 00 00       	call   80100640 <cprintf>
  getcallerpcs(&s, pcs);
80100392:	5a                   	pop    %edx
80100393:	8d 45 08             	lea    0x8(%ebp),%eax
80100396:	59                   	pop    %ecx
80100397:	53                   	push   %ebx
80100398:	50                   	push   %eax
80100399:	e8 32 48 00 00       	call   80104bd0 <getcallerpcs>
8010039e:	83 c4 10             	add    $0x10,%esp
801003a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003a8:	83 ec 08             	sub    $0x8,%esp
801003ab:	ff 33                	pushl  (%ebx)
801003ad:	83 c3 04             	add    $0x4,%ebx
801003b0:	68 c2 7c 10 80       	push   $0x80107cc2
801003b5:	e8 86 02 00 00       	call   80100640 <cprintf>
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003ba:	83 c4 10             	add    $0x10,%esp
801003bd:	39 f3                	cmp    %esi,%ebx
801003bf:	75 e7                	jne    801003a8 <panic+0x58>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003c1:	c7 05 58 b5 10 80 01 	movl   $0x1,0x8010b558
801003c8:	00 00 00 
801003cb:	eb fe                	jmp    801003cb <panic+0x7b>
801003cd:	8d 76 00             	lea    0x0(%esi),%esi

801003d0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003d0:	8b 15 58 b5 10 80    	mov    0x8010b558,%edx
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
801003e8:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
801003eb:	3d 00 01 00 00       	cmp    $0x100,%eax
801003f0:	0f 84 b8 00 00 00    	je     801004ae <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
801003f6:	83 ec 0c             	sub    $0xc,%esp
801003f9:	50                   	push   %eax
801003fa:	e8 61 62 00 00       	call   80106660 <uartputc>
801003ff:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100402:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100407:	b8 0e 00 00 00       	mov    $0xe,%eax
8010040c:	89 fa                	mov    %edi,%edx
8010040e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010040f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100414:	89 f2                	mov    %esi,%edx
80100416:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100417:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010041a:	89 fa                	mov    %edi,%edx
8010041c:	c1 e0 08             	shl    $0x8,%eax
8010041f:	89 c1                	mov    %eax,%ecx
80100421:	b8 0f 00 00 00       	mov    $0xf,%eax
80100426:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100427:	89 f2                	mov    %esi,%edx
80100429:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010042a:	0f b6 c0             	movzbl %al,%eax
8010042d:	09 c8                	or     %ecx,%eax

  if(c == '\n')
8010042f:	83 fb 0a             	cmp    $0xa,%ebx
80100432:	0f 84 0b 01 00 00    	je     80100543 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100438:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010043e:	0f 84 e6 00 00 00    	je     8010052a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100444:	0f b6 d3             	movzbl %bl,%edx
80100447:	8d 78 01             	lea    0x1(%eax),%edi
8010044a:	80 ce 07             	or     $0x7,%dh
8010044d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100454:	80 

  if(pos < 0 || pos > 25*80)
80100455:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010045b:	0f 8f bc 00 00 00    	jg     8010051d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100461:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100467:	7f 6f                	jg     801004d8 <consputc+0x108>
80100469:	89 f8                	mov    %edi,%eax
8010046b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
80100472:	89 fb                	mov    %edi,%ebx
80100474:	c1 e8 08             	shr    $0x8,%eax
80100477:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100479:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010047e:	b8 0e 00 00 00       	mov    $0xe,%eax
80100483:	89 fa                	mov    %edi,%edx
80100485:	ee                   	out    %al,(%dx)
80100486:	ba d5 03 00 00       	mov    $0x3d5,%edx
8010048b:	89 f0                	mov    %esi,%eax
8010048d:	ee                   	out    %al,(%dx)
8010048e:	b8 0f 00 00 00       	mov    $0xf,%eax
80100493:	89 fa                	mov    %edi,%edx
80100495:	ee                   	out    %al,(%dx)
80100496:	ba d5 03 00 00       	mov    $0x3d5,%edx
8010049b:	89 d8                	mov    %ebx,%eax
8010049d:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
8010049e:	b8 20 07 00 00       	mov    $0x720,%eax
801004a3:	66 89 01             	mov    %ax,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004a9:	5b                   	pop    %ebx
801004aa:	5e                   	pop    %esi
801004ab:	5f                   	pop    %edi
801004ac:	5d                   	pop    %ebp
801004ad:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ae:	83 ec 0c             	sub    $0xc,%esp
801004b1:	6a 08                	push   $0x8
801004b3:	e8 a8 61 00 00       	call   80106660 <uartputc>
801004b8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004bf:	e8 9c 61 00 00       	call   80106660 <uartputc>
801004c4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004cb:	e8 90 61 00 00       	call   80106660 <uartputc>
801004d0:	83 c4 10             	add    $0x10,%esp
801004d3:	e9 2a ff ff ff       	jmp    80100402 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004d8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004db:	8d 5f b0             	lea    -0x50(%edi),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004de:	68 60 0e 00 00       	push   $0xe60
801004e3:	68 a0 80 0b 80       	push   $0x800b80a0
801004e8:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004ed:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f4:	e8 e7 48 00 00       	call   80104de0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004f9:	b8 80 07 00 00       	mov    $0x780,%eax
801004fe:	83 c4 0c             	add    $0xc,%esp
80100501:	29 d8                	sub    %ebx,%eax
80100503:	01 c0                	add    %eax,%eax
80100505:	50                   	push   %eax
80100506:	6a 00                	push   $0x0
80100508:	56                   	push   %esi
80100509:	e8 22 48 00 00       	call   80104d30 <memset>
8010050e:	89 f1                	mov    %esi,%ecx
80100510:	83 c4 10             	add    $0x10,%esp
80100513:	be 07 00 00 00       	mov    $0x7,%esi
80100518:	e9 5c ff ff ff       	jmp    80100479 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010051d:	83 ec 0c             	sub    $0xc,%esp
80100520:	68 c6 7c 10 80       	push   $0x80107cc6
80100525:	e8 26 fe ff ff       	call   80100350 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010052a:	85 c0                	test   %eax,%eax
8010052c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010052f:	0f 85 20 ff ff ff    	jne    80100455 <consputc+0x85>
80100535:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010053a:	31 db                	xor    %ebx,%ebx
8010053c:	31 f6                	xor    %esi,%esi
8010053e:	e9 36 ff ff ff       	jmp    80100479 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100543:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100548:	f7 ea                	imul   %edx
8010054a:	89 d0                	mov    %edx,%eax
8010054c:	c1 e8 05             	shr    $0x5,%eax
8010054f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100552:	c1 e0 04             	shl    $0x4,%eax
80100555:	8d 78 50             	lea    0x50(%eax),%edi
80100558:	e9 f8 fe ff ff       	jmp    80100455 <consputc+0x85>
8010055d:	8d 76 00             	lea    0x0(%esi),%esi

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
80100565:	53                   	push   %ebx
80100566:	89 d6                	mov    %edx,%esi
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
8010057c:	78 51                	js     801005cf <printint+0x6f>
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
8010058c:	8d 4f 01             	lea    0x1(%edi),%ecx
8010058f:	f7 f6                	div    %esi
80100591:	0f b6 92 f4 7c 10 80 	movzbl -0x7fef830c(%edx),%edx
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
801005b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
801005b8:	0f be 06             	movsbl (%esi),%eax
801005bb:	83 ee 01             	sub    $0x1,%esi
801005be:	e8 0d fe ff ff       	call   801003d0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005c3:	39 de                	cmp    %ebx,%esi
801005c5:	75 f1                	jne    801005b8 <printint+0x58>
    consputc(buf[i]);
}
801005c7:	83 c4 2c             	add    $0x2c,%esp
801005ca:	5b                   	pop    %ebx
801005cb:	5e                   	pop    %esi
801005cc:	5f                   	pop    %edi
801005cd:	5d                   	pop    %ebp
801005ce:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005cf:	f7 d8                	neg    %eax
801005d1:	eb ab                	jmp    8010057e <printint+0x1e>
801005d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

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
801005e6:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
801005e9:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005ec:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801005ef:	e8 9c 11 00 00       	call   80101790 <iunlock>
  acquire(&cons.lock);
801005f4:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
801005fb:	e8 00 45 00 00       	call   80104b00 <acquire>
80100600:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100603:	83 c4 10             	add    $0x10,%esp
80100606:	85 f6                	test   %esi,%esi
80100608:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010060b:	7e 12                	jle    8010061f <consolewrite+0x3f>
8010060d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100610:	0f b6 07             	movzbl (%edi),%eax
80100613:	83 c7 01             	add    $0x1,%edi
80100616:	e8 b5 fd ff ff       	call   801003d0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010061b:	39 df                	cmp    %ebx,%edi
8010061d:	75 f1                	jne    80100610 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010061f:	83 ec 0c             	sub    $0xc,%esp
80100622:	68 20 b5 10 80       	push   $0x8010b520
80100627:	e8 b4 46 00 00       	call   80104ce0 <release>
  ilock(ip);
8010062c:	58                   	pop    %eax
8010062d:	ff 75 08             	pushl  0x8(%ebp)
80100630:	e8 4b 10 00 00       	call   80101680 <ilock>

  return n;
}
80100635:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100638:	89 f0                	mov    %esi,%eax
8010063a:	5b                   	pop    %ebx
8010063b:	5e                   	pop    %esi
8010063c:	5f                   	pop    %edi
8010063d:	5d                   	pop    %ebp
8010063e:	c3                   	ret    
8010063f:	90                   	nop

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
80100646:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100649:	a1 54 b5 10 80       	mov    0x8010b554,%eax
  if(locking)
8010064e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100650:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100653:	0f 85 47 01 00 00    	jne    801007a0 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100659:	8b 45 08             	mov    0x8(%ebp),%eax
8010065c:	85 c0                	test   %eax,%eax
8010065e:	89 c1                	mov    %eax,%ecx
80100660:	0f 84 4f 01 00 00    	je     801007b5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100666:	0f b6 00             	movzbl (%eax),%eax
80100669:	31 db                	xor    %ebx,%ebx
8010066b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010066e:	89 cf                	mov    %ecx,%edi
80100670:	85 c0                	test   %eax,%eax
80100672:	75 55                	jne    801006c9 <cprintf+0x89>
80100674:	eb 68                	jmp    801006de <cprintf+0x9e>
80100676:	8d 76 00             	lea    0x0(%esi),%esi
80100679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
80100680:	83 c3 01             	add    $0x1,%ebx
80100683:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
80100687:	85 d2                	test   %edx,%edx
80100689:	74 53                	je     801006de <cprintf+0x9e>
      break;
    switch(c){
8010068b:	83 fa 70             	cmp    $0x70,%edx
8010068e:	74 7a                	je     8010070a <cprintf+0xca>
80100690:	7f 6e                	jg     80100700 <cprintf+0xc0>
80100692:	83 fa 25             	cmp    $0x25,%edx
80100695:	0f 84 ad 00 00 00    	je     80100748 <cprintf+0x108>
8010069b:	83 fa 64             	cmp    $0x64,%edx
8010069e:	0f 85 84 00 00 00    	jne    80100728 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
801006a4:	8d 46 04             	lea    0x4(%esi),%eax
801006a7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006ac:	ba 0a 00 00 00       	mov    $0xa,%edx
801006b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006b4:	8b 06                	mov    (%esi),%eax
801006b6:	e8 a5 fe ff ff       	call   80100560 <printint>
801006bb:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006be:	83 c3 01             	add    $0x1,%ebx
801006c1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006c5:	85 c0                	test   %eax,%eax
801006c7:	74 15                	je     801006de <cprintf+0x9e>
    if(c != '%'){
801006c9:	83 f8 25             	cmp    $0x25,%eax
801006cc:	74 b2                	je     80100680 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006ce:	e8 fd fc ff ff       	call   801003d0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006d3:	83 c3 01             	add    $0x1,%ebx
801006d6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006da:	85 c0                	test   %eax,%eax
801006dc:	75 eb                	jne    801006c9 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
801006de:	8b 45 e0             	mov    -0x20(%ebp),%eax
801006e1:	85 c0                	test   %eax,%eax
801006e3:	74 10                	je     801006f5 <cprintf+0xb5>
    release(&cons.lock);
801006e5:	83 ec 0c             	sub    $0xc,%esp
801006e8:	68 20 b5 10 80       	push   $0x8010b520
801006ed:	e8 ee 45 00 00       	call   80104ce0 <release>
801006f2:	83 c4 10             	add    $0x10,%esp
}
801006f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006f8:	5b                   	pop    %ebx
801006f9:	5e                   	pop    %esi
801006fa:	5f                   	pop    %edi
801006fb:	5d                   	pop    %ebp
801006fc:	c3                   	ret    
801006fd:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100700:	83 fa 73             	cmp    $0x73,%edx
80100703:	74 5b                	je     80100760 <cprintf+0x120>
80100705:	83 fa 78             	cmp    $0x78,%edx
80100708:	75 1e                	jne    80100728 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010070a:	8d 46 04             	lea    0x4(%esi),%eax
8010070d:	31 c9                	xor    %ecx,%ecx
8010070f:	ba 10 00 00 00       	mov    $0x10,%edx
80100714:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100717:	8b 06                	mov    (%esi),%eax
80100719:	e8 42 fe ff ff       	call   80100560 <printint>
8010071e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100721:	eb 9b                	jmp    801006be <cprintf+0x7e>
80100723:	90                   	nop
80100724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100728:	b8 25 00 00 00       	mov    $0x25,%eax
8010072d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100730:	e8 9b fc ff ff       	call   801003d0 <consputc>
      consputc(c);
80100735:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100738:	89 d0                	mov    %edx,%eax
8010073a:	e8 91 fc ff ff       	call   801003d0 <consputc>
      break;
8010073f:	e9 7a ff ff ff       	jmp    801006be <cprintf+0x7e>
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	e8 7e fc ff ff       	call   801003d0 <consputc>
80100752:	e9 7c ff ff ff       	jmp    801006d3 <cprintf+0x93>
80100757:	89 f6                	mov    %esi,%esi
80100759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100760:	8d 46 04             	lea    0x4(%esi),%eax
80100763:	8b 36                	mov    (%esi),%esi
80100765:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100768:	b8 d9 7c 10 80       	mov    $0x80107cd9,%eax
8010076d:	85 f6                	test   %esi,%esi
8010076f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
80100772:	0f be 06             	movsbl (%esi),%eax
80100775:	84 c0                	test   %al,%al
80100777:	74 16                	je     8010078f <cprintf+0x14f>
80100779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100780:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
80100783:	e8 48 fc ff ff       	call   801003d0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
80100788:	0f be 06             	movsbl (%esi),%eax
8010078b:	84 c0                	test   %al,%al
8010078d:	75 f1                	jne    80100780 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
8010078f:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80100792:	e9 27 ff ff ff       	jmp    801006be <cprintf+0x7e>
80100797:	89 f6                	mov    %esi,%esi
80100799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007a0:	83 ec 0c             	sub    $0xc,%esp
801007a3:	68 20 b5 10 80       	push   $0x8010b520
801007a8:	e8 53 43 00 00       	call   80104b00 <acquire>
801007ad:	83 c4 10             	add    $0x10,%esp
801007b0:	e9 a4 fe ff ff       	jmp    80100659 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007b5:	83 ec 0c             	sub    $0xc,%esp
801007b8:	68 e0 7c 10 80       	push   $0x80107ce0
801007bd:	e8 8e fb ff ff       	call   80100350 <panic>
801007c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007d0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007d0:	55                   	push   %ebp
801007d1:	89 e5                	mov    %esp,%ebp
801007d3:	57                   	push   %edi
801007d4:	56                   	push   %esi
801007d5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007d6:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007d8:	83 ec 18             	sub    $0x18,%esp
801007db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007de:	68 20 b5 10 80       	push   $0x8010b520
801007e3:	e8 18 43 00 00       	call   80104b00 <acquire>
  while((c = getc()) >= 0){
801007e8:	83 c4 10             	add    $0x10,%esp
801007eb:	90                   	nop
801007ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801007f0:	ff d3                	call   *%ebx
801007f2:	85 c0                	test   %eax,%eax
801007f4:	89 c7                	mov    %eax,%edi
801007f6:	78 48                	js     80100840 <consoleintr+0x70>
    switch(c){
801007f8:	83 ff 10             	cmp    $0x10,%edi
801007fb:	0f 84 3f 01 00 00    	je     80100940 <consoleintr+0x170>
80100801:	7e 5d                	jle    80100860 <consoleintr+0x90>
80100803:	83 ff 15             	cmp    $0x15,%edi
80100806:	0f 84 dc 00 00 00    	je     801008e8 <consoleintr+0x118>
8010080c:	83 ff 7f             	cmp    $0x7f,%edi
8010080f:	75 54                	jne    80100865 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100811:	a1 88 07 11 80       	mov    0x80110788,%eax
80100816:	3b 05 84 07 11 80    	cmp    0x80110784,%eax
8010081c:	74 d2                	je     801007f0 <consoleintr+0x20>
        input.e--;
8010081e:	83 e8 01             	sub    $0x1,%eax
80100821:	a3 88 07 11 80       	mov    %eax,0x80110788
        consputc(BACKSPACE);
80100826:	b8 00 01 00 00       	mov    $0x100,%eax
8010082b:	e8 a0 fb ff ff       	call   801003d0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	79 c0                	jns    801007f8 <consoleintr+0x28>
80100838:	90                   	nop
80100839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100840:	83 ec 0c             	sub    $0xc,%esp
80100843:	68 20 b5 10 80       	push   $0x8010b520
80100848:	e8 93 44 00 00       	call   80104ce0 <release>
  if(doprocdump) {
8010084d:	83 c4 10             	add    $0x10,%esp
80100850:	85 f6                	test   %esi,%esi
80100852:	0f 85 f8 00 00 00    	jne    80100950 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100858:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010085b:	5b                   	pop    %ebx
8010085c:	5e                   	pop    %esi
8010085d:	5f                   	pop    %edi
8010085e:	5d                   	pop    %ebp
8010085f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100860:	83 ff 08             	cmp    $0x8,%edi
80100863:	74 ac                	je     80100811 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100865:	85 ff                	test   %edi,%edi
80100867:	74 87                	je     801007f0 <consoleintr+0x20>
80100869:	a1 88 07 11 80       	mov    0x80110788,%eax
8010086e:	89 c2                	mov    %eax,%edx
80100870:	2b 15 80 07 11 80    	sub    0x80110780,%edx
80100876:	83 fa 7f             	cmp    $0x7f,%edx
80100879:	0f 87 71 ff ff ff    	ja     801007f0 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010087f:	8d 50 01             	lea    0x1(%eax),%edx
80100882:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100885:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100888:	89 15 88 07 11 80    	mov    %edx,0x80110788
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
8010088e:	0f 84 c8 00 00 00    	je     8010095c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
80100894:	89 f9                	mov    %edi,%ecx
80100896:	88 88 00 07 11 80    	mov    %cl,-0x7feef900(%eax)
        consputc(c);
8010089c:	89 f8                	mov    %edi,%eax
8010089e:	e8 2d fb ff ff       	call   801003d0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008a3:	83 ff 0a             	cmp    $0xa,%edi
801008a6:	0f 84 c1 00 00 00    	je     8010096d <consoleintr+0x19d>
801008ac:	83 ff 04             	cmp    $0x4,%edi
801008af:	0f 84 b8 00 00 00    	je     8010096d <consoleintr+0x19d>
801008b5:	a1 80 07 11 80       	mov    0x80110780,%eax
801008ba:	83 e8 80             	sub    $0xffffff80,%eax
801008bd:	39 05 88 07 11 80    	cmp    %eax,0x80110788
801008c3:	0f 85 27 ff ff ff    	jne    801007f0 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008c9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008cc:	a3 84 07 11 80       	mov    %eax,0x80110784
          wakeup(&input.r);
801008d1:	68 80 07 11 80       	push   $0x80110780
801008d6:	e8 a5 3a 00 00       	call   80104380 <wakeup>
801008db:	83 c4 10             	add    $0x10,%esp
801008de:	e9 0d ff ff ff       	jmp    801007f0 <consoleintr+0x20>
801008e3:	90                   	nop
801008e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801008e8:	a1 88 07 11 80       	mov    0x80110788,%eax
801008ed:	39 05 84 07 11 80    	cmp    %eax,0x80110784
801008f3:	75 2b                	jne    80100920 <consoleintr+0x150>
801008f5:	e9 f6 fe ff ff       	jmp    801007f0 <consoleintr+0x20>
801008fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100900:	a3 88 07 11 80       	mov    %eax,0x80110788
        consputc(BACKSPACE);
80100905:	b8 00 01 00 00       	mov    $0x100,%eax
8010090a:	e8 c1 fa ff ff       	call   801003d0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010090f:	a1 88 07 11 80       	mov    0x80110788,%eax
80100914:	3b 05 84 07 11 80    	cmp    0x80110784,%eax
8010091a:	0f 84 d0 fe ff ff    	je     801007f0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100920:	83 e8 01             	sub    $0x1,%eax
80100923:	89 c2                	mov    %eax,%edx
80100925:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100928:	80 ba 00 07 11 80 0a 	cmpb   $0xa,-0x7feef900(%edx)
8010092f:	75 cf                	jne    80100900 <consoleintr+0x130>
80100931:	e9 ba fe ff ff       	jmp    801007f0 <consoleintr+0x20>
80100936:	8d 76 00             	lea    0x0(%esi),%esi
80100939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100940:	be 01 00 00 00       	mov    $0x1,%esi
80100945:	e9 a6 fe ff ff       	jmp    801007f0 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100950:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100953:	5b                   	pop    %ebx
80100954:	5e                   	pop    %esi
80100955:	5f                   	pop    %edi
80100956:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100957:	e9 b4 3b 00 00       	jmp    80104510 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010095c:	c6 80 00 07 11 80 0a 	movb   $0xa,-0x7feef900(%eax)
        consputc(c);
80100963:	b8 0a 00 00 00       	mov    $0xa,%eax
80100968:	e8 63 fa ff ff       	call   801003d0 <consputc>
8010096d:	a1 88 07 11 80       	mov    0x80110788,%eax
80100972:	e9 52 ff ff ff       	jmp    801008c9 <consoleintr+0xf9>
80100977:	89 f6                	mov    %esi,%esi
80100979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100980 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100980:	55                   	push   %ebp
80100981:	89 e5                	mov    %esp,%ebp
80100983:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100986:	68 e9 7c 10 80       	push   $0x80107ce9
8010098b:	68 20 b5 10 80       	push   $0x8010b520
80100990:	e8 4b 41 00 00       	call   80104ae0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
80100995:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
8010099c:	c7 05 4c 11 11 80 e0 	movl   $0x801005e0,0x8011114c
801009a3:	05 10 80 
  devsw[CONSOLE].read = consoleread;
801009a6:	c7 05 48 11 11 80 50 	movl   $0x80100250,0x80111148
801009ad:	02 10 80 
  cons.locking = 1;
801009b0:	c7 05 54 b5 10 80 01 	movl   $0x1,0x8010b554
801009b7:	00 00 00 

  picenable(IRQ_KBD);
801009ba:	e8 41 29 00 00       	call   80103300 <picenable>
  ioapicenable(IRQ_KBD, 0);
801009bf:	58                   	pop    %eax
801009c0:	5a                   	pop    %edx
801009c1:	6a 00                	push   $0x0
801009c3:	6a 01                	push   $0x1
801009c5:	e8 36 19 00 00       	call   80102300 <ioapicenable>
}
801009ca:	83 c4 10             	add    $0x10,%esp
801009cd:	c9                   	leave  
801009ce:	c3                   	ret    
801009cf:	90                   	nop

801009d0 <kill_others>:
#include "proc.h"
#include "defs.h"
#include "elf.h"

void 
kill_others() {
801009d0:	55                   	push   %ebp
801009d1:	89 e5                	mov    %esp,%ebp
801009d3:	53                   	push   %ebx
801009d4:	83 ec 10             	sub    $0x10,%esp
  struct thread *t;
  acquire(&proc->lock);
801009d7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801009dd:	05 6c 02 00 00       	add    $0x26c,%eax
801009e2:	50                   	push   %eax
801009e3:	e8 18 41 00 00       	call   80104b00 <acquire>

  for(t = proc->threads; t < &proc->threads[NTHREAD]; t++) {
801009e8:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801009ef:	65 8b 0d 08 00 00 00 	mov    %gs:0x8,%ecx
801009f6:	83 c4 10             	add    $0x10,%esp
801009f9:	8d 42 6c             	lea    0x6c(%edx),%eax
801009fc:	81 c2 6c 02 00 00    	add    $0x26c,%edx
80100a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(t->tid != thread->tid 
80100a08:	8b 19                	mov    (%ecx),%ebx
80100a0a:	39 18                	cmp    %ebx,(%eax)
80100a0c:	74 10                	je     80100a1e <kill_others+0x4e>
        && t->state != TRUNNING && t->state != TUNUSED) {
80100a0e:	f7 40 04 fb ff ff ff 	testl  $0xfffffffb,0x4(%eax)
80100a15:	74 07                	je     80100a1e <kill_others+0x4e>
      t->state = TZOMBIE;
80100a17:	c7 40 04 05 00 00 00 	movl   $0x5,0x4(%eax)
void 
kill_others() {
  struct thread *t;
  acquire(&proc->lock);

  for(t = proc->threads; t < &proc->threads[NTHREAD]; t++) {
80100a1e:	83 c0 20             	add    $0x20,%eax
80100a21:	39 d0                	cmp    %edx,%eax
80100a23:	72 e3                	jb     80100a08 <kill_others+0x38>
        && t->state != TRUNNING && t->state != TUNUSED) {
      t->state = TZOMBIE;
    }
  }

  release(&proc->lock);
80100a25:	83 ec 0c             	sub    $0xc,%esp
80100a28:	52                   	push   %edx
80100a29:	e8 b2 42 00 00       	call   80104ce0 <release>
}
80100a2e:	83 c4 10             	add    $0x10,%esp
80100a31:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100a34:	c9                   	leave  
80100a35:	c3                   	ret    
80100a36:	8d 76 00             	lea    0x0(%esi),%esi
80100a39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100a40 <exec>:

int
exec(char *path, char **argv)
{
80100a40:	55                   	push   %ebp
80100a41:	89 e5                	mov    %esp,%ebp
80100a43:	57                   	push   %edi
80100a44:	56                   	push   %esi
80100a45:	53                   	push   %ebx
80100a46:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
80100a4c:	e8 df 21 00 00       	call   80102c30 <begin_op>
  if((ip = namei(path)) == 0){
80100a51:	83 ec 0c             	sub    $0xc,%esp
80100a54:	ff 75 08             	pushl  0x8(%ebp)
80100a57:	e8 b4 14 00 00       	call   80101f10 <namei>
80100a5c:	83 c4 10             	add    $0x10,%esp
80100a5f:	85 c0                	test   %eax,%eax
80100a61:	0f 84 a3 01 00 00    	je     80100c0a <exec+0x1ca>
    end_op();
    return -1;
  }
  ilock(ip);
80100a67:	83 ec 0c             	sub    $0xc,%esp
80100a6a:	89 c3                	mov    %eax,%ebx
80100a6c:	50                   	push   %eax
80100a6d:	e8 0e 0c 00 00       	call   80101680 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100a72:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a78:	6a 34                	push   $0x34
80100a7a:	6a 00                	push   $0x0
80100a7c:	50                   	push   %eax
80100a7d:	53                   	push   %ebx
80100a7e:	e8 1d 0f 00 00       	call   801019a0 <readi>
80100a83:	83 c4 20             	add    $0x20,%esp
80100a86:	83 f8 33             	cmp    $0x33,%eax
80100a89:	77 25                	ja     80100ab0 <exec+0x70>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a8b:	83 ec 0c             	sub    $0xc,%esp
80100a8e:	53                   	push   %ebx
80100a8f:	e8 bc 0e 00 00       	call   80101950 <iunlockput>
    end_op();
80100a94:	e8 07 22 00 00       	call   80102ca0 <end_op>
80100a99:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100aa1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100aa4:	5b                   	pop    %ebx
80100aa5:	5e                   	pop    %esi
80100aa6:	5f                   	pop    %edi
80100aa7:	5d                   	pop    %ebp
80100aa8:	c3                   	ret    
80100aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100ab0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100ab7:	45 4c 46 
80100aba:	75 cf                	jne    80100a8b <exec+0x4b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100abc:	e8 df 68 00 00       	call   801073a0 <setupkvm>
80100ac1:	85 c0                	test   %eax,%eax
80100ac3:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100ac9:	74 c0                	je     80100a8b <exec+0x4b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100acb:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100ad2:	00 
80100ad3:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100ad9:	0f 84 a6 02 00 00    	je     80100d85 <exec+0x345>
80100adf:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100ae6:	00 00 00 
80100ae9:	31 ff                	xor    %edi,%edi
80100aeb:	eb 18                	jmp    80100b05 <exec+0xc5>
80100aed:	8d 76 00             	lea    0x0(%esi),%esi
80100af0:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100af7:	83 c7 01             	add    $0x1,%edi
80100afa:	83 c6 20             	add    $0x20,%esi
80100afd:	39 f8                	cmp    %edi,%eax
80100aff:	0f 8e ab 00 00 00    	jle    80100bb0 <exec+0x170>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b05:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b0b:	6a 20                	push   $0x20
80100b0d:	56                   	push   %esi
80100b0e:	50                   	push   %eax
80100b0f:	53                   	push   %ebx
80100b10:	e8 8b 0e 00 00       	call   801019a0 <readi>
80100b15:	83 c4 10             	add    $0x10,%esp
80100b18:	83 f8 20             	cmp    $0x20,%eax
80100b1b:	75 7b                	jne    80100b98 <exec+0x158>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100b1d:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b24:	75 ca                	jne    80100af0 <exec+0xb0>
      continue;
    if(ph.memsz < ph.filesz)
80100b26:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b2c:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b32:	72 64                	jb     80100b98 <exec+0x158>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b34:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b3a:	72 5c                	jb     80100b98 <exec+0x158>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b3c:	83 ec 04             	sub    $0x4,%esp
80100b3f:	50                   	push   %eax
80100b40:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b46:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b4c:	e8 df 6b 00 00       	call   80107730 <allocuvm>
80100b51:	83 c4 10             	add    $0x10,%esp
80100b54:	85 c0                	test   %eax,%eax
80100b56:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b5c:	74 3a                	je     80100b98 <exec+0x158>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b5e:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b64:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b69:	75 2d                	jne    80100b98 <exec+0x158>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b6b:	83 ec 0c             	sub    $0xc,%esp
80100b6e:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b74:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b7a:	53                   	push   %ebx
80100b7b:	50                   	push   %eax
80100b7c:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b82:	e8 e9 69 00 00       	call   80107570 <loaduvm>
80100b87:	83 c4 20             	add    $0x20,%esp
80100b8a:	85 c0                	test   %eax,%eax
80100b8c:	0f 89 5e ff ff ff    	jns    80100af0 <exec+0xb0>
80100b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b98:	83 ec 0c             	sub    $0xc,%esp
80100b9b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ba1:	e8 9a 6c 00 00       	call   80107840 <freevm>
80100ba6:	83 c4 10             	add    $0x10,%esp
80100ba9:	e9 dd fe ff ff       	jmp    80100a8b <exec+0x4b>
80100bae:	66 90                	xchg   %ax,%ax
80100bb0:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100bb6:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100bbc:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80100bc2:	8d be 00 20 00 00    	lea    0x2000(%esi),%edi
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100bc8:	83 ec 0c             	sub    $0xc,%esp
80100bcb:	53                   	push   %ebx
80100bcc:	e8 7f 0d 00 00       	call   80101950 <iunlockput>
  end_op();
80100bd1:	e8 ca 20 00 00       	call   80102ca0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100bd6:	83 c4 0c             	add    $0xc,%esp
80100bd9:	57                   	push   %edi
80100bda:	56                   	push   %esi
80100bdb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100be1:	e8 4a 6b 00 00       	call   80107730 <allocuvm>
80100be6:	83 c4 10             	add    $0x10,%esp
80100be9:	85 c0                	test   %eax,%eax
80100beb:	89 c6                	mov    %eax,%esi
80100bed:	75 2a                	jne    80100c19 <exec+0x1d9>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100bef:	83 ec 0c             	sub    $0xc,%esp
80100bf2:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bf8:	e8 43 6c 00 00       	call   80107840 <freevm>
80100bfd:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100c00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c05:	e9 97 fe ff ff       	jmp    80100aa1 <exec+0x61>
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
  if((ip = namei(path)) == 0){
    end_op();
80100c0a:	e8 91 20 00 00       	call   80102ca0 <end_op>
    return -1;
80100c0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c14:	e9 88 fe ff ff       	jmp    80100aa1 <exec+0x61>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c19:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100c1f:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c22:	31 ff                	xor    %edi,%edi
80100c24:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c26:	50                   	push   %eax
80100c27:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100c2d:	e8 ae 6c 00 00       	call   801078e0 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c32:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c35:	83 c4 10             	add    $0x10,%esp
80100c38:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c3e:	8b 00                	mov    (%eax),%eax
80100c40:	85 c0                	test   %eax,%eax
80100c42:	74 71                	je     80100cb5 <exec+0x275>
80100c44:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100c4a:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100c50:	eb 0b                	jmp    80100c5d <exec+0x21d>
80100c52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(argc >= MAXARG)
80100c58:	83 ff 20             	cmp    $0x20,%edi
80100c5b:	74 92                	je     80100bef <exec+0x1af>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c5d:	83 ec 0c             	sub    $0xc,%esp
80100c60:	50                   	push   %eax
80100c61:	e8 0a 43 00 00       	call   80104f70 <strlen>
80100c66:	f7 d0                	not    %eax
80100c68:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c6a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c6d:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c6e:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c71:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c74:	e8 f7 42 00 00       	call   80104f70 <strlen>
80100c79:	83 c0 01             	add    $0x1,%eax
80100c7c:	50                   	push   %eax
80100c7d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c80:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c83:	53                   	push   %ebx
80100c84:	56                   	push   %esi
80100c85:	e8 c6 6d 00 00       	call   80107a50 <copyout>
80100c8a:	83 c4 20             	add    $0x20,%esp
80100c8d:	85 c0                	test   %eax,%eax
80100c8f:	0f 88 5a ff ff ff    	js     80100bef <exec+0x1af>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c95:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c98:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c9f:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100ca2:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100ca8:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100cab:	85 c0                	test   %eax,%eax
80100cad:	75 a9                	jne    80100c58 <exec+0x218>
80100caf:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb5:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100cbc:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100cbe:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100cc5:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100cc9:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100cd0:	ff ff ff 
  ustack[1] = argc;
80100cd3:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cd9:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100cdb:	83 c0 0c             	add    $0xc,%eax
80100cde:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ce0:	50                   	push   %eax
80100ce1:	52                   	push   %edx
80100ce2:	53                   	push   %ebx
80100ce3:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ce9:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cef:	e8 5c 6d 00 00       	call   80107a50 <copyout>
80100cf4:	83 c4 10             	add    $0x10,%esp
80100cf7:	85 c0                	test   %eax,%eax
80100cf9:	0f 88 f0 fe ff ff    	js     80100bef <exec+0x1af>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cff:	8b 45 08             	mov    0x8(%ebp),%eax
80100d02:	0f b6 10             	movzbl (%eax),%edx
80100d05:	84 d2                	test   %dl,%dl
80100d07:	74 1a                	je     80100d23 <exec+0x2e3>
80100d09:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100d0c:	83 c0 01             	add    $0x1,%eax
80100d0f:	90                   	nop
    if(*s == '/')
      last = s+1;
80100d10:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100d13:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100d16:	0f 44 c8             	cmove  %eax,%ecx
80100d19:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100d1c:	84 d2                	test   %dl,%dl
80100d1e:	75 f0                	jne    80100d10 <exec+0x2d0>
80100d20:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100d23:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100d29:	83 ec 04             	sub    $0x4,%esp
80100d2c:	6a 10                	push   $0x10
80100d2e:	ff 75 08             	pushl  0x8(%ebp)
80100d31:	83 c0 5c             	add    $0x5c,%eax
80100d34:	50                   	push   %eax
80100d35:	e8 f6 41 00 00       	call   80104f30 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100d3a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  proc->pgdir = pgdir;
80100d40:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100d46:	8b 78 04             	mov    0x4(%eax),%edi
  proc->pgdir = pgdir;
  proc->sz = sz;
80100d49:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
  proc->pgdir = pgdir;
80100d4b:	89 48 04             	mov    %ecx,0x4(%eax)
  proc->sz = sz;
  thread->tf->eip = elf.entry;  // main
80100d4e:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80100d54:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100d5a:	8b 50 10             	mov    0x10(%eax),%edx
80100d5d:	89 4a 38             	mov    %ecx,0x38(%edx)
  thread->tf->esp = sp;
80100d60:	8b 40 10             	mov    0x10(%eax),%eax
80100d63:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(proc);
80100d66:	58                   	pop    %eax
80100d67:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
80100d6e:	e8 dd 66 00 00       	call   80107450 <switchuvm>
  freevm(oldpgdir);
80100d73:	89 3c 24             	mov    %edi,(%esp)
80100d76:	e8 c5 6a 00 00       	call   80107840 <freevm>
  return 0;
80100d7b:	83 c4 10             	add    $0x10,%esp
80100d7e:	31 c0                	xor    %eax,%eax
80100d80:	e9 1c fd ff ff       	jmp    80100aa1 <exec+0x61>
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d85:	bf 00 20 00 00       	mov    $0x2000,%edi
80100d8a:	31 f6                	xor    %esi,%esi
80100d8c:	e9 37 fe ff ff       	jmp    80100bc8 <exec+0x188>
80100d91:	66 90                	xchg   %ax,%ax
80100d93:	66 90                	xchg   %ax,%ax
80100d95:	66 90                	xchg   %ax,%ax
80100d97:	66 90                	xchg   %ax,%ax
80100d99:	66 90                	xchg   %ax,%ax
80100d9b:	66 90                	xchg   %ax,%ax
80100d9d:	66 90                	xchg   %ax,%ax
80100d9f:	90                   	nop

80100da0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100da0:	55                   	push   %ebp
80100da1:	89 e5                	mov    %esp,%ebp
80100da3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100da6:	68 05 7d 10 80       	push   $0x80107d05
80100dab:	68 a0 07 11 80       	push   $0x801107a0
80100db0:	e8 2b 3d 00 00       	call   80104ae0 <initlock>
}
80100db5:	83 c4 10             	add    $0x10,%esp
80100db8:	c9                   	leave  
80100db9:	c3                   	ret    
80100dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100dc0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100dc0:	55                   	push   %ebp
80100dc1:	89 e5                	mov    %esp,%ebp
80100dc3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100dc4:	bb d4 07 11 80       	mov    $0x801107d4,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100dc9:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100dcc:	68 a0 07 11 80       	push   $0x801107a0
80100dd1:	e8 2a 3d 00 00       	call   80104b00 <acquire>
80100dd6:	83 c4 10             	add    $0x10,%esp
80100dd9:	eb 10                	jmp    80100deb <filealloc+0x2b>
80100ddb:	90                   	nop
80100ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100de0:	83 c3 18             	add    $0x18,%ebx
80100de3:	81 fb 34 11 11 80    	cmp    $0x80111134,%ebx
80100de9:	74 25                	je     80100e10 <filealloc+0x50>
    if(f->ref == 0){
80100deb:	8b 43 04             	mov    0x4(%ebx),%eax
80100dee:	85 c0                	test   %eax,%eax
80100df0:	75 ee                	jne    80100de0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100df2:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100df5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dfc:	68 a0 07 11 80       	push   $0x801107a0
80100e01:	e8 da 3e 00 00       	call   80104ce0 <release>
      return f;
80100e06:	89 d8                	mov    %ebx,%eax
80100e08:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e0b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e0e:	c9                   	leave  
80100e0f:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100e10:	83 ec 0c             	sub    $0xc,%esp
80100e13:	68 a0 07 11 80       	push   $0x801107a0
80100e18:	e8 c3 3e 00 00       	call   80104ce0 <release>
  return 0;
80100e1d:	83 c4 10             	add    $0x10,%esp
80100e20:	31 c0                	xor    %eax,%eax
}
80100e22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e25:	c9                   	leave  
80100e26:	c3                   	ret    
80100e27:	89 f6                	mov    %esi,%esi
80100e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e30 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	53                   	push   %ebx
80100e34:	83 ec 10             	sub    $0x10,%esp
80100e37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e3a:	68 a0 07 11 80       	push   $0x801107a0
80100e3f:	e8 bc 3c 00 00       	call   80104b00 <acquire>
  if(f->ref < 1)
80100e44:	8b 43 04             	mov    0x4(%ebx),%eax
80100e47:	83 c4 10             	add    $0x10,%esp
80100e4a:	85 c0                	test   %eax,%eax
80100e4c:	7e 1a                	jle    80100e68 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e4e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e51:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100e54:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e57:	68 a0 07 11 80       	push   $0x801107a0
80100e5c:	e8 7f 3e 00 00       	call   80104ce0 <release>
  return f;
}
80100e61:	89 d8                	mov    %ebx,%eax
80100e63:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e66:	c9                   	leave  
80100e67:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100e68:	83 ec 0c             	sub    $0xc,%esp
80100e6b:	68 0c 7d 10 80       	push   $0x80107d0c
80100e70:	e8 db f4 ff ff       	call   80100350 <panic>
80100e75:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e80 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e80:	55                   	push   %ebp
80100e81:	89 e5                	mov    %esp,%ebp
80100e83:	57                   	push   %edi
80100e84:	56                   	push   %esi
80100e85:	53                   	push   %ebx
80100e86:	83 ec 28             	sub    $0x28,%esp
80100e89:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e8c:	68 a0 07 11 80       	push   $0x801107a0
80100e91:	e8 6a 3c 00 00       	call   80104b00 <acquire>
  if(f->ref < 1)
80100e96:	8b 47 04             	mov    0x4(%edi),%eax
80100e99:	83 c4 10             	add    $0x10,%esp
80100e9c:	85 c0                	test   %eax,%eax
80100e9e:	0f 8e 9b 00 00 00    	jle    80100f3f <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100ea4:	83 e8 01             	sub    $0x1,%eax
80100ea7:	85 c0                	test   %eax,%eax
80100ea9:	89 47 04             	mov    %eax,0x4(%edi)
80100eac:	74 1a                	je     80100ec8 <fileclose+0x48>
    release(&ftable.lock);
80100eae:	c7 45 08 a0 07 11 80 	movl   $0x801107a0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100eb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100eb8:	5b                   	pop    %ebx
80100eb9:	5e                   	pop    %esi
80100eba:	5f                   	pop    %edi
80100ebb:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100ebc:	e9 1f 3e 00 00       	jmp    80104ce0 <release>
80100ec1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100ec8:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100ecc:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100ece:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100ed1:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100ed4:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100eda:	88 45 e7             	mov    %al,-0x19(%ebp)
80100edd:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100ee0:	68 a0 07 11 80       	push   $0x801107a0
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100ee5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100ee8:	e8 f3 3d 00 00       	call   80104ce0 <release>

  if(ff.type == FD_PIPE)
80100eed:	83 c4 10             	add    $0x10,%esp
80100ef0:	83 fb 01             	cmp    $0x1,%ebx
80100ef3:	74 13                	je     80100f08 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100ef5:	83 fb 02             	cmp    $0x2,%ebx
80100ef8:	74 26                	je     80100f20 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100efa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100efd:	5b                   	pop    %ebx
80100efe:	5e                   	pop    %esi
80100eff:	5f                   	pop    %edi
80100f00:	5d                   	pop    %ebp
80100f01:	c3                   	ret    
80100f02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100f08:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100f0c:	83 ec 08             	sub    $0x8,%esp
80100f0f:	53                   	push   %ebx
80100f10:	56                   	push   %esi
80100f11:	e8 ba 25 00 00       	call   801034d0 <pipeclose>
80100f16:	83 c4 10             	add    $0x10,%esp
80100f19:	eb df                	jmp    80100efa <fileclose+0x7a>
80100f1b:	90                   	nop
80100f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100f20:	e8 0b 1d 00 00       	call   80102c30 <begin_op>
    iput(ff.ip);
80100f25:	83 ec 0c             	sub    $0xc,%esp
80100f28:	ff 75 e0             	pushl  -0x20(%ebp)
80100f2b:	e8 c0 08 00 00       	call   801017f0 <iput>
    end_op();
80100f30:	83 c4 10             	add    $0x10,%esp
  }
}
80100f33:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f36:	5b                   	pop    %ebx
80100f37:	5e                   	pop    %esi
80100f38:	5f                   	pop    %edi
80100f39:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100f3a:	e9 61 1d 00 00       	jmp    80102ca0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100f3f:	83 ec 0c             	sub    $0xc,%esp
80100f42:	68 14 7d 10 80       	push   $0x80107d14
80100f47:	e8 04 f4 ff ff       	call   80100350 <panic>
80100f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f50 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	53                   	push   %ebx
80100f54:	83 ec 04             	sub    $0x4,%esp
80100f57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f5a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f5d:	75 31                	jne    80100f90 <filestat+0x40>
    ilock(f->ip);
80100f5f:	83 ec 0c             	sub    $0xc,%esp
80100f62:	ff 73 10             	pushl  0x10(%ebx)
80100f65:	e8 16 07 00 00       	call   80101680 <ilock>
    stati(f->ip, st);
80100f6a:	58                   	pop    %eax
80100f6b:	5a                   	pop    %edx
80100f6c:	ff 75 0c             	pushl  0xc(%ebp)
80100f6f:	ff 73 10             	pushl  0x10(%ebx)
80100f72:	e8 f9 09 00 00       	call   80101970 <stati>
    iunlock(f->ip);
80100f77:	59                   	pop    %ecx
80100f78:	ff 73 10             	pushl  0x10(%ebx)
80100f7b:	e8 10 08 00 00       	call   80101790 <iunlock>
    return 0;
80100f80:	83 c4 10             	add    $0x10,%esp
80100f83:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f85:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f88:	c9                   	leave  
80100f89:	c3                   	ret    
80100f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f95:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f98:	c9                   	leave  
80100f99:	c3                   	ret    
80100f9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100fa0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100fa0:	55                   	push   %ebp
80100fa1:	89 e5                	mov    %esp,%ebp
80100fa3:	57                   	push   %edi
80100fa4:	56                   	push   %esi
80100fa5:	53                   	push   %ebx
80100fa6:	83 ec 0c             	sub    $0xc,%esp
80100fa9:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100fac:	8b 75 0c             	mov    0xc(%ebp),%esi
80100faf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100fb2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100fb6:	74 60                	je     80101018 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100fb8:	8b 03                	mov    (%ebx),%eax
80100fba:	83 f8 01             	cmp    $0x1,%eax
80100fbd:	74 41                	je     80101000 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100fbf:	83 f8 02             	cmp    $0x2,%eax
80100fc2:	75 5b                	jne    8010101f <fileread+0x7f>
    ilock(f->ip);
80100fc4:	83 ec 0c             	sub    $0xc,%esp
80100fc7:	ff 73 10             	pushl  0x10(%ebx)
80100fca:	e8 b1 06 00 00       	call   80101680 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fcf:	57                   	push   %edi
80100fd0:	ff 73 14             	pushl  0x14(%ebx)
80100fd3:	56                   	push   %esi
80100fd4:	ff 73 10             	pushl  0x10(%ebx)
80100fd7:	e8 c4 09 00 00       	call   801019a0 <readi>
80100fdc:	83 c4 20             	add    $0x20,%esp
80100fdf:	85 c0                	test   %eax,%eax
80100fe1:	89 c6                	mov    %eax,%esi
80100fe3:	7e 03                	jle    80100fe8 <fileread+0x48>
      f->off += r;
80100fe5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fe8:	83 ec 0c             	sub    $0xc,%esp
80100feb:	ff 73 10             	pushl  0x10(%ebx)
80100fee:	e8 9d 07 00 00       	call   80101790 <iunlock>
    return r;
80100ff3:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100ff6:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100ff8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ffb:	5b                   	pop    %ebx
80100ffc:	5e                   	pop    %esi
80100ffd:	5f                   	pop    %edi
80100ffe:	5d                   	pop    %ebp
80100fff:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80101000:	8b 43 0c             	mov    0xc(%ebx),%eax
80101003:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80101006:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101009:	5b                   	pop    %ebx
8010100a:	5e                   	pop    %esi
8010100b:	5f                   	pop    %edi
8010100c:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
8010100d:	e9 8e 26 00 00       	jmp    801036a0 <piperead>
80101012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80101018:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010101d:	eb d9                	jmp    80100ff8 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
8010101f:	83 ec 0c             	sub    $0xc,%esp
80101022:	68 1e 7d 10 80       	push   $0x80107d1e
80101027:	e8 24 f3 ff ff       	call   80100350 <panic>
8010102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101030 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101030:	55                   	push   %ebp
80101031:	89 e5                	mov    %esp,%ebp
80101033:	57                   	push   %edi
80101034:	56                   	push   %esi
80101035:	53                   	push   %ebx
80101036:	83 ec 1c             	sub    $0x1c,%esp
80101039:	8b 75 08             	mov    0x8(%ebp),%esi
8010103c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
8010103f:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101043:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101046:	8b 45 10             	mov    0x10(%ebp),%eax
80101049:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
8010104c:	0f 84 aa 00 00 00    	je     801010fc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101052:	8b 06                	mov    (%esi),%eax
80101054:	83 f8 01             	cmp    $0x1,%eax
80101057:	0f 84 c2 00 00 00    	je     8010111f <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010105d:	83 f8 02             	cmp    $0x2,%eax
80101060:	0f 85 d8 00 00 00    	jne    8010113e <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101066:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101069:	31 ff                	xor    %edi,%edi
8010106b:	85 c0                	test   %eax,%eax
8010106d:	7f 34                	jg     801010a3 <filewrite+0x73>
8010106f:	e9 9c 00 00 00       	jmp    80101110 <filewrite+0xe0>
80101074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101078:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101081:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101084:	e8 07 07 00 00       	call   80101790 <iunlock>
      end_op();
80101089:	e8 12 1c 00 00       	call   80102ca0 <end_op>
8010108e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101091:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101094:	39 d8                	cmp    %ebx,%eax
80101096:	0f 85 95 00 00 00    	jne    80101131 <filewrite+0x101>
        panic("short filewrite");
      i += r;
8010109c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010109e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010a1:	7e 6d                	jle    80101110 <filewrite+0xe0>
      int n1 = n - i;
801010a3:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801010a6:	b8 00 1a 00 00       	mov    $0x1a00,%eax
801010ab:	29 fb                	sub    %edi,%ebx
801010ad:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
801010b3:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
801010b6:	e8 75 1b 00 00       	call   80102c30 <begin_op>
      ilock(f->ip);
801010bb:	83 ec 0c             	sub    $0xc,%esp
801010be:	ff 76 10             	pushl  0x10(%esi)
801010c1:	e8 ba 05 00 00       	call   80101680 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801010c6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010c9:	53                   	push   %ebx
801010ca:	ff 76 14             	pushl  0x14(%esi)
801010cd:	01 f8                	add    %edi,%eax
801010cf:	50                   	push   %eax
801010d0:	ff 76 10             	pushl  0x10(%esi)
801010d3:	e8 c8 09 00 00       	call   80101aa0 <writei>
801010d8:	83 c4 20             	add    $0x20,%esp
801010db:	85 c0                	test   %eax,%eax
801010dd:	7f 99                	jg     80101078 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
801010df:	83 ec 0c             	sub    $0xc,%esp
801010e2:	ff 76 10             	pushl  0x10(%esi)
801010e5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010e8:	e8 a3 06 00 00       	call   80101790 <iunlock>
      end_op();
801010ed:	e8 ae 1b 00 00       	call   80102ca0 <end_op>

      if(r < 0)
801010f2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010f5:	83 c4 10             	add    $0x10,%esp
801010f8:	85 c0                	test   %eax,%eax
801010fa:	74 98                	je     80101094 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101104:	5b                   	pop    %ebx
80101105:	5e                   	pop    %esi
80101106:	5f                   	pop    %edi
80101107:	5d                   	pop    %ebp
80101108:	c3                   	ret    
80101109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
80101110:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101113:	75 e7                	jne    801010fc <filewrite+0xcc>
  }
  panic("filewrite");
}
80101115:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101118:	89 f8                	mov    %edi,%eax
8010111a:	5b                   	pop    %ebx
8010111b:	5e                   	pop    %esi
8010111c:	5f                   	pop    %edi
8010111d:	5d                   	pop    %ebp
8010111e:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010111f:	8b 46 0c             	mov    0xc(%esi),%eax
80101122:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
80101125:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101128:	5b                   	pop    %ebx
80101129:	5e                   	pop    %esi
8010112a:	5f                   	pop    %edi
8010112b:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
8010112c:	e9 3f 24 00 00       	jmp    80103570 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
80101131:	83 ec 0c             	sub    $0xc,%esp
80101134:	68 27 7d 10 80       	push   $0x80107d27
80101139:	e8 12 f2 ff ff       	call   80100350 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
8010113e:	83 ec 0c             	sub    $0xc,%esp
80101141:	68 2d 7d 10 80       	push   $0x80107d2d
80101146:	e8 05 f2 ff ff       	call   80100350 <panic>
8010114b:	66 90                	xchg   %ax,%ax
8010114d:	66 90                	xchg   %ax,%ax
8010114f:	90                   	nop

80101150 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101150:	55                   	push   %ebp
80101151:	89 e5                	mov    %esp,%ebp
80101153:	57                   	push   %edi
80101154:	56                   	push   %esi
80101155:	53                   	push   %ebx
80101156:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101159:	8b 0d a0 11 11 80    	mov    0x801111a0,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010115f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101162:	85 c9                	test   %ecx,%ecx
80101164:	0f 84 85 00 00 00    	je     801011ef <balloc+0x9f>
8010116a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101171:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101174:	83 ec 08             	sub    $0x8,%esp
80101177:	89 f0                	mov    %esi,%eax
80101179:	c1 f8 0c             	sar    $0xc,%eax
8010117c:	03 05 b8 11 11 80    	add    0x801111b8,%eax
80101182:	50                   	push   %eax
80101183:	ff 75 d8             	pushl  -0x28(%ebp)
80101186:	e8 35 ef ff ff       	call   801000c0 <bread>
8010118b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010118e:	a1 a0 11 11 80       	mov    0x801111a0,%eax
80101193:	83 c4 10             	add    $0x10,%esp
80101196:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101199:	31 c0                	xor    %eax,%eax
8010119b:	eb 2d                	jmp    801011ca <balloc+0x7a>
8010119d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801011a0:	89 c1                	mov    %eax,%ecx
801011a2:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011a7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
801011aa:	83 e1 07             	and    $0x7,%ecx
801011ad:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011af:	89 c1                	mov    %eax,%ecx
801011b1:	c1 f9 03             	sar    $0x3,%ecx
801011b4:	0f b6 7c 0b 18       	movzbl 0x18(%ebx,%ecx,1),%edi
801011b9:	85 d7                	test   %edx,%edi
801011bb:	74 43                	je     80101200 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011bd:	83 c0 01             	add    $0x1,%eax
801011c0:	83 c6 01             	add    $0x1,%esi
801011c3:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011c8:	74 05                	je     801011cf <balloc+0x7f>
801011ca:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801011cd:	72 d1                	jb     801011a0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801011cf:	83 ec 0c             	sub    $0xc,%esp
801011d2:	ff 75 e4             	pushl  -0x1c(%ebp)
801011d5:	e8 f6 ef ff ff       	call   801001d0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011da:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011e1:	83 c4 10             	add    $0x10,%esp
801011e4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011e7:	39 05 a0 11 11 80    	cmp    %eax,0x801111a0
801011ed:	77 82                	ja     80101171 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801011ef:	83 ec 0c             	sub    $0xc,%esp
801011f2:	68 37 7d 10 80       	push   $0x80107d37
801011f7:	e8 54 f1 ff ff       	call   80100350 <panic>
801011fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101200:	09 fa                	or     %edi,%edx
80101202:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101205:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101208:	88 54 0f 18          	mov    %dl,0x18(%edi,%ecx,1)
        log_write(bp);
8010120c:	57                   	push   %edi
8010120d:	e8 fe 1b 00 00       	call   80102e10 <log_write>
        brelse(bp);
80101212:	89 3c 24             	mov    %edi,(%esp)
80101215:	e8 b6 ef ff ff       	call   801001d0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
8010121a:	58                   	pop    %eax
8010121b:	5a                   	pop    %edx
8010121c:	56                   	push   %esi
8010121d:	ff 75 d8             	pushl  -0x28(%ebp)
80101220:	e8 9b ee ff ff       	call   801000c0 <bread>
80101225:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101227:	8d 40 18             	lea    0x18(%eax),%eax
8010122a:	83 c4 0c             	add    $0xc,%esp
8010122d:	68 00 02 00 00       	push   $0x200
80101232:	6a 00                	push   $0x0
80101234:	50                   	push   %eax
80101235:	e8 f6 3a 00 00       	call   80104d30 <memset>
  log_write(bp);
8010123a:	89 1c 24             	mov    %ebx,(%esp)
8010123d:	e8 ce 1b 00 00       	call   80102e10 <log_write>
  brelse(bp);
80101242:	89 1c 24             	mov    %ebx,(%esp)
80101245:	e8 86 ef ff ff       	call   801001d0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
8010124a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010124d:	89 f0                	mov    %esi,%eax
8010124f:	5b                   	pop    %ebx
80101250:	5e                   	pop    %esi
80101251:	5f                   	pop    %edi
80101252:	5d                   	pop    %ebp
80101253:	c3                   	ret    
80101254:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010125a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101260 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101260:	55                   	push   %ebp
80101261:	89 e5                	mov    %esp,%ebp
80101263:	57                   	push   %edi
80101264:	56                   	push   %esi
80101265:	53                   	push   %ebx
80101266:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101268:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010126a:	bb f4 11 11 80       	mov    $0x801111f4,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
8010126f:	83 ec 28             	sub    $0x28,%esp
80101272:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101275:	68 c0 11 11 80       	push   $0x801111c0
8010127a:	e8 81 38 00 00       	call   80104b00 <acquire>
8010127f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101282:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101285:	eb 18                	jmp    8010129f <iget+0x3f>
80101287:	89 f6                	mov    %esi,%esi
80101289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101290:	85 f6                	test   %esi,%esi
80101292:	74 44                	je     801012d8 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101294:	83 c3 50             	add    $0x50,%ebx
80101297:	81 fb 94 21 11 80    	cmp    $0x80112194,%ebx
8010129d:	74 51                	je     801012f0 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010129f:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012a2:	85 c9                	test   %ecx,%ecx
801012a4:	7e ea                	jle    80101290 <iget+0x30>
801012a6:	39 3b                	cmp    %edi,(%ebx)
801012a8:	75 e6                	jne    80101290 <iget+0x30>
801012aa:	39 53 04             	cmp    %edx,0x4(%ebx)
801012ad:	75 e1                	jne    80101290 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
801012af:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
801012b2:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
801012b5:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
801012b7:	68 c0 11 11 80       	push   $0x801111c0

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
801012bc:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012bf:	e8 1c 3a 00 00       	call   80104ce0 <release>
      return ip;
801012c4:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
801012c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ca:	89 f0                	mov    %esi,%eax
801012cc:	5b                   	pop    %ebx
801012cd:	5e                   	pop    %esi
801012ce:	5f                   	pop    %edi
801012cf:	5d                   	pop    %ebp
801012d0:	c3                   	ret    
801012d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012d8:	85 c9                	test   %ecx,%ecx
801012da:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012dd:	83 c3 50             	add    $0x50,%ebx
801012e0:	81 fb 94 21 11 80    	cmp    $0x80112194,%ebx
801012e6:	75 b7                	jne    8010129f <iget+0x3f>
801012e8:	90                   	nop
801012e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801012f0:	85 f6                	test   %esi,%esi
801012f2:	74 2d                	je     80101321 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
801012f4:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
801012f7:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012f9:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012fc:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
80101303:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
  release(&icache.lock);
8010130a:	68 c0 11 11 80       	push   $0x801111c0
8010130f:	e8 cc 39 00 00       	call   80104ce0 <release>

  return ip;
80101314:	83 c4 10             	add    $0x10,%esp
}
80101317:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010131a:	89 f0                	mov    %esi,%eax
8010131c:	5b                   	pop    %ebx
8010131d:	5e                   	pop    %esi
8010131e:	5f                   	pop    %edi
8010131f:	5d                   	pop    %ebp
80101320:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
80101321:	83 ec 0c             	sub    $0xc,%esp
80101324:	68 4d 7d 10 80       	push   $0x80107d4d
80101329:	e8 22 f0 ff ff       	call   80100350 <panic>
8010132e:	66 90                	xchg   %ax,%ax

80101330 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101330:	55                   	push   %ebp
80101331:	89 e5                	mov    %esp,%ebp
80101333:	57                   	push   %edi
80101334:	56                   	push   %esi
80101335:	53                   	push   %ebx
80101336:	89 c6                	mov    %eax,%esi
80101338:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010133b:	83 fa 0b             	cmp    $0xb,%edx
8010133e:	77 18                	ja     80101358 <bmap+0x28>
80101340:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
80101343:	8b 43 1c             	mov    0x1c(%ebx),%eax
80101346:	85 c0                	test   %eax,%eax
80101348:	74 6e                	je     801013b8 <bmap+0x88>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010134a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010134d:	5b                   	pop    %ebx
8010134e:	5e                   	pop    %esi
8010134f:	5f                   	pop    %edi
80101350:	5d                   	pop    %ebp
80101351:	c3                   	ret    
80101352:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101358:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
8010135b:	83 fb 7f             	cmp    $0x7f,%ebx
8010135e:	77 7c                	ja     801013dc <bmap+0xac>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101360:	8b 40 4c             	mov    0x4c(%eax),%eax
80101363:	85 c0                	test   %eax,%eax
80101365:	74 69                	je     801013d0 <bmap+0xa0>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101367:	83 ec 08             	sub    $0x8,%esp
8010136a:	50                   	push   %eax
8010136b:	ff 36                	pushl  (%esi)
8010136d:	e8 4e ed ff ff       	call   801000c0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101372:	8d 54 98 18          	lea    0x18(%eax,%ebx,4),%edx
80101376:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101379:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
8010137b:	8b 1a                	mov    (%edx),%ebx
8010137d:	85 db                	test   %ebx,%ebx
8010137f:	75 1d                	jne    8010139e <bmap+0x6e>
      a[bn] = addr = balloc(ip->dev);
80101381:	8b 06                	mov    (%esi),%eax
80101383:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101386:	e8 c5 fd ff ff       	call   80101150 <balloc>
8010138b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
8010138e:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80101391:	89 c3                	mov    %eax,%ebx
80101393:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101395:	57                   	push   %edi
80101396:	e8 75 1a 00 00       	call   80102e10 <log_write>
8010139b:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
8010139e:	83 ec 0c             	sub    $0xc,%esp
801013a1:	57                   	push   %edi
801013a2:	e8 29 ee ff ff       	call   801001d0 <brelse>
801013a7:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801013aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801013ad:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
801013af:	5b                   	pop    %ebx
801013b0:	5e                   	pop    %esi
801013b1:	5f                   	pop    %edi
801013b2:	5d                   	pop    %ebp
801013b3:	c3                   	ret    
801013b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
801013b8:	8b 06                	mov    (%esi),%eax
801013ba:	e8 91 fd ff ff       	call   80101150 <balloc>
801013bf:	89 43 1c             	mov    %eax,0x1c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801013c2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013c5:	5b                   	pop    %ebx
801013c6:	5e                   	pop    %esi
801013c7:	5f                   	pop    %edi
801013c8:	5d                   	pop    %ebp
801013c9:	c3                   	ret    
801013ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013d0:	8b 06                	mov    (%esi),%eax
801013d2:	e8 79 fd ff ff       	call   80101150 <balloc>
801013d7:	89 46 4c             	mov    %eax,0x4c(%esi)
801013da:	eb 8b                	jmp    80101367 <bmap+0x37>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
801013dc:	83 ec 0c             	sub    $0xc,%esp
801013df:	68 5d 7d 10 80       	push   $0x80107d5d
801013e4:	e8 67 ef ff ff       	call   80100350 <panic>
801013e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801013f0 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801013f0:	55                   	push   %ebp
801013f1:	89 e5                	mov    %esp,%ebp
801013f3:	56                   	push   %esi
801013f4:	53                   	push   %ebx
801013f5:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
801013f8:	83 ec 08             	sub    $0x8,%esp
801013fb:	6a 01                	push   $0x1
801013fd:	ff 75 08             	pushl  0x8(%ebp)
80101400:	e8 bb ec ff ff       	call   801000c0 <bread>
80101405:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101407:	8d 40 18             	lea    0x18(%eax),%eax
8010140a:	83 c4 0c             	add    $0xc,%esp
8010140d:	6a 1c                	push   $0x1c
8010140f:	50                   	push   %eax
80101410:	56                   	push   %esi
80101411:	e8 ca 39 00 00       	call   80104de0 <memmove>
  brelse(bp);
80101416:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101419:	83 c4 10             	add    $0x10,%esp
}
8010141c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010141f:	5b                   	pop    %ebx
80101420:	5e                   	pop    %esi
80101421:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
80101422:	e9 a9 ed ff ff       	jmp    801001d0 <brelse>
80101427:	89 f6                	mov    %esi,%esi
80101429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101430 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101430:	55                   	push   %ebp
80101431:	89 e5                	mov    %esp,%ebp
80101433:	56                   	push   %esi
80101434:	53                   	push   %ebx
80101435:	89 d3                	mov    %edx,%ebx
80101437:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
80101439:	83 ec 08             	sub    $0x8,%esp
8010143c:	68 a0 11 11 80       	push   $0x801111a0
80101441:	50                   	push   %eax
80101442:	e8 a9 ff ff ff       	call   801013f0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101447:	58                   	pop    %eax
80101448:	5a                   	pop    %edx
80101449:	89 da                	mov    %ebx,%edx
8010144b:	c1 ea 0c             	shr    $0xc,%edx
8010144e:	03 15 b8 11 11 80    	add    0x801111b8,%edx
80101454:	52                   	push   %edx
80101455:	56                   	push   %esi
80101456:	e8 65 ec ff ff       	call   801000c0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010145b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010145d:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101463:	ba 01 00 00 00       	mov    $0x1,%edx
80101468:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010146b:	c1 fb 03             	sar    $0x3,%ebx
8010146e:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101471:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101473:	0f b6 4c 18 18       	movzbl 0x18(%eax,%ebx,1),%ecx
80101478:	85 d1                	test   %edx,%ecx
8010147a:	74 27                	je     801014a3 <bfree+0x73>
8010147c:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010147e:	f7 d2                	not    %edx
80101480:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80101482:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101485:	21 d0                	and    %edx,%eax
80101487:	88 44 1e 18          	mov    %al,0x18(%esi,%ebx,1)
  log_write(bp);
8010148b:	56                   	push   %esi
8010148c:	e8 7f 19 00 00       	call   80102e10 <log_write>
  brelse(bp);
80101491:	89 34 24             	mov    %esi,(%esp)
80101494:	e8 37 ed ff ff       	call   801001d0 <brelse>
}
80101499:	83 c4 10             	add    $0x10,%esp
8010149c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010149f:	5b                   	pop    %ebx
801014a0:	5e                   	pop    %esi
801014a1:	5d                   	pop    %ebp
801014a2:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
801014a3:	83 ec 0c             	sub    $0xc,%esp
801014a6:	68 70 7d 10 80       	push   $0x80107d70
801014ab:	e8 a0 ee ff ff       	call   80100350 <panic>

801014b0 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801014b0:	55                   	push   %ebp
801014b1:	89 e5                	mov    %esp,%ebp
801014b3:	83 ec 10             	sub    $0x10,%esp
  initlock(&icache.lock, "icache");
801014b6:	68 83 7d 10 80       	push   $0x80107d83
801014bb:	68 c0 11 11 80       	push   $0x801111c0
801014c0:	e8 1b 36 00 00       	call   80104ae0 <initlock>
  readsb(dev, &sb);
801014c5:	58                   	pop    %eax
801014c6:	5a                   	pop    %edx
801014c7:	68 a0 11 11 80       	push   $0x801111a0
801014cc:	ff 75 08             	pushl  0x8(%ebp)
801014cf:	e8 1c ff ff ff       	call   801013f0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014d4:	ff 35 b8 11 11 80    	pushl  0x801111b8
801014da:	ff 35 b4 11 11 80    	pushl  0x801111b4
801014e0:	ff 35 b0 11 11 80    	pushl  0x801111b0
801014e6:	ff 35 ac 11 11 80    	pushl  0x801111ac
801014ec:	ff 35 a8 11 11 80    	pushl  0x801111a8
801014f2:	ff 35 a4 11 11 80    	pushl  0x801111a4
801014f8:	ff 35 a0 11 11 80    	pushl  0x801111a0
801014fe:	68 e4 7d 10 80       	push   $0x80107de4
80101503:	e8 38 f1 ff ff       	call   80100640 <cprintf>
          inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80101508:	83 c4 30             	add    $0x30,%esp
8010150b:	c9                   	leave  
8010150c:	c3                   	ret    
8010150d:	8d 76 00             	lea    0x0(%esi),%esi

80101510 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101510:	55                   	push   %ebp
80101511:	89 e5                	mov    %esp,%ebp
80101513:	57                   	push   %edi
80101514:	56                   	push   %esi
80101515:	53                   	push   %ebx
80101516:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101519:	83 3d a8 11 11 80 01 	cmpl   $0x1,0x801111a8
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101520:	8b 45 0c             	mov    0xc(%ebp),%eax
80101523:	8b 75 08             	mov    0x8(%ebp),%esi
80101526:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101529:	0f 86 91 00 00 00    	jbe    801015c0 <ialloc+0xb0>
8010152f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101534:	eb 21                	jmp    80101557 <ialloc+0x47>
80101536:	8d 76 00             	lea    0x0(%esi),%esi
80101539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101540:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101543:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101546:	57                   	push   %edi
80101547:	e8 84 ec ff ff       	call   801001d0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010154c:	83 c4 10             	add    $0x10,%esp
8010154f:	39 1d a8 11 11 80    	cmp    %ebx,0x801111a8
80101555:	76 69                	jbe    801015c0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101557:	89 d8                	mov    %ebx,%eax
80101559:	83 ec 08             	sub    $0x8,%esp
8010155c:	c1 e8 03             	shr    $0x3,%eax
8010155f:	03 05 b4 11 11 80    	add    0x801111b4,%eax
80101565:	50                   	push   %eax
80101566:	56                   	push   %esi
80101567:	e8 54 eb ff ff       	call   801000c0 <bread>
8010156c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010156e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101570:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101573:	83 e0 07             	and    $0x7,%eax
80101576:	c1 e0 06             	shl    $0x6,%eax
80101579:	8d 4c 07 18          	lea    0x18(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010157d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101581:	75 bd                	jne    80101540 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101583:	83 ec 04             	sub    $0x4,%esp
80101586:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101589:	6a 40                	push   $0x40
8010158b:	6a 00                	push   $0x0
8010158d:	51                   	push   %ecx
8010158e:	e8 9d 37 00 00       	call   80104d30 <memset>
      dip->type = type;
80101593:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101597:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010159a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010159d:	89 3c 24             	mov    %edi,(%esp)
801015a0:	e8 6b 18 00 00       	call   80102e10 <log_write>
      brelse(bp);
801015a5:	89 3c 24             	mov    %edi,(%esp)
801015a8:	e8 23 ec ff ff       	call   801001d0 <brelse>
      return iget(dev, inum);
801015ad:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015b3:	89 da                	mov    %ebx,%edx
801015b5:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015b7:	5b                   	pop    %ebx
801015b8:	5e                   	pop    %esi
801015b9:	5f                   	pop    %edi
801015ba:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015bb:	e9 a0 fc ff ff       	jmp    80101260 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801015c0:	83 ec 0c             	sub    $0xc,%esp
801015c3:	68 8a 7d 10 80       	push   $0x80107d8a
801015c8:	e8 83 ed ff ff       	call   80100350 <panic>
801015cd:	8d 76 00             	lea    0x0(%esi),%esi

801015d0 <iupdate>:
}

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
801015d0:	55                   	push   %ebp
801015d1:	89 e5                	mov    %esp,%ebp
801015d3:	56                   	push   %esi
801015d4:	53                   	push   %ebx
801015d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015d8:	83 ec 08             	sub    $0x8,%esp
801015db:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015de:	83 c3 1c             	add    $0x1c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015e1:	c1 e8 03             	shr    $0x3,%eax
801015e4:	03 05 b4 11 11 80    	add    0x801111b4,%eax
801015ea:	50                   	push   %eax
801015eb:	ff 73 e4             	pushl  -0x1c(%ebx)
801015ee:	e8 cd ea ff ff       	call   801000c0 <bread>
801015f3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015f5:	8b 43 e8             	mov    -0x18(%ebx),%eax
  dip->type = ip->type;
801015f8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015fc:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015ff:	83 e0 07             	and    $0x7,%eax
80101602:	c1 e0 06             	shl    $0x6,%eax
80101605:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
  dip->type = ip->type;
80101609:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010160c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101610:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
80101613:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101617:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010161b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010161f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101623:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101627:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010162a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162d:	6a 34                	push   $0x34
8010162f:	53                   	push   %ebx
80101630:	50                   	push   %eax
80101631:	e8 aa 37 00 00       	call   80104de0 <memmove>
  log_write(bp);
80101636:	89 34 24             	mov    %esi,(%esp)
80101639:	e8 d2 17 00 00       	call   80102e10 <log_write>
  brelse(bp);
8010163e:	89 75 08             	mov    %esi,0x8(%ebp)
80101641:	83 c4 10             	add    $0x10,%esp
}
80101644:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101647:	5b                   	pop    %ebx
80101648:	5e                   	pop    %esi
80101649:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010164a:	e9 81 eb ff ff       	jmp    801001d0 <brelse>
8010164f:	90                   	nop

80101650 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	53                   	push   %ebx
80101654:	83 ec 10             	sub    $0x10,%esp
80101657:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010165a:	68 c0 11 11 80       	push   $0x801111c0
8010165f:	e8 9c 34 00 00       	call   80104b00 <acquire>
  ip->ref++;
80101664:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101668:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
8010166f:	e8 6c 36 00 00       	call   80104ce0 <release>
  return ip;
}
80101674:	89 d8                	mov    %ebx,%eax
80101676:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101679:	c9                   	leave  
8010167a:	c3                   	ret    
8010167b:	90                   	nop
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	56                   	push   %esi
80101684:	53                   	push   %ebx
80101685:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101688:	85 db                	test   %ebx,%ebx
8010168a:	0f 84 f0 00 00 00    	je     80101780 <ilock+0x100>
80101690:	8b 43 08             	mov    0x8(%ebx),%eax
80101693:	85 c0                	test   %eax,%eax
80101695:	0f 8e e5 00 00 00    	jle    80101780 <ilock+0x100>
    panic("ilock");

  acquire(&icache.lock);
8010169b:	83 ec 0c             	sub    $0xc,%esp
8010169e:	68 c0 11 11 80       	push   $0x801111c0
801016a3:	e8 58 34 00 00       	call   80104b00 <acquire>
  while(ip->flags & I_BUSY)
801016a8:	8b 43 0c             	mov    0xc(%ebx),%eax
801016ab:	83 c4 10             	add    $0x10,%esp
801016ae:	a8 01                	test   $0x1,%al
801016b0:	74 1e                	je     801016d0 <ilock+0x50>
801016b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sleep(ip, &icache.lock);
801016b8:	83 ec 08             	sub    $0x8,%esp
801016bb:	68 c0 11 11 80       	push   $0x801111c0
801016c0:	53                   	push   %ebx
801016c1:	e8 4a 2a 00 00       	call   80104110 <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
801016c6:	8b 43 0c             	mov    0xc(%ebx),%eax
801016c9:	83 c4 10             	add    $0x10,%esp
801016cc:	a8 01                	test   $0x1,%al
801016ce:	75 e8                	jne    801016b8 <ilock+0x38>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);
801016d0:	83 ec 0c             	sub    $0xc,%esp
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
801016d3:	83 c8 01             	or     $0x1,%eax
801016d6:	89 43 0c             	mov    %eax,0xc(%ebx)
  release(&icache.lock);
801016d9:	68 c0 11 11 80       	push   $0x801111c0
801016de:	e8 fd 35 00 00       	call   80104ce0 <release>

  if(!(ip->flags & I_VALID)){
801016e3:	83 c4 10             	add    $0x10,%esp
801016e6:	f6 43 0c 02          	testb  $0x2,0xc(%ebx)
801016ea:	74 0c                	je     801016f8 <ilock+0x78>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
801016ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016ef:	5b                   	pop    %ebx
801016f0:	5e                   	pop    %esi
801016f1:	5d                   	pop    %ebp
801016f2:	c3                   	ret    
801016f3:	90                   	nop
801016f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016f8:	8b 43 04             	mov    0x4(%ebx),%eax
801016fb:	83 ec 08             	sub    $0x8,%esp
801016fe:	c1 e8 03             	shr    $0x3,%eax
80101701:	03 05 b4 11 11 80    	add    0x801111b4,%eax
80101707:	50                   	push   %eax
80101708:	ff 33                	pushl  (%ebx)
8010170a:	e8 b1 e9 ff ff       	call   801000c0 <bread>
8010170f:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101711:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101714:	83 c4 0c             	add    $0xc,%esp
  ip->flags |= I_BUSY;
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101717:	83 e0 07             	and    $0x7,%eax
8010171a:	c1 e0 06             	shl    $0x6,%eax
8010171d:	8d 44 06 18          	lea    0x18(%esi,%eax,1),%eax
    ip->type = dip->type;
80101721:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101724:	83 c0 0c             	add    $0xc,%eax
  release(&icache.lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
80101727:	66 89 53 10          	mov    %dx,0x10(%ebx)
    ip->major = dip->major;
8010172b:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
8010172f:	66 89 53 12          	mov    %dx,0x12(%ebx)
    ip->minor = dip->minor;
80101733:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101737:	66 89 53 14          	mov    %dx,0x14(%ebx)
    ip->nlink = dip->nlink;
8010173b:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
8010173f:	66 89 53 16          	mov    %dx,0x16(%ebx)
    ip->size = dip->size;
80101743:	8b 50 fc             	mov    -0x4(%eax),%edx
80101746:	89 53 18             	mov    %edx,0x18(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101749:	6a 34                	push   $0x34
8010174b:	50                   	push   %eax
8010174c:	8d 43 1c             	lea    0x1c(%ebx),%eax
8010174f:	50                   	push   %eax
80101750:	e8 8b 36 00 00       	call   80104de0 <memmove>
    brelse(bp);
80101755:	89 34 24             	mov    %esi,(%esp)
80101758:	e8 73 ea ff ff       	call   801001d0 <brelse>
    ip->flags |= I_VALID;
8010175d:	83 4b 0c 02          	orl    $0x2,0xc(%ebx)
    if(ip->type == 0)
80101761:	83 c4 10             	add    $0x10,%esp
80101764:	66 83 7b 10 00       	cmpw   $0x0,0x10(%ebx)
80101769:	75 81                	jne    801016ec <ilock+0x6c>
      panic("ilock: no type");
8010176b:	83 ec 0c             	sub    $0xc,%esp
8010176e:	68 a2 7d 10 80       	push   $0x80107da2
80101773:	e8 d8 eb ff ff       	call   80100350 <panic>
80101778:	90                   	nop
80101779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101780:	83 ec 0c             	sub    $0xc,%esp
80101783:	68 9c 7d 10 80       	push   $0x80107d9c
80101788:	e8 c3 eb ff ff       	call   80100350 <panic>
8010178d:	8d 76 00             	lea    0x0(%esi),%esi

80101790 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	53                   	push   %ebx
80101794:	83 ec 04             	sub    $0x4,%esp
80101797:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
8010179a:	85 db                	test   %ebx,%ebx
8010179c:	74 39                	je     801017d7 <iunlock+0x47>
8010179e:	f6 43 0c 01          	testb  $0x1,0xc(%ebx)
801017a2:	74 33                	je     801017d7 <iunlock+0x47>
801017a4:	8b 43 08             	mov    0x8(%ebx),%eax
801017a7:	85 c0                	test   %eax,%eax
801017a9:	7e 2c                	jle    801017d7 <iunlock+0x47>
    panic("iunlock");

  acquire(&icache.lock);
801017ab:	83 ec 0c             	sub    $0xc,%esp
801017ae:	68 c0 11 11 80       	push   $0x801111c0
801017b3:	e8 48 33 00 00       	call   80104b00 <acquire>
  ip->flags &= ~I_BUSY;
801017b8:	83 63 0c fe          	andl   $0xfffffffe,0xc(%ebx)
  wakeup(ip);
801017bc:	89 1c 24             	mov    %ebx,(%esp)
801017bf:	e8 bc 2b 00 00       	call   80104380 <wakeup>
  release(&icache.lock);
801017c4:	83 c4 10             	add    $0x10,%esp
801017c7:	c7 45 08 c0 11 11 80 	movl   $0x801111c0,0x8(%ebp)
}
801017ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801017d1:	c9                   	leave  
    panic("iunlock");

  acquire(&icache.lock);
  ip->flags &= ~I_BUSY;
  wakeup(ip);
  release(&icache.lock);
801017d2:	e9 09 35 00 00       	jmp    80104ce0 <release>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
    panic("iunlock");
801017d7:	83 ec 0c             	sub    $0xc,%esp
801017da:	68 b1 7d 10 80       	push   $0x80107db1
801017df:	e8 6c eb ff ff       	call   80100350 <panic>
801017e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801017ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801017f0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	57                   	push   %edi
801017f4:	56                   	push   %esi
801017f5:	53                   	push   %ebx
801017f6:	83 ec 28             	sub    $0x28,%esp
801017f9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
801017fc:	68 c0 11 11 80       	push   $0x801111c0
80101801:	e8 fa 32 00 00       	call   80104b00 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101806:	8b 46 08             	mov    0x8(%esi),%eax
80101809:	83 c4 10             	add    $0x10,%esp
8010180c:	83 f8 01             	cmp    $0x1,%eax
8010180f:	0f 85 ab 00 00 00    	jne    801018c0 <iput+0xd0>
80101815:	8b 56 0c             	mov    0xc(%esi),%edx
80101818:	f6 c2 02             	test   $0x2,%dl
8010181b:	0f 84 9f 00 00 00    	je     801018c0 <iput+0xd0>
80101821:	66 83 7e 16 00       	cmpw   $0x0,0x16(%esi)
80101826:	0f 85 94 00 00 00    	jne    801018c0 <iput+0xd0>
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
8010182c:	f6 c2 01             	test   $0x1,%dl
8010182f:	0f 85 05 01 00 00    	jne    8010193a <iput+0x14a>
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
80101835:	83 ec 0c             	sub    $0xc,%esp
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
80101838:	83 ca 01             	or     $0x1,%edx
8010183b:	8d 5e 1c             	lea    0x1c(%esi),%ebx
8010183e:	89 56 0c             	mov    %edx,0xc(%esi)
    release(&icache.lock);
80101841:	68 c0 11 11 80       	push   $0x801111c0
80101846:	8d 7e 4c             	lea    0x4c(%esi),%edi
80101849:	e8 92 34 00 00       	call   80104ce0 <release>
8010184e:	83 c4 10             	add    $0x10,%esp
80101851:	eb 0c                	jmp    8010185f <iput+0x6f>
80101853:	90                   	nop
80101854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101858:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
8010185b:	39 fb                	cmp    %edi,%ebx
8010185d:	74 1b                	je     8010187a <iput+0x8a>
    if(ip->addrs[i]){
8010185f:	8b 13                	mov    (%ebx),%edx
80101861:	85 d2                	test   %edx,%edx
80101863:	74 f3                	je     80101858 <iput+0x68>
      bfree(ip->dev, ip->addrs[i]);
80101865:	8b 06                	mov    (%esi),%eax
80101867:	83 c3 04             	add    $0x4,%ebx
8010186a:	e8 c1 fb ff ff       	call   80101430 <bfree>
      ip->addrs[i] = 0;
8010186f:	c7 43 fc 00 00 00 00 	movl   $0x0,-0x4(%ebx)
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101876:	39 fb                	cmp    %edi,%ebx
80101878:	75 e5                	jne    8010185f <iput+0x6f>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
8010187a:	8b 46 4c             	mov    0x4c(%esi),%eax
8010187d:	85 c0                	test   %eax,%eax
8010187f:	75 5f                	jne    801018e0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101881:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
80101884:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
  iupdate(ip);
8010188b:	56                   	push   %esi
8010188c:	e8 3f fd ff ff       	call   801015d0 <iupdate>
    if(ip->flags & I_BUSY)
      panic("iput busy");
    ip->flags |= I_BUSY;
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
80101891:	31 c0                	xor    %eax,%eax
80101893:	66 89 46 10          	mov    %ax,0x10(%esi)
    iupdate(ip);
80101897:	89 34 24             	mov    %esi,(%esp)
8010189a:	e8 31 fd ff ff       	call   801015d0 <iupdate>
    acquire(&icache.lock);
8010189f:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
801018a6:	e8 55 32 00 00       	call   80104b00 <acquire>
    ip->flags = 0;
801018ab:	c7 46 0c 00 00 00 00 	movl   $0x0,0xc(%esi)
    wakeup(ip);
801018b2:	89 34 24             	mov    %esi,(%esp)
801018b5:	e8 c6 2a 00 00       	call   80104380 <wakeup>
801018ba:	8b 46 08             	mov    0x8(%esi),%eax
801018bd:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
801018c0:	83 e8 01             	sub    $0x1,%eax
801018c3:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
801018c6:	c7 45 08 c0 11 11 80 	movl   $0x801111c0,0x8(%ebp)
}
801018cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018d0:	5b                   	pop    %ebx
801018d1:	5e                   	pop    %esi
801018d2:	5f                   	pop    %edi
801018d3:	5d                   	pop    %ebp
    acquire(&icache.lock);
    ip->flags = 0;
    wakeup(ip);
  }
  ip->ref--;
  release(&icache.lock);
801018d4:	e9 07 34 00 00       	jmp    80104ce0 <release>
801018d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018e0:	83 ec 08             	sub    $0x8,%esp
801018e3:	50                   	push   %eax
801018e4:	ff 36                	pushl  (%esi)
801018e6:	e8 d5 e7 ff ff       	call   801000c0 <bread>
801018eb:	83 c4 10             	add    $0x10,%esp
801018ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018f1:	8d 58 18             	lea    0x18(%eax),%ebx
801018f4:	8d b8 18 02 00 00    	lea    0x218(%eax),%edi
801018fa:	eb 0b                	jmp    80101907 <iput+0x117>
801018fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101900:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
80101903:	39 df                	cmp    %ebx,%edi
80101905:	74 0f                	je     80101916 <iput+0x126>
      if(a[j])
80101907:	8b 13                	mov    (%ebx),%edx
80101909:	85 d2                	test   %edx,%edx
8010190b:	74 f3                	je     80101900 <iput+0x110>
        bfree(ip->dev, a[j]);
8010190d:	8b 06                	mov    (%esi),%eax
8010190f:	e8 1c fb ff ff       	call   80101430 <bfree>
80101914:	eb ea                	jmp    80101900 <iput+0x110>
    }
    brelse(bp);
80101916:	83 ec 0c             	sub    $0xc,%esp
80101919:	ff 75 e4             	pushl  -0x1c(%ebp)
8010191c:	e8 af e8 ff ff       	call   801001d0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101921:	8b 56 4c             	mov    0x4c(%esi),%edx
80101924:	8b 06                	mov    (%esi),%eax
80101926:	e8 05 fb ff ff       	call   80101430 <bfree>
    ip->addrs[NDIRECT] = 0;
8010192b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101932:	83 c4 10             	add    $0x10,%esp
80101935:	e9 47 ff ff ff       	jmp    80101881 <iput+0x91>
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode has no links and no other references: truncate and free.
    if(ip->flags & I_BUSY)
      panic("iput busy");
8010193a:	83 ec 0c             	sub    $0xc,%esp
8010193d:	68 b9 7d 10 80       	push   $0x80107db9
80101942:	e8 09 ea ff ff       	call   80100350 <panic>
80101947:	89 f6                	mov    %esi,%esi
80101949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101950 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	53                   	push   %ebx
80101954:	83 ec 10             	sub    $0x10,%esp
80101957:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010195a:	53                   	push   %ebx
8010195b:	e8 30 fe ff ff       	call   80101790 <iunlock>
  iput(ip);
80101960:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101963:	83 c4 10             	add    $0x10,%esp
}
80101966:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101969:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
8010196a:	e9 81 fe ff ff       	jmp    801017f0 <iput>
8010196f:	90                   	nop

80101970 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101970:	55                   	push   %ebp
80101971:	89 e5                	mov    %esp,%ebp
80101973:	8b 55 08             	mov    0x8(%ebp),%edx
80101976:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101979:	8b 0a                	mov    (%edx),%ecx
8010197b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010197e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101981:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101984:	0f b7 4a 10          	movzwl 0x10(%edx),%ecx
80101988:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010198b:	0f b7 4a 16          	movzwl 0x16(%edx),%ecx
8010198f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101993:	8b 52 18             	mov    0x18(%edx),%edx
80101996:	89 50 10             	mov    %edx,0x10(%eax)
}
80101999:	5d                   	pop    %ebp
8010199a:	c3                   	ret    
8010199b:	90                   	nop
8010199c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019a0 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	57                   	push   %edi
801019a4:	56                   	push   %esi
801019a5:	53                   	push   %ebx
801019a6:	83 ec 1c             	sub    $0x1c,%esp
801019a9:	8b 45 08             	mov    0x8(%ebp),%eax
801019ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
801019af:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019b2:	66 83 78 10 03       	cmpw   $0x3,0x10(%eax)

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019b7:	89 7d e0             	mov    %edi,-0x20(%ebp)
801019ba:	8b 7d 14             	mov    0x14(%ebp),%edi
801019bd:	89 45 d8             	mov    %eax,-0x28(%ebp)
801019c0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019c3:	0f 84 a7 00 00 00    	je     80101a70 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019c9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801019cc:	8b 40 18             	mov    0x18(%eax),%eax
801019cf:	39 f0                	cmp    %esi,%eax
801019d1:	0f 82 c1 00 00 00    	jb     80101a98 <readi+0xf8>
801019d7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019da:	89 fa                	mov    %edi,%edx
801019dc:	01 f2                	add    %esi,%edx
801019de:	0f 82 b4 00 00 00    	jb     80101a98 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019e4:	89 c1                	mov    %eax,%ecx
801019e6:	29 f1                	sub    %esi,%ecx
801019e8:	39 d0                	cmp    %edx,%eax
801019ea:	0f 43 cf             	cmovae %edi,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019ed:	31 ff                	xor    %edi,%edi
801019ef:	85 c9                	test   %ecx,%ecx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019f1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019f4:	74 6d                	je     80101a63 <readi+0xc3>
801019f6:	8d 76 00             	lea    0x0(%esi),%esi
801019f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a00:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101a03:	89 f2                	mov    %esi,%edx
80101a05:	c1 ea 09             	shr    $0x9,%edx
80101a08:	89 d8                	mov    %ebx,%eax
80101a0a:	e8 21 f9 ff ff       	call   80101330 <bmap>
80101a0f:	83 ec 08             	sub    $0x8,%esp
80101a12:	50                   	push   %eax
80101a13:	ff 33                	pushl  (%ebx)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a15:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a1a:	e8 a1 e6 ff ff       	call   801000c0 <bread>
80101a1f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101a24:	89 f1                	mov    %esi,%ecx
80101a26:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101a2c:	83 c4 0c             	add    $0xc,%esp
    memmove(dst, bp->data + off%BSIZE, m);
80101a2f:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101a32:	29 cb                	sub    %ecx,%ebx
80101a34:	29 f8                	sub    %edi,%eax
80101a36:	39 c3                	cmp    %eax,%ebx
80101a38:	0f 47 d8             	cmova  %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a3b:	8d 44 0a 18          	lea    0x18(%edx,%ecx,1),%eax
80101a3f:	53                   	push   %ebx
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a40:	01 df                	add    %ebx,%edi
80101a42:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101a44:	50                   	push   %eax
80101a45:	ff 75 e0             	pushl  -0x20(%ebp)
80101a48:	e8 93 33 00 00       	call   80104de0 <memmove>
    brelse(bp);
80101a4d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a50:	89 14 24             	mov    %edx,(%esp)
80101a53:	e8 78 e7 ff ff       	call   801001d0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a58:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a5b:	83 c4 10             	add    $0x10,%esp
80101a5e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a61:	77 9d                	ja     80101a00 <readi+0x60>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101a63:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a66:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a69:	5b                   	pop    %ebx
80101a6a:	5e                   	pop    %esi
80101a6b:	5f                   	pop    %edi
80101a6c:	5d                   	pop    %ebp
80101a6d:	c3                   	ret    
80101a6e:	66 90                	xchg   %ax,%ax
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a70:	0f bf 40 12          	movswl 0x12(%eax),%eax
80101a74:	66 83 f8 09          	cmp    $0x9,%ax
80101a78:	77 1e                	ja     80101a98 <readi+0xf8>
80101a7a:	8b 04 c5 40 11 11 80 	mov    -0x7feeeec0(,%eax,8),%eax
80101a81:	85 c0                	test   %eax,%eax
80101a83:	74 13                	je     80101a98 <readi+0xf8>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a85:	89 7d 10             	mov    %edi,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
}
80101a88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a8b:	5b                   	pop    %ebx
80101a8c:	5e                   	pop    %esi
80101a8d:	5f                   	pop    %edi
80101a8e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a8f:	ff e0                	jmp    *%eax
80101a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101a98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a9d:	eb c7                	jmp    80101a66 <readi+0xc6>
80101a9f:	90                   	nop

80101aa0 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101aa0:	55                   	push   %ebp
80101aa1:	89 e5                	mov    %esp,%ebp
80101aa3:	57                   	push   %edi
80101aa4:	56                   	push   %esi
80101aa5:	53                   	push   %ebx
80101aa6:	83 ec 1c             	sub    $0x1c,%esp
80101aa9:	8b 45 08             	mov    0x8(%ebp),%eax
80101aac:	8b 75 0c             	mov    0xc(%ebp),%esi
80101aaf:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ab2:	66 83 78 10 03       	cmpw   $0x3,0x10(%eax)

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ab7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101aba:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101abd:	8b 75 10             	mov    0x10(%ebp),%esi
80101ac0:	89 7d e0             	mov    %edi,-0x20(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ac3:	0f 84 b7 00 00 00    	je     80101b80 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101ac9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101acc:	39 70 18             	cmp    %esi,0x18(%eax)
80101acf:	0f 82 eb 00 00 00    	jb     80101bc0 <writei+0x120>
80101ad5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101ad8:	89 f8                	mov    %edi,%eax
80101ada:	01 f0                	add    %esi,%eax
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101adc:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ae1:	0f 87 d9 00 00 00    	ja     80101bc0 <writei+0x120>
80101ae7:	39 c6                	cmp    %eax,%esi
80101ae9:	0f 87 d1 00 00 00    	ja     80101bc0 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101aef:	85 ff                	test   %edi,%edi
80101af1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101af8:	74 78                	je     80101b72 <writei+0xd2>
80101afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b00:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101b03:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b05:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b0a:	c1 ea 09             	shr    $0x9,%edx
80101b0d:	89 f8                	mov    %edi,%eax
80101b0f:	e8 1c f8 ff ff       	call   80101330 <bmap>
80101b14:	83 ec 08             	sub    $0x8,%esp
80101b17:	50                   	push   %eax
80101b18:	ff 37                	pushl  (%edi)
80101b1a:	e8 a1 e5 ff ff       	call   801000c0 <bread>
80101b1f:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b21:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101b24:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101b27:	89 f1                	mov    %esi,%ecx
80101b29:	83 c4 0c             	add    $0xc,%esp
80101b2c:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101b32:	29 cb                	sub    %ecx,%ebx
80101b34:	39 c3                	cmp    %eax,%ebx
80101b36:	0f 47 d8             	cmova  %eax,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b39:	8d 44 0f 18          	lea    0x18(%edi,%ecx,1),%eax
80101b3d:	53                   	push   %ebx
80101b3e:	ff 75 dc             	pushl  -0x24(%ebp)
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b41:	01 de                	add    %ebx,%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101b43:	50                   	push   %eax
80101b44:	e8 97 32 00 00       	call   80104de0 <memmove>
    log_write(bp);
80101b49:	89 3c 24             	mov    %edi,(%esp)
80101b4c:	e8 bf 12 00 00       	call   80102e10 <log_write>
    brelse(bp);
80101b51:	89 3c 24             	mov    %edi,(%esp)
80101b54:	e8 77 e6 ff ff       	call   801001d0 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b59:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b5c:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b5f:	83 c4 10             	add    $0x10,%esp
80101b62:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b65:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101b68:	77 96                	ja     80101b00 <writei+0x60>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101b6a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b6d:	3b 70 18             	cmp    0x18(%eax),%esi
80101b70:	77 36                	ja     80101ba8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b72:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b78:	5b                   	pop    %ebx
80101b79:	5e                   	pop    %esi
80101b7a:	5f                   	pop    %edi
80101b7b:	5d                   	pop    %ebp
80101b7c:	c3                   	ret    
80101b7d:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b80:	0f bf 40 12          	movswl 0x12(%eax),%eax
80101b84:	66 83 f8 09          	cmp    $0x9,%ax
80101b88:	77 36                	ja     80101bc0 <writei+0x120>
80101b8a:	8b 04 c5 44 11 11 80 	mov    -0x7feeeebc(,%eax,8),%eax
80101b91:	85 c0                	test   %eax,%eax
80101b93:	74 2b                	je     80101bc0 <writei+0x120>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b95:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101b98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b9b:	5b                   	pop    %ebx
80101b9c:	5e                   	pop    %esi
80101b9d:	5f                   	pop    %edi
80101b9e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b9f:	ff e0                	jmp    *%eax
80101ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101ba8:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101bab:	83 ec 0c             	sub    $0xc,%esp
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101bae:	89 70 18             	mov    %esi,0x18(%eax)
    iupdate(ip);
80101bb1:	50                   	push   %eax
80101bb2:	e8 19 fa ff ff       	call   801015d0 <iupdate>
80101bb7:	83 c4 10             	add    $0x10,%esp
80101bba:	eb b6                	jmp    80101b72 <writei+0xd2>
80101bbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bc5:	eb ae                	jmp    80101b75 <writei+0xd5>
80101bc7:	89 f6                	mov    %esi,%esi
80101bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bd0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101bd0:	55                   	push   %ebp
80101bd1:	89 e5                	mov    %esp,%ebp
80101bd3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101bd6:	6a 0e                	push   $0xe
80101bd8:	ff 75 0c             	pushl  0xc(%ebp)
80101bdb:	ff 75 08             	pushl  0x8(%ebp)
80101bde:	e8 7d 32 00 00       	call   80104e60 <strncmp>
}
80101be3:	c9                   	leave  
80101be4:	c3                   	ret    
80101be5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bf0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bf0:	55                   	push   %ebp
80101bf1:	89 e5                	mov    %esp,%ebp
80101bf3:	57                   	push   %edi
80101bf4:	56                   	push   %esi
80101bf5:	53                   	push   %ebx
80101bf6:	83 ec 1c             	sub    $0x1c,%esp
80101bf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bfc:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80101c01:	0f 85 80 00 00 00    	jne    80101c87 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c07:	8b 53 18             	mov    0x18(%ebx),%edx
80101c0a:	31 ff                	xor    %edi,%edi
80101c0c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c0f:	85 d2                	test   %edx,%edx
80101c11:	75 0d                	jne    80101c20 <dirlookup+0x30>
80101c13:	eb 5b                	jmp    80101c70 <dirlookup+0x80>
80101c15:	8d 76 00             	lea    0x0(%esi),%esi
80101c18:	83 c7 10             	add    $0x10,%edi
80101c1b:	39 7b 18             	cmp    %edi,0x18(%ebx)
80101c1e:	76 50                	jbe    80101c70 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c20:	6a 10                	push   $0x10
80101c22:	57                   	push   %edi
80101c23:	56                   	push   %esi
80101c24:	53                   	push   %ebx
80101c25:	e8 76 fd ff ff       	call   801019a0 <readi>
80101c2a:	83 c4 10             	add    $0x10,%esp
80101c2d:	83 f8 10             	cmp    $0x10,%eax
80101c30:	75 48                	jne    80101c7a <dirlookup+0x8a>
      panic("dirlink read");
    if(de.inum == 0)
80101c32:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c37:	74 df                	je     80101c18 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101c39:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c3c:	83 ec 04             	sub    $0x4,%esp
80101c3f:	6a 0e                	push   $0xe
80101c41:	50                   	push   %eax
80101c42:	ff 75 0c             	pushl  0xc(%ebp)
80101c45:	e8 16 32 00 00       	call   80104e60 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101c4a:	83 c4 10             	add    $0x10,%esp
80101c4d:	85 c0                	test   %eax,%eax
80101c4f:	75 c7                	jne    80101c18 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101c51:	8b 45 10             	mov    0x10(%ebp),%eax
80101c54:	85 c0                	test   %eax,%eax
80101c56:	74 05                	je     80101c5d <dirlookup+0x6d>
        *poff = off;
80101c58:	8b 45 10             	mov    0x10(%ebp),%eax
80101c5b:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101c5d:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101c61:	8b 03                	mov    (%ebx),%eax
80101c63:	e8 f8 f5 ff ff       	call   80101260 <iget>
    }
  }

  return 0;
}
80101c68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c6b:	5b                   	pop    %ebx
80101c6c:	5e                   	pop    %esi
80101c6d:	5f                   	pop    %edi
80101c6e:	5d                   	pop    %ebp
80101c6f:	c3                   	ret    
80101c70:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101c73:	31 c0                	xor    %eax,%eax
}
80101c75:	5b                   	pop    %ebx
80101c76:	5e                   	pop    %esi
80101c77:	5f                   	pop    %edi
80101c78:	5d                   	pop    %ebp
80101c79:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101c7a:	83 ec 0c             	sub    $0xc,%esp
80101c7d:	68 d5 7d 10 80       	push   $0x80107dd5
80101c82:	e8 c9 e6 ff ff       	call   80100350 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101c87:	83 ec 0c             	sub    $0xc,%esp
80101c8a:	68 c3 7d 10 80       	push   $0x80107dc3
80101c8f:	e8 bc e6 ff ff       	call   80100350 <panic>
80101c94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101ca0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101ca0:	55                   	push   %ebp
80101ca1:	89 e5                	mov    %esp,%ebp
80101ca3:	57                   	push   %edi
80101ca4:	56                   	push   %esi
80101ca5:	53                   	push   %ebx
80101ca6:	89 cf                	mov    %ecx,%edi
80101ca8:	89 c3                	mov    %eax,%ebx
80101caa:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101cad:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101cb0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101cb3:	0f 84 53 01 00 00    	je     80101e0c <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101cb9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101cbf:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101cc2:	8b 70 58             	mov    0x58(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101cc5:	68 c0 11 11 80       	push   $0x801111c0
80101cca:	e8 31 2e 00 00       	call   80104b00 <acquire>
  ip->ref++;
80101ccf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cd3:	c7 04 24 c0 11 11 80 	movl   $0x801111c0,(%esp)
80101cda:	e8 01 30 00 00       	call   80104ce0 <release>
80101cdf:	83 c4 10             	add    $0x10,%esp
80101ce2:	eb 07                	jmp    80101ceb <namex+0x4b>
80101ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101ce8:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101ceb:	0f b6 03             	movzbl (%ebx),%eax
80101cee:	3c 2f                	cmp    $0x2f,%al
80101cf0:	74 f6                	je     80101ce8 <namex+0x48>
    path++;
  if(*path == 0)
80101cf2:	84 c0                	test   %al,%al
80101cf4:	0f 84 e3 00 00 00    	je     80101ddd <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101cfa:	0f b6 03             	movzbl (%ebx),%eax
80101cfd:	89 da                	mov    %ebx,%edx
80101cff:	84 c0                	test   %al,%al
80101d01:	0f 84 ac 00 00 00    	je     80101db3 <namex+0x113>
80101d07:	3c 2f                	cmp    $0x2f,%al
80101d09:	75 09                	jne    80101d14 <namex+0x74>
80101d0b:	e9 a3 00 00 00       	jmp    80101db3 <namex+0x113>
80101d10:	84 c0                	test   %al,%al
80101d12:	74 0a                	je     80101d1e <namex+0x7e>
    path++;
80101d14:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d17:	0f b6 02             	movzbl (%edx),%eax
80101d1a:	3c 2f                	cmp    $0x2f,%al
80101d1c:	75 f2                	jne    80101d10 <namex+0x70>
80101d1e:	89 d1                	mov    %edx,%ecx
80101d20:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101d22:	83 f9 0d             	cmp    $0xd,%ecx
80101d25:	0f 8e 8d 00 00 00    	jle    80101db8 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101d2b:	83 ec 04             	sub    $0x4,%esp
80101d2e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d31:	6a 0e                	push   $0xe
80101d33:	53                   	push   %ebx
80101d34:	57                   	push   %edi
80101d35:	e8 a6 30 00 00       	call   80104de0 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101d3a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101d3d:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101d40:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101d42:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d45:	75 11                	jne    80101d58 <namex+0xb8>
80101d47:	89 f6                	mov    %esi,%esi
80101d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d50:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101d53:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d56:	74 f8                	je     80101d50 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d58:	83 ec 0c             	sub    $0xc,%esp
80101d5b:	56                   	push   %esi
80101d5c:	e8 1f f9 ff ff       	call   80101680 <ilock>
    if(ip->type != T_DIR){
80101d61:	83 c4 10             	add    $0x10,%esp
80101d64:	66 83 7e 10 01       	cmpw   $0x1,0x10(%esi)
80101d69:	0f 85 7f 00 00 00    	jne    80101dee <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d6f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d72:	85 d2                	test   %edx,%edx
80101d74:	74 09                	je     80101d7f <namex+0xdf>
80101d76:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d79:	0f 84 a3 00 00 00    	je     80101e22 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d7f:	83 ec 04             	sub    $0x4,%esp
80101d82:	6a 00                	push   $0x0
80101d84:	57                   	push   %edi
80101d85:	56                   	push   %esi
80101d86:	e8 65 fe ff ff       	call   80101bf0 <dirlookup>
80101d8b:	83 c4 10             	add    $0x10,%esp
80101d8e:	85 c0                	test   %eax,%eax
80101d90:	74 5c                	je     80101dee <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d92:	83 ec 0c             	sub    $0xc,%esp
80101d95:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d98:	56                   	push   %esi
80101d99:	e8 f2 f9 ff ff       	call   80101790 <iunlock>
  iput(ip);
80101d9e:	89 34 24             	mov    %esi,(%esp)
80101da1:	e8 4a fa ff ff       	call   801017f0 <iput>
80101da6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101da9:	83 c4 10             	add    $0x10,%esp
80101dac:	89 c6                	mov    %eax,%esi
80101dae:	e9 38 ff ff ff       	jmp    80101ceb <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101db3:	31 c9                	xor    %ecx,%ecx
80101db5:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101db8:	83 ec 04             	sub    $0x4,%esp
80101dbb:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101dbe:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101dc1:	51                   	push   %ecx
80101dc2:	53                   	push   %ebx
80101dc3:	57                   	push   %edi
80101dc4:	e8 17 30 00 00       	call   80104de0 <memmove>
    name[len] = 0;
80101dc9:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101dcc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101dcf:	83 c4 10             	add    $0x10,%esp
80101dd2:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101dd6:	89 d3                	mov    %edx,%ebx
80101dd8:	e9 65 ff ff ff       	jmp    80101d42 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101ddd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101de0:	85 c0                	test   %eax,%eax
80101de2:	75 54                	jne    80101e38 <namex+0x198>
80101de4:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101de6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101de9:	5b                   	pop    %ebx
80101dea:	5e                   	pop    %esi
80101deb:	5f                   	pop    %edi
80101dec:	5d                   	pop    %ebp
80101ded:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101dee:	83 ec 0c             	sub    $0xc,%esp
80101df1:	56                   	push   %esi
80101df2:	e8 99 f9 ff ff       	call   80101790 <iunlock>
  iput(ip);
80101df7:	89 34 24             	mov    %esi,(%esp)
80101dfa:	e8 f1 f9 ff ff       	call   801017f0 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101dff:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e02:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101e05:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e07:	5b                   	pop    %ebx
80101e08:	5e                   	pop    %esi
80101e09:	5f                   	pop    %edi
80101e0a:	5d                   	pop    %ebp
80101e0b:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101e0c:	ba 01 00 00 00       	mov    $0x1,%edx
80101e11:	b8 01 00 00 00       	mov    $0x1,%eax
80101e16:	e8 45 f4 ff ff       	call   80101260 <iget>
80101e1b:	89 c6                	mov    %eax,%esi
80101e1d:	e9 c9 fe ff ff       	jmp    80101ceb <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101e22:	83 ec 0c             	sub    $0xc,%esp
80101e25:	56                   	push   %esi
80101e26:	e8 65 f9 ff ff       	call   80101790 <iunlock>
      return ip;
80101e2b:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e2e:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101e31:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e33:	5b                   	pop    %ebx
80101e34:	5e                   	pop    %esi
80101e35:	5f                   	pop    %edi
80101e36:	5d                   	pop    %ebp
80101e37:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101e38:	83 ec 0c             	sub    $0xc,%esp
80101e3b:	56                   	push   %esi
80101e3c:	e8 af f9 ff ff       	call   801017f0 <iput>
    return 0;
80101e41:	83 c4 10             	add    $0x10,%esp
80101e44:	31 c0                	xor    %eax,%eax
80101e46:	eb 9e                	jmp    80101de6 <namex+0x146>
80101e48:	90                   	nop
80101e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e50 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101e50:	55                   	push   %ebp
80101e51:	89 e5                	mov    %esp,%ebp
80101e53:	57                   	push   %edi
80101e54:	56                   	push   %esi
80101e55:	53                   	push   %ebx
80101e56:	83 ec 20             	sub    $0x20,%esp
80101e59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e5c:	6a 00                	push   $0x0
80101e5e:	ff 75 0c             	pushl  0xc(%ebp)
80101e61:	53                   	push   %ebx
80101e62:	e8 89 fd ff ff       	call   80101bf0 <dirlookup>
80101e67:	83 c4 10             	add    $0x10,%esp
80101e6a:	85 c0                	test   %eax,%eax
80101e6c:	75 67                	jne    80101ed5 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e6e:	8b 7b 18             	mov    0x18(%ebx),%edi
80101e71:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e74:	85 ff                	test   %edi,%edi
80101e76:	74 29                	je     80101ea1 <dirlink+0x51>
80101e78:	31 ff                	xor    %edi,%edi
80101e7a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e7d:	eb 09                	jmp    80101e88 <dirlink+0x38>
80101e7f:	90                   	nop
80101e80:	83 c7 10             	add    $0x10,%edi
80101e83:	39 7b 18             	cmp    %edi,0x18(%ebx)
80101e86:	76 19                	jbe    80101ea1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e88:	6a 10                	push   $0x10
80101e8a:	57                   	push   %edi
80101e8b:	56                   	push   %esi
80101e8c:	53                   	push   %ebx
80101e8d:	e8 0e fb ff ff       	call   801019a0 <readi>
80101e92:	83 c4 10             	add    $0x10,%esp
80101e95:	83 f8 10             	cmp    $0x10,%eax
80101e98:	75 4e                	jne    80101ee8 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101e9a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e9f:	75 df                	jne    80101e80 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101ea1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ea4:	83 ec 04             	sub    $0x4,%esp
80101ea7:	6a 0e                	push   $0xe
80101ea9:	ff 75 0c             	pushl  0xc(%ebp)
80101eac:	50                   	push   %eax
80101ead:	e8 1e 30 00 00       	call   80104ed0 <strncpy>
  de.inum = inum;
80101eb2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101eb5:	6a 10                	push   $0x10
80101eb7:	57                   	push   %edi
80101eb8:	56                   	push   %esi
80101eb9:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101eba:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ebe:	e8 dd fb ff ff       	call   80101aa0 <writei>
80101ec3:	83 c4 20             	add    $0x20,%esp
80101ec6:	83 f8 10             	cmp    $0x10,%eax
80101ec9:	75 2a                	jne    80101ef5 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101ecb:	31 c0                	xor    %eax,%eax
}
80101ecd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ed0:	5b                   	pop    %ebx
80101ed1:	5e                   	pop    %esi
80101ed2:	5f                   	pop    %edi
80101ed3:	5d                   	pop    %ebp
80101ed4:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101ed5:	83 ec 0c             	sub    $0xc,%esp
80101ed8:	50                   	push   %eax
80101ed9:	e8 12 f9 ff ff       	call   801017f0 <iput>
    return -1;
80101ede:	83 c4 10             	add    $0x10,%esp
80101ee1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ee6:	eb e5                	jmp    80101ecd <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101ee8:	83 ec 0c             	sub    $0xc,%esp
80101eeb:	68 d5 7d 10 80       	push   $0x80107dd5
80101ef0:	e8 5b e4 ff ff       	call   80100350 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101ef5:	83 ec 0c             	sub    $0xc,%esp
80101ef8:	68 c2 83 10 80       	push   $0x801083c2
80101efd:	e8 4e e4 ff ff       	call   80100350 <panic>
80101f02:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f10 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101f10:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f11:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101f13:	89 e5                	mov    %esp,%ebp
80101f15:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f18:	8b 45 08             	mov    0x8(%ebp),%eax
80101f1b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f1e:	e8 7d fd ff ff       	call   80101ca0 <namex>
}
80101f23:	c9                   	leave  
80101f24:	c3                   	ret    
80101f25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f30 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f30:	55                   	push   %ebp
  return namex(path, 1, name);
80101f31:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101f36:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f38:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f3b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f3e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101f3f:	e9 5c fd ff ff       	jmp    80101ca0 <namex>
80101f44:	66 90                	xchg   %ax,%ax
80101f46:	66 90                	xchg   %ax,%ax
80101f48:	66 90                	xchg   %ax,%ax
80101f4a:	66 90                	xchg   %ax,%ax
80101f4c:	66 90                	xchg   %ax,%ax
80101f4e:	66 90                	xchg   %ax,%ax

80101f50 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f50:	55                   	push   %ebp
  if(b == 0)
80101f51:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f53:	89 e5                	mov    %esp,%ebp
80101f55:	56                   	push   %esi
80101f56:	53                   	push   %ebx
  if(b == 0)
80101f57:	0f 84 ad 00 00 00    	je     8010200a <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f5d:	8b 58 08             	mov    0x8(%eax),%ebx
80101f60:	89 c1                	mov    %eax,%ecx
80101f62:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f68:	0f 87 8f 00 00 00    	ja     80101ffd <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f6e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f73:	90                   	nop
80101f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f78:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f79:	83 e0 c0             	and    $0xffffffc0,%eax
80101f7c:	3c 40                	cmp    $0x40,%al
80101f7e:	75 f8                	jne    80101f78 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f80:	31 f6                	xor    %esi,%esi
80101f82:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f87:	89 f0                	mov    %esi,%eax
80101f89:	ee                   	out    %al,(%dx)
80101f8a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f8f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f94:	ee                   	out    %al,(%dx)
80101f95:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f9a:	89 d8                	mov    %ebx,%eax
80101f9c:	ee                   	out    %al,(%dx)
80101f9d:	89 d8                	mov    %ebx,%eax
80101f9f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101fa4:	c1 f8 08             	sar    $0x8,%eax
80101fa7:	ee                   	out    %al,(%dx)
80101fa8:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101fad:	89 f0                	mov    %esi,%eax
80101faf:	ee                   	out    %al,(%dx)
80101fb0:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101fb4:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fb9:	83 e0 01             	and    $0x1,%eax
80101fbc:	c1 e0 04             	shl    $0x4,%eax
80101fbf:	83 c8 e0             	or     $0xffffffe0,%eax
80101fc2:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80101fc3:	f6 01 04             	testb  $0x4,(%ecx)
80101fc6:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fcb:	75 13                	jne    80101fe0 <idestart+0x90>
80101fcd:	b8 20 00 00 00       	mov    $0x20,%eax
80101fd2:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fd3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101fd6:	5b                   	pop    %ebx
80101fd7:	5e                   	pop    %esi
80101fd8:	5d                   	pop    %ebp
80101fd9:	c3                   	ret    
80101fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fe0:	b8 30 00 00 00       	mov    $0x30,%eax
80101fe5:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101fe6:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101feb:	8d 71 18             	lea    0x18(%ecx),%esi
80101fee:	b9 80 00 00 00       	mov    $0x80,%ecx
80101ff3:	fc                   	cld    
80101ff4:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101ff6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101ff9:	5b                   	pop    %ebx
80101ffa:	5e                   	pop    %esi
80101ffb:	5d                   	pop    %ebp
80101ffc:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101ffd:	83 ec 0c             	sub    $0xc,%esp
80102000:	68 49 7e 10 80       	push   $0x80107e49
80102005:	e8 46 e3 ff ff       	call   80100350 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
8010200a:	83 ec 0c             	sub    $0xc,%esp
8010200d:	68 40 7e 10 80       	push   $0x80107e40
80102012:	e8 39 e3 ff ff       	call   80100350 <panic>
80102017:	89 f6                	mov    %esi,%esi
80102019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102020 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80102020:	55                   	push   %ebp
80102021:	89 e5                	mov    %esp,%ebp
80102023:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80102026:	68 5b 7e 10 80       	push   $0x80107e5b
8010202b:	68 80 b5 10 80       	push   $0x8010b580
80102030:	e8 ab 2a 00 00       	call   80104ae0 <initlock>
  picenable(IRQ_IDE);
80102035:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
8010203c:	e8 bf 12 00 00       	call   80103300 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102041:	58                   	pop    %eax
80102042:	a1 e0 28 11 80       	mov    0x801128e0,%eax
80102047:	5a                   	pop    %edx
80102048:	83 e8 01             	sub    $0x1,%eax
8010204b:	50                   	push   %eax
8010204c:	6a 0e                	push   $0xe
8010204e:	e8 ad 02 00 00       	call   80102300 <ioapicenable>
80102053:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102056:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010205b:	90                   	nop
8010205c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102060:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102061:	83 e0 c0             	and    $0xffffffc0,%eax
80102064:	3c 40                	cmp    $0x40,%al
80102066:	75 f8                	jne    80102060 <ideinit+0x40>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102068:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010206d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102072:	ee                   	out    %al,(%dx)
80102073:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102078:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010207d:	eb 06                	jmp    80102085 <ideinit+0x65>
8010207f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102080:	83 e9 01             	sub    $0x1,%ecx
80102083:	74 0f                	je     80102094 <ideinit+0x74>
80102085:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102086:	84 c0                	test   %al,%al
80102088:	74 f6                	je     80102080 <ideinit+0x60>
      havedisk1 = 1;
8010208a:	c7 05 60 b5 10 80 01 	movl   $0x1,0x8010b560
80102091:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102094:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102099:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010209e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010209f:	c9                   	leave  
801020a0:	c3                   	ret    
801020a1:	eb 0d                	jmp    801020b0 <ideintr>
801020a3:	90                   	nop
801020a4:	90                   	nop
801020a5:	90                   	nop
801020a6:	90                   	nop
801020a7:	90                   	nop
801020a8:	90                   	nop
801020a9:	90                   	nop
801020aa:	90                   	nop
801020ab:	90                   	nop
801020ac:	90                   	nop
801020ad:	90                   	nop
801020ae:	90                   	nop
801020af:	90                   	nop

801020b0 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
801020b0:	55                   	push   %ebp
801020b1:	89 e5                	mov    %esp,%ebp
801020b3:	57                   	push   %edi
801020b4:	56                   	push   %esi
801020b5:	53                   	push   %ebx
801020b6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801020b9:	68 80 b5 10 80       	push   $0x8010b580
801020be:	e8 3d 2a 00 00       	call   80104b00 <acquire>
  if((b = idequeue) == 0){
801020c3:	8b 1d 64 b5 10 80    	mov    0x8010b564,%ebx
801020c9:	83 c4 10             	add    $0x10,%esp
801020cc:	85 db                	test   %ebx,%ebx
801020ce:	74 34                	je     80102104 <ideintr+0x54>
    release(&idelock);
    // cprintf("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
801020d0:	8b 43 14             	mov    0x14(%ebx),%eax
801020d3:	a3 64 b5 10 80       	mov    %eax,0x8010b564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020d8:	8b 33                	mov    (%ebx),%esi
801020da:	f7 c6 04 00 00 00    	test   $0x4,%esi
801020e0:	74 3e                	je     80102120 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020e2:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801020e5:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020e8:	83 ce 02             	or     $0x2,%esi
801020eb:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801020ed:	53                   	push   %ebx
801020ee:	e8 8d 22 00 00       	call   80104380 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801020f3:	a1 64 b5 10 80       	mov    0x8010b564,%eax
801020f8:	83 c4 10             	add    $0x10,%esp
801020fb:	85 c0                	test   %eax,%eax
801020fd:	74 05                	je     80102104 <ideintr+0x54>
    idestart(idequeue);
801020ff:	e8 4c fe ff ff       	call   80101f50 <idestart>
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
  if((b = idequeue) == 0){
    release(&idelock);
80102104:	83 ec 0c             	sub    $0xc,%esp
80102107:	68 80 b5 10 80       	push   $0x8010b580
8010210c:	e8 cf 2b 00 00       	call   80104ce0 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80102111:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102114:	5b                   	pop    %ebx
80102115:	5e                   	pop    %esi
80102116:	5f                   	pop    %edi
80102117:	5d                   	pop    %ebp
80102118:	c3                   	ret    
80102119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102120:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102125:	8d 76 00             	lea    0x0(%esi),%esi
80102128:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102129:	89 c1                	mov    %eax,%ecx
8010212b:	83 e1 c0             	and    $0xffffffc0,%ecx
8010212e:	80 f9 40             	cmp    $0x40,%cl
80102131:	75 f5                	jne    80102128 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102133:	a8 21                	test   $0x21,%al
80102135:	75 ab                	jne    801020e2 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80102137:	8d 7b 18             	lea    0x18(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
8010213a:	b9 80 00 00 00       	mov    $0x80,%ecx
8010213f:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102144:	fc                   	cld    
80102145:	f3 6d                	rep insl (%dx),%es:(%edi)
80102147:	8b 33                	mov    (%ebx),%esi
80102149:	eb 97                	jmp    801020e2 <ideintr+0x32>
8010214b:	90                   	nop
8010214c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102150 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	53                   	push   %ebx
80102154:	83 ec 04             	sub    $0x4,%esp
80102157:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!(b->flags & B_BUSY))
8010215a:	8b 03                	mov    (%ebx),%eax
8010215c:	a8 01                	test   $0x1,%al
8010215e:	0f 84 a7 00 00 00    	je     8010220b <iderw+0xbb>
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102164:	83 e0 06             	and    $0x6,%eax
80102167:	83 f8 02             	cmp    $0x2,%eax
8010216a:	0f 84 b5 00 00 00    	je     80102225 <iderw+0xd5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102170:	8b 53 04             	mov    0x4(%ebx),%edx
80102173:	85 d2                	test   %edx,%edx
80102175:	74 0d                	je     80102184 <iderw+0x34>
80102177:	a1 60 b5 10 80       	mov    0x8010b560,%eax
8010217c:	85 c0                	test   %eax,%eax
8010217e:	0f 84 94 00 00 00    	je     80102218 <iderw+0xc8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102184:	83 ec 0c             	sub    $0xc,%esp
80102187:	68 80 b5 10 80       	push   $0x8010b580
8010218c:	e8 6f 29 00 00       	call   80104b00 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102191:	8b 15 64 b5 10 80    	mov    0x8010b564,%edx
80102197:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
8010219a:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021a1:	85 d2                	test   %edx,%edx
801021a3:	75 0d                	jne    801021b2 <iderw+0x62>
801021a5:	eb 54                	jmp    801021fb <iderw+0xab>
801021a7:	89 f6                	mov    %esi,%esi
801021a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801021b0:	89 c2                	mov    %eax,%edx
801021b2:	8b 42 14             	mov    0x14(%edx),%eax
801021b5:	85 c0                	test   %eax,%eax
801021b7:	75 f7                	jne    801021b0 <iderw+0x60>
801021b9:	83 c2 14             	add    $0x14,%edx
    ;
  *pp = b;
801021bc:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801021be:	3b 1d 64 b5 10 80    	cmp    0x8010b564,%ebx
801021c4:	74 3c                	je     80102202 <iderw+0xb2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021c6:	8b 03                	mov    (%ebx),%eax
801021c8:	83 e0 06             	and    $0x6,%eax
801021cb:	83 f8 02             	cmp    $0x2,%eax
801021ce:	74 1b                	je     801021eb <iderw+0x9b>
    sleep(b, &idelock);
801021d0:	83 ec 08             	sub    $0x8,%esp
801021d3:	68 80 b5 10 80       	push   $0x8010b580
801021d8:	53                   	push   %ebx
801021d9:	e8 32 1f 00 00       	call   80104110 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021de:	8b 03                	mov    (%ebx),%eax
801021e0:	83 c4 10             	add    $0x10,%esp
801021e3:	83 e0 06             	and    $0x6,%eax
801021e6:	83 f8 02             	cmp    $0x2,%eax
801021e9:	75 e5                	jne    801021d0 <iderw+0x80>
    sleep(b, &idelock);
  }

  release(&idelock);
801021eb:	c7 45 08 80 b5 10 80 	movl   $0x8010b580,0x8(%ebp)
}
801021f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021f5:	c9                   	leave  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }

  release(&idelock);
801021f6:	e9 e5 2a 00 00       	jmp    80104ce0 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021fb:	ba 64 b5 10 80       	mov    $0x8010b564,%edx
80102200:	eb ba                	jmp    801021bc <iderw+0x6c>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80102202:	89 d8                	mov    %ebx,%eax
80102204:	e8 47 fd ff ff       	call   80101f50 <idestart>
80102209:	eb bb                	jmp    801021c6 <iderw+0x76>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("iderw: buf not busy");
8010220b:	83 ec 0c             	sub    $0xc,%esp
8010220e:	68 5f 7e 10 80       	push   $0x80107e5f
80102213:	e8 38 e1 ff ff       	call   80100350 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102218:	83 ec 0c             	sub    $0xc,%esp
8010221b:	68 88 7e 10 80       	push   $0x80107e88
80102220:	e8 2b e1 ff ff       	call   80100350 <panic>
  struct buf **pp;

  if(!(b->flags & B_BUSY))
    panic("iderw: buf not busy");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102225:	83 ec 0c             	sub    $0xc,%esp
80102228:	68 73 7e 10 80       	push   $0x80107e73
8010222d:	e8 1e e1 ff ff       	call   80100350 <panic>
80102232:	66 90                	xchg   %ax,%ax
80102234:	66 90                	xchg   %ax,%ax
80102236:	66 90                	xchg   %ax,%ax
80102238:	66 90                	xchg   %ax,%ax
8010223a:	66 90                	xchg   %ax,%ax
8010223c:	66 90                	xchg   %ax,%ax
8010223e:	66 90                	xchg   %ax,%ax

80102240 <ioapicinit>:
void
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
80102240:	a1 c4 22 11 80       	mov    0x801122c4,%eax
80102245:	85 c0                	test   %eax,%eax
80102247:	0f 84 a8 00 00 00    	je     801022f5 <ioapicinit+0xb5>
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010224d:	55                   	push   %ebp
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
8010224e:	c7 05 94 21 11 80 00 	movl   $0xfec00000,0x80112194
80102255:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102258:	89 e5                	mov    %esp,%ebp
8010225a:	56                   	push   %esi
8010225b:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
8010225c:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102263:	00 00 00 
  return ioapic->data;
80102266:	8b 15 94 21 11 80    	mov    0x80112194,%edx
8010226c:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
8010226f:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102275:	8b 0d 94 21 11 80    	mov    0x80112194,%ecx
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010227b:	0f b6 15 c0 22 11 80 	movzbl 0x801122c0,%edx

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102282:	89 f0                	mov    %esi,%eax
80102284:	c1 e8 10             	shr    $0x10,%eax
80102287:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010228a:	8b 41 10             	mov    0x10(%ecx),%eax
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010228d:	c1 e8 18             	shr    $0x18,%eax
80102290:	39 d0                	cmp    %edx,%eax
80102292:	74 16                	je     801022aa <ioapicinit+0x6a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102294:	83 ec 0c             	sub    $0xc,%esp
80102297:	68 a8 7e 10 80       	push   $0x80107ea8
8010229c:	e8 9f e3 ff ff       	call   80100640 <cprintf>
801022a1:	8b 0d 94 21 11 80    	mov    0x80112194,%ecx
801022a7:	83 c4 10             	add    $0x10,%esp
801022aa:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022ad:	ba 10 00 00 00       	mov    $0x10,%edx
801022b2:	b8 20 00 00 00       	mov    $0x20,%eax
801022b7:	89 f6                	mov    %esi,%esi
801022b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022c0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801022c2:	8b 0d 94 21 11 80    	mov    0x80112194,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022c8:	89 c3                	mov    %eax,%ebx
801022ca:	81 cb 00 00 01 00    	or     $0x10000,%ebx
801022d0:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022d3:	89 59 10             	mov    %ebx,0x10(%ecx)
801022d6:	8d 5a 01             	lea    0x1(%edx),%ebx
801022d9:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801022dc:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022de:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801022e0:	8b 0d 94 21 11 80    	mov    0x80112194,%ecx
801022e6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801022ed:	75 d1                	jne    801022c0 <ioapicinit+0x80>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022f2:	5b                   	pop    %ebx
801022f3:	5e                   	pop    %esi
801022f4:	5d                   	pop    %ebp
801022f5:	f3 c3                	repz ret 
801022f7:	89 f6                	mov    %esi,%esi
801022f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102300 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
80102300:	8b 15 c4 22 11 80    	mov    0x801122c4,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102306:	55                   	push   %ebp
80102307:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102309:	85 d2                	test   %edx,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
8010230b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
8010230e:	74 2b                	je     8010233b <ioapicenable+0x3b>
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102310:	8b 0d 94 21 11 80    	mov    0x80112194,%ecx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102316:	8d 50 20             	lea    0x20(%eax),%edx
80102319:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010231d:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
8010231f:	8b 0d 94 21 11 80    	mov    0x80112194,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102325:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102328:	89 51 10             	mov    %edx,0x10(%ecx)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010232b:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010232e:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102330:	a1 94 21 11 80       	mov    0x80112194,%eax

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102335:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102338:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
8010233b:	5d                   	pop    %ebp
8010233c:	c3                   	ret    
8010233d:	66 90                	xchg   %ax,%ax
8010233f:	90                   	nop

80102340 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102340:	55                   	push   %ebp
80102341:	89 e5                	mov    %esp,%ebp
80102343:	53                   	push   %ebx
80102344:	83 ec 04             	sub    $0x4,%esp
80102347:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010234a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102350:	75 70                	jne    801023c2 <kfree+0x82>
80102352:	81 fb 40 cc 12 80    	cmp    $0x8012cc40,%ebx
80102358:	72 68                	jb     801023c2 <kfree+0x82>
8010235a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102360:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102365:	77 5b                	ja     801023c2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102367:	83 ec 04             	sub    $0x4,%esp
8010236a:	68 00 10 00 00       	push   $0x1000
8010236f:	6a 01                	push   $0x1
80102371:	53                   	push   %ebx
80102372:	e8 b9 29 00 00       	call   80104d30 <memset>

  if(kmem.use_lock)
80102377:	8b 15 d4 21 11 80    	mov    0x801121d4,%edx
8010237d:	83 c4 10             	add    $0x10,%esp
80102380:	85 d2                	test   %edx,%edx
80102382:	75 2c                	jne    801023b0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102384:	a1 d8 21 11 80       	mov    0x801121d8,%eax
80102389:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010238b:	a1 d4 21 11 80       	mov    0x801121d4,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102390:	89 1d d8 21 11 80    	mov    %ebx,0x801121d8
  if(kmem.use_lock)
80102396:	85 c0                	test   %eax,%eax
80102398:	75 06                	jne    801023a0 <kfree+0x60>
    release(&kmem.lock);
}
8010239a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010239d:	c9                   	leave  
8010239e:	c3                   	ret    
8010239f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801023a0:	c7 45 08 a0 21 11 80 	movl   $0x801121a0,0x8(%ebp)
}
801023a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023aa:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801023ab:	e9 30 29 00 00       	jmp    80104ce0 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
801023b0:	83 ec 0c             	sub    $0xc,%esp
801023b3:	68 a0 21 11 80       	push   $0x801121a0
801023b8:	e8 43 27 00 00       	call   80104b00 <acquire>
801023bd:	83 c4 10             	add    $0x10,%esp
801023c0:	eb c2                	jmp    80102384 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
801023c2:	83 ec 0c             	sub    $0xc,%esp
801023c5:	68 da 7e 10 80       	push   $0x80107eda
801023ca:	e8 81 df ff ff       	call   80100350 <panic>
801023cf:	90                   	nop

801023d0 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801023d0:	55                   	push   %ebp
801023d1:	89 e5                	mov    %esp,%ebp
801023d3:	56                   	push   %esi
801023d4:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023d5:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801023d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023ed:	39 de                	cmp    %ebx,%esi
801023ef:	72 23                	jb     80102414 <freerange+0x44>
801023f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023f8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023fe:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102401:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102407:	50                   	push   %eax
80102408:	e8 33 ff ff ff       	call   80102340 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010240d:	83 c4 10             	add    $0x10,%esp
80102410:	39 f3                	cmp    %esi,%ebx
80102412:	76 e4                	jbe    801023f8 <freerange+0x28>
    kfree(p);
}
80102414:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102417:	5b                   	pop    %ebx
80102418:	5e                   	pop    %esi
80102419:	5d                   	pop    %ebp
8010241a:	c3                   	ret    
8010241b:	90                   	nop
8010241c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102420 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	56                   	push   %esi
80102424:	53                   	push   %ebx
80102425:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102428:	83 ec 08             	sub    $0x8,%esp
8010242b:	68 e0 7e 10 80       	push   $0x80107ee0
80102430:	68 a0 21 11 80       	push   $0x801121a0
80102435:	e8 a6 26 00 00       	call   80104ae0 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010243a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010243d:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102440:	c7 05 d4 21 11 80 00 	movl   $0x0,0x801121d4
80102447:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010244a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102450:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102456:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010245c:	39 de                	cmp    %ebx,%esi
8010245e:	72 1c                	jb     8010247c <kinit1+0x5c>
    kfree(p);
80102460:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102466:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102469:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010246f:	50                   	push   %eax
80102470:	e8 cb fe ff ff       	call   80102340 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102475:	83 c4 10             	add    $0x10,%esp
80102478:	39 de                	cmp    %ebx,%esi
8010247a:	73 e4                	jae    80102460 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010247c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010247f:	5b                   	pop    %ebx
80102480:	5e                   	pop    %esi
80102481:	5d                   	pop    %ebp
80102482:	c3                   	ret    
80102483:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102490 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	56                   	push   %esi
80102494:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102495:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102498:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010249b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024ad:	39 de                	cmp    %ebx,%esi
801024af:	72 23                	jb     801024d4 <kinit2+0x44>
801024b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024b8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024be:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024c7:	50                   	push   %eax
801024c8:	e8 73 fe ff ff       	call   80102340 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024cd:	83 c4 10             	add    $0x10,%esp
801024d0:	39 de                	cmp    %ebx,%esi
801024d2:	73 e4                	jae    801024b8 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
801024d4:	c7 05 d4 21 11 80 01 	movl   $0x1,0x801121d4
801024db:	00 00 00 
}
801024de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024e1:	5b                   	pop    %ebx
801024e2:	5e                   	pop    %esi
801024e3:	5d                   	pop    %ebp
801024e4:	c3                   	ret    
801024e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024f0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801024f0:	55                   	push   %ebp
801024f1:	89 e5                	mov    %esp,%ebp
801024f3:	53                   	push   %ebx
801024f4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
801024f7:	a1 d4 21 11 80       	mov    0x801121d4,%eax
801024fc:	85 c0                	test   %eax,%eax
801024fe:	75 30                	jne    80102530 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102500:	8b 1d d8 21 11 80    	mov    0x801121d8,%ebx
  if(r)
80102506:	85 db                	test   %ebx,%ebx
80102508:	74 1c                	je     80102526 <kalloc+0x36>
    kmem.freelist = r->next;
8010250a:	8b 13                	mov    (%ebx),%edx
8010250c:	89 15 d8 21 11 80    	mov    %edx,0x801121d8
  if(kmem.use_lock)
80102512:	85 c0                	test   %eax,%eax
80102514:	74 10                	je     80102526 <kalloc+0x36>
    release(&kmem.lock);
80102516:	83 ec 0c             	sub    $0xc,%esp
80102519:	68 a0 21 11 80       	push   $0x801121a0
8010251e:	e8 bd 27 00 00       	call   80104ce0 <release>
80102523:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
80102526:	89 d8                	mov    %ebx,%eax
80102528:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010252b:	c9                   	leave  
8010252c:	c3                   	ret    
8010252d:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102530:	83 ec 0c             	sub    $0xc,%esp
80102533:	68 a0 21 11 80       	push   $0x801121a0
80102538:	e8 c3 25 00 00       	call   80104b00 <acquire>
  r = kmem.freelist;
8010253d:	8b 1d d8 21 11 80    	mov    0x801121d8,%ebx
  if(r)
80102543:	83 c4 10             	add    $0x10,%esp
80102546:	a1 d4 21 11 80       	mov    0x801121d4,%eax
8010254b:	85 db                	test   %ebx,%ebx
8010254d:	75 bb                	jne    8010250a <kalloc+0x1a>
8010254f:	eb c1                	jmp    80102512 <kalloc+0x22>
80102551:	66 90                	xchg   %ax,%ax
80102553:	66 90                	xchg   %ax,%ax
80102555:	66 90                	xchg   %ax,%ax
80102557:	66 90                	xchg   %ax,%ax
80102559:	66 90                	xchg   %ax,%ax
8010255b:	66 90                	xchg   %ax,%ax
8010255d:	66 90                	xchg   %ax,%ax
8010255f:	90                   	nop

80102560 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102560:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102561:	ba 64 00 00 00       	mov    $0x64,%edx
80102566:	89 e5                	mov    %esp,%ebp
80102568:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102569:	a8 01                	test   $0x1,%al
8010256b:	0f 84 af 00 00 00    	je     80102620 <kbdgetc+0xc0>
80102571:	ba 60 00 00 00       	mov    $0x60,%edx
80102576:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102577:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010257a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102580:	74 7e                	je     80102600 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102582:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102584:	8b 0d b4 b5 10 80    	mov    0x8010b5b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010258a:	79 24                	jns    801025b0 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010258c:	f6 c1 40             	test   $0x40,%cl
8010258f:	75 05                	jne    80102596 <kbdgetc+0x36>
80102591:	89 c2                	mov    %eax,%edx
80102593:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102596:	0f b6 82 20 80 10 80 	movzbl -0x7fef7fe0(%edx),%eax
8010259d:	83 c8 40             	or     $0x40,%eax
801025a0:	0f b6 c0             	movzbl %al,%eax
801025a3:	f7 d0                	not    %eax
801025a5:	21 c8                	and    %ecx,%eax
801025a7:	a3 b4 b5 10 80       	mov    %eax,0x8010b5b4
    return 0;
801025ac:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025ae:	5d                   	pop    %ebp
801025af:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801025b0:	f6 c1 40             	test   $0x40,%cl
801025b3:	74 09                	je     801025be <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801025b5:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801025b8:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801025bb:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801025be:	0f b6 82 20 80 10 80 	movzbl -0x7fef7fe0(%edx),%eax
801025c5:	09 c1                	or     %eax,%ecx
801025c7:	0f b6 82 20 7f 10 80 	movzbl -0x7fef80e0(%edx),%eax
801025ce:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025d0:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801025d2:	89 0d b4 b5 10 80    	mov    %ecx,0x8010b5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801025d8:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025db:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
801025de:	8b 04 85 00 7f 10 80 	mov    -0x7fef8100(,%eax,4),%eax
801025e5:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025e9:	74 c3                	je     801025ae <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
801025eb:	8d 50 9f             	lea    -0x61(%eax),%edx
801025ee:	83 fa 19             	cmp    $0x19,%edx
801025f1:	77 1d                	ja     80102610 <kbdgetc+0xb0>
      c += 'A' - 'a';
801025f3:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025f6:	5d                   	pop    %ebp
801025f7:	c3                   	ret    
801025f8:	90                   	nop
801025f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102600:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102602:	83 0d b4 b5 10 80 40 	orl    $0x40,0x8010b5b4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102609:	5d                   	pop    %ebp
8010260a:	c3                   	ret    
8010260b:	90                   	nop
8010260c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102610:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102613:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
80102616:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
80102617:	83 f9 19             	cmp    $0x19,%ecx
8010261a:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
8010261d:	c3                   	ret    
8010261e:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80102620:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102625:	5d                   	pop    %ebp
80102626:	c3                   	ret    
80102627:	89 f6                	mov    %esi,%esi
80102629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102630 <kbdintr>:

void
kbdintr(void)
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102636:	68 60 25 10 80       	push   $0x80102560
8010263b:	e8 90 e1 ff ff       	call   801007d0 <consoleintr>
}
80102640:	83 c4 10             	add    $0x10,%esp
80102643:	c9                   	leave  
80102644:	c3                   	ret    
80102645:	66 90                	xchg   %ax,%ax
80102647:	66 90                	xchg   %ax,%ax
80102649:	66 90                	xchg   %ax,%ax
8010264b:	66 90                	xchg   %ax,%ax
8010264d:	66 90                	xchg   %ax,%ax
8010264f:	90                   	nop

80102650 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
  if(!lapic)
80102650:	a1 dc 21 11 80       	mov    0x801121dc,%eax
}
//PAGEBREAK!

void
lapicinit(void)
{
80102655:	55                   	push   %ebp
80102656:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102658:	85 c0                	test   %eax,%eax
8010265a:	0f 84 c8 00 00 00    	je     80102728 <lapicinit+0xd8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102660:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102667:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010266a:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010266d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102674:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102677:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010267a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102681:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102684:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102687:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010268e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102691:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102694:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010269b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010269e:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026a1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026a8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ab:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026ae:	8b 50 30             	mov    0x30(%eax),%edx
801026b1:	c1 ea 10             	shr    $0x10,%edx
801026b4:	80 fa 03             	cmp    $0x3,%dl
801026b7:	77 77                	ja     80102730 <lapicinit+0xe0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026b9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026c0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c3:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026c6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026cd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d0:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026d3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026da:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026dd:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026e0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026e7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026ea:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026ed:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026f4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026f7:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026fa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102701:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102704:	8b 50 20             	mov    0x20(%eax),%edx
80102707:	89 f6                	mov    %esi,%esi
80102709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102710:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102716:	80 e6 10             	and    $0x10,%dh
80102719:	75 f5                	jne    80102710 <lapicinit+0xc0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010271b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102722:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102725:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102728:	5d                   	pop    %ebp
80102729:	c3                   	ret    
8010272a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102730:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102737:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010273a:	8b 50 20             	mov    0x20(%eax),%edx
8010273d:	e9 77 ff ff ff       	jmp    801026b9 <lapicinit+0x69>
80102742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102750 <cpunum>:
  lapicw(TPR, 0);
}

int
cpunum(void)
{
80102750:	55                   	push   %ebp
80102751:	89 e5                	mov    %esp,%ebp
80102753:	56                   	push   %esi
80102754:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102755:	9c                   	pushf  
80102756:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102757:	f6 c4 02             	test   $0x2,%ah
8010275a:	74 12                	je     8010276e <cpunum+0x1e>
    static int n;
    if(n++ == 0)
8010275c:	a1 b8 b5 10 80       	mov    0x8010b5b8,%eax
80102761:	8d 50 01             	lea    0x1(%eax),%edx
80102764:	85 c0                	test   %eax,%eax
80102766:	89 15 b8 b5 10 80    	mov    %edx,0x8010b5b8
8010276c:	74 4d                	je     801027bb <cpunum+0x6b>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
8010276e:	a1 dc 21 11 80       	mov    0x801121dc,%eax
80102773:	85 c0                	test   %eax,%eax
80102775:	74 60                	je     801027d7 <cpunum+0x87>
    return 0;

  apicid = lapic[ID] >> 24;
80102777:	8b 58 20             	mov    0x20(%eax),%ebx
  for (i = 0; i < ncpu; ++i) {
8010277a:	8b 35 e0 28 11 80    	mov    0x801128e0,%esi
  }

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
80102780:	c1 eb 18             	shr    $0x18,%ebx
  for (i = 0; i < ncpu; ++i) {
80102783:	85 f6                	test   %esi,%esi
80102785:	7e 59                	jle    801027e0 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
80102787:	0f b6 05 e0 22 11 80 	movzbl 0x801122e0,%eax
8010278e:	39 c3                	cmp    %eax,%ebx
80102790:	74 45                	je     801027d7 <cpunum+0x87>
80102792:	ba a0 23 11 80       	mov    $0x801123a0,%edx
80102797:	31 c0                	xor    %eax,%eax
80102799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
801027a0:	83 c0 01             	add    $0x1,%eax
801027a3:	39 f0                	cmp    %esi,%eax
801027a5:	74 39                	je     801027e0 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
801027a7:	0f b6 0a             	movzbl (%edx),%ecx
801027aa:	81 c2 c0 00 00 00    	add    $0xc0,%edx
801027b0:	39 cb                	cmp    %ecx,%ebx
801027b2:	75 ec                	jne    801027a0 <cpunum+0x50>
      return i;
  }
  panic("unknown apicid\n");
}
801027b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027b7:	5b                   	pop    %ebx
801027b8:	5e                   	pop    %esi
801027b9:	5d                   	pop    %ebp
801027ba:	c3                   	ret    
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
801027bb:	83 ec 08             	sub    $0x8,%esp
801027be:	ff 75 04             	pushl  0x4(%ebp)
801027c1:	68 20 81 10 80       	push   $0x80108120
801027c6:	e8 75 de ff ff       	call   80100640 <cprintf>
        __builtin_return_address(0));
  }

  if (!lapic)
801027cb:	a1 dc 21 11 80       	mov    0x801121dc,%eax
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
801027d0:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if (!lapic)
801027d3:	85 c0                	test   %eax,%eax
801027d5:	75 a0                	jne    80102777 <cpunum+0x27>
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
}
801027d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
    return 0;
801027da:	31 c0                	xor    %eax,%eax
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
}
801027dc:	5b                   	pop    %ebx
801027dd:	5e                   	pop    %esi
801027de:	5d                   	pop    %ebp
801027df:	c3                   	ret    
  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
801027e0:	83 ec 0c             	sub    $0xc,%esp
801027e3:	68 4c 81 10 80       	push   $0x8010814c
801027e8:	e8 63 db ff ff       	call   80100350 <panic>
801027ed:	8d 76 00             	lea    0x0(%esi),%esi

801027f0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801027f0:	a1 dc 21 11 80       	mov    0x801121dc,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
801027f5:	55                   	push   %ebp
801027f6:	89 e5                	mov    %esp,%ebp
  if(lapic)
801027f8:	85 c0                	test   %eax,%eax
801027fa:	74 0d                	je     80102809 <lapiceoi+0x19>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027fc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102803:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102806:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102809:	5d                   	pop    %ebp
8010280a:	c3                   	ret    
8010280b:	90                   	nop
8010280c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102810 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102810:	55                   	push   %ebp
80102811:	89 e5                	mov    %esp,%ebp
}
80102813:	5d                   	pop    %ebp
80102814:	c3                   	ret    
80102815:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102820 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102820:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102821:	ba 70 00 00 00       	mov    $0x70,%edx
80102826:	b8 0f 00 00 00       	mov    $0xf,%eax
8010282b:	89 e5                	mov    %esp,%ebp
8010282d:	53                   	push   %ebx
8010282e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102831:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102834:	ee                   	out    %al,(%dx)
80102835:	ba 71 00 00 00       	mov    $0x71,%edx
8010283a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010283f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102840:	31 c0                	xor    %eax,%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102842:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102845:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010284b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010284d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102850:	c1 e8 04             	shr    $0x4,%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102853:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102855:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102858:	66 a3 69 04 00 80    	mov    %ax,0x80000469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010285e:	a1 dc 21 11 80       	mov    0x801121dc,%eax
80102863:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102869:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010286c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102873:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102876:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102879:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102880:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102883:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102886:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010288c:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010288f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102895:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102898:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010289e:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028a1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028a7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801028aa:	5b                   	pop    %ebx
801028ab:	5d                   	pop    %ebp
801028ac:	c3                   	ret    
801028ad:	8d 76 00             	lea    0x0(%esi),%esi

801028b0 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801028b0:	55                   	push   %ebp
801028b1:	ba 70 00 00 00       	mov    $0x70,%edx
801028b6:	b8 0b 00 00 00       	mov    $0xb,%eax
801028bb:	89 e5                	mov    %esp,%ebp
801028bd:	57                   	push   %edi
801028be:	56                   	push   %esi
801028bf:	53                   	push   %ebx
801028c0:	83 ec 4c             	sub    $0x4c,%esp
801028c3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028c4:	ba 71 00 00 00       	mov    $0x71,%edx
801028c9:	ec                   	in     (%dx),%al
801028ca:	83 e0 04             	and    $0x4,%eax
801028cd:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d0:	31 db                	xor    %ebx,%ebx
801028d2:	88 45 b7             	mov    %al,-0x49(%ebp)
801028d5:	bf 70 00 00 00       	mov    $0x70,%edi
801028da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801028e0:	89 d8                	mov    %ebx,%eax
801028e2:	89 fa                	mov    %edi,%edx
801028e4:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028e5:	b9 71 00 00 00       	mov    $0x71,%ecx
801028ea:	89 ca                	mov    %ecx,%edx
801028ec:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801028ed:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f0:	89 fa                	mov    %edi,%edx
801028f2:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028f5:	b8 02 00 00 00       	mov    $0x2,%eax
801028fa:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fb:	89 ca                	mov    %ecx,%edx
801028fd:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
801028fe:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102901:	89 fa                	mov    %edi,%edx
80102903:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102906:	b8 04 00 00 00       	mov    $0x4,%eax
8010290b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290c:	89 ca                	mov    %ecx,%edx
8010290e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
8010290f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102912:	89 fa                	mov    %edi,%edx
80102914:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102917:	b8 07 00 00 00       	mov    $0x7,%eax
8010291c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291d:	89 ca                	mov    %ecx,%edx
8010291f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102920:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102923:	89 fa                	mov    %edi,%edx
80102925:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102928:	b8 08 00 00 00       	mov    $0x8,%eax
8010292d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010292e:	89 ca                	mov    %ecx,%edx
80102930:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102931:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102934:	89 fa                	mov    %edi,%edx
80102936:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102939:	b8 09 00 00 00       	mov    $0x9,%eax
8010293e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010293f:	89 ca                	mov    %ecx,%edx
80102941:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102942:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102945:	89 fa                	mov    %edi,%edx
80102947:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010294a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010294f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102950:	89 ca                	mov    %ecx,%edx
80102952:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102953:	84 c0                	test   %al,%al
80102955:	78 89                	js     801028e0 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102957:	89 d8                	mov    %ebx,%eax
80102959:	89 fa                	mov    %edi,%edx
8010295b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010295c:	89 ca                	mov    %ecx,%edx
8010295e:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010295f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102962:	89 fa                	mov    %edi,%edx
80102964:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102967:	b8 02 00 00 00       	mov    $0x2,%eax
8010296c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010296d:	89 ca                	mov    %ecx,%edx
8010296f:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102970:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102973:	89 fa                	mov    %edi,%edx
80102975:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102978:	b8 04 00 00 00       	mov    $0x4,%eax
8010297d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010297e:	89 ca                	mov    %ecx,%edx
80102980:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102981:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102984:	89 fa                	mov    %edi,%edx
80102986:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102989:	b8 07 00 00 00       	mov    $0x7,%eax
8010298e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010298f:	89 ca                	mov    %ecx,%edx
80102991:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102992:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102995:	89 fa                	mov    %edi,%edx
80102997:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010299a:	b8 08 00 00 00       	mov    $0x8,%eax
8010299f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029a0:	89 ca                	mov    %ecx,%edx
801029a2:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
801029a3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029a6:	89 fa                	mov    %edi,%edx
801029a8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801029ab:	b8 09 00 00 00       	mov    $0x9,%eax
801029b0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029b1:	89 ca                	mov    %ecx,%edx
801029b3:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
801029b4:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029b7:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
801029ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029bd:	8d 45 b8             	lea    -0x48(%ebp),%eax
801029c0:	6a 18                	push   $0x18
801029c2:	56                   	push   %esi
801029c3:	50                   	push   %eax
801029c4:	e8 b7 23 00 00       	call   80104d80 <memcmp>
801029c9:	83 c4 10             	add    $0x10,%esp
801029cc:	85 c0                	test   %eax,%eax
801029ce:	0f 85 0c ff ff ff    	jne    801028e0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
801029d4:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
801029d8:	75 78                	jne    80102a52 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801029da:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029dd:	89 c2                	mov    %eax,%edx
801029df:	83 e0 0f             	and    $0xf,%eax
801029e2:	c1 ea 04             	shr    $0x4,%edx
801029e5:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029e8:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029eb:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801029ee:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029f1:	89 c2                	mov    %eax,%edx
801029f3:	83 e0 0f             	and    $0xf,%eax
801029f6:	c1 ea 04             	shr    $0x4,%edx
801029f9:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029fc:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ff:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a02:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a05:	89 c2                	mov    %eax,%edx
80102a07:	83 e0 0f             	and    $0xf,%eax
80102a0a:	c1 ea 04             	shr    $0x4,%edx
80102a0d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a10:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a13:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a16:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a19:	89 c2                	mov    %eax,%edx
80102a1b:	83 e0 0f             	and    $0xf,%eax
80102a1e:	c1 ea 04             	shr    $0x4,%edx
80102a21:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a24:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a27:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a2a:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a2d:	89 c2                	mov    %eax,%edx
80102a2f:	83 e0 0f             	and    $0xf,%eax
80102a32:	c1 ea 04             	shr    $0x4,%edx
80102a35:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a38:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a3b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a3e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a41:	89 c2                	mov    %eax,%edx
80102a43:	83 e0 0f             	and    $0xf,%eax
80102a46:	c1 ea 04             	shr    $0x4,%edx
80102a49:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a4c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a4f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a52:	8b 75 08             	mov    0x8(%ebp),%esi
80102a55:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a58:	89 06                	mov    %eax,(%esi)
80102a5a:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a5d:	89 46 04             	mov    %eax,0x4(%esi)
80102a60:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a63:	89 46 08             	mov    %eax,0x8(%esi)
80102a66:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a69:	89 46 0c             	mov    %eax,0xc(%esi)
80102a6c:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a6f:	89 46 10             	mov    %eax,0x10(%esi)
80102a72:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a75:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102a78:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a7f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a82:	5b                   	pop    %ebx
80102a83:	5e                   	pop    %esi
80102a84:	5f                   	pop    %edi
80102a85:	5d                   	pop    %ebp
80102a86:	c3                   	ret    
80102a87:	66 90                	xchg   %ax,%ax
80102a89:	66 90                	xchg   %ax,%ax
80102a8b:	66 90                	xchg   %ax,%ax
80102a8d:	66 90                	xchg   %ax,%ax
80102a8f:	90                   	nop

80102a90 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a90:	8b 0d 28 22 11 80    	mov    0x80112228,%ecx
80102a96:	85 c9                	test   %ecx,%ecx
80102a98:	0f 8e 85 00 00 00    	jle    80102b23 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102a9e:	55                   	push   %ebp
80102a9f:	89 e5                	mov    %esp,%ebp
80102aa1:	57                   	push   %edi
80102aa2:	56                   	push   %esi
80102aa3:	53                   	push   %ebx
80102aa4:	31 db                	xor    %ebx,%ebx
80102aa6:	83 ec 0c             	sub    $0xc,%esp
80102aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102ab0:	a1 14 22 11 80       	mov    0x80112214,%eax
80102ab5:	83 ec 08             	sub    $0x8,%esp
80102ab8:	01 d8                	add    %ebx,%eax
80102aba:	83 c0 01             	add    $0x1,%eax
80102abd:	50                   	push   %eax
80102abe:	ff 35 24 22 11 80    	pushl  0x80112224
80102ac4:	e8 f7 d5 ff ff       	call   801000c0 <bread>
80102ac9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102acb:	58                   	pop    %eax
80102acc:	5a                   	pop    %edx
80102acd:	ff 34 9d 2c 22 11 80 	pushl  -0x7feeddd4(,%ebx,4)
80102ad4:	ff 35 24 22 11 80    	pushl  0x80112224
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ada:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102add:	e8 de d5 ff ff       	call   801000c0 <bread>
80102ae2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102ae4:	8d 47 18             	lea    0x18(%edi),%eax
80102ae7:	83 c4 0c             	add    $0xc,%esp
80102aea:	68 00 02 00 00       	push   $0x200
80102aef:	50                   	push   %eax
80102af0:	8d 46 18             	lea    0x18(%esi),%eax
80102af3:	50                   	push   %eax
80102af4:	e8 e7 22 00 00       	call   80104de0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102af9:	89 34 24             	mov    %esi,(%esp)
80102afc:	e8 9f d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b01:	89 3c 24             	mov    %edi,(%esp)
80102b04:	e8 c7 d6 ff ff       	call   801001d0 <brelse>
    brelse(dbuf);
80102b09:	89 34 24             	mov    %esi,(%esp)
80102b0c:	e8 bf d6 ff ff       	call   801001d0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b11:	83 c4 10             	add    $0x10,%esp
80102b14:	39 1d 28 22 11 80    	cmp    %ebx,0x80112228
80102b1a:	7f 94                	jg     80102ab0 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102b1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b1f:	5b                   	pop    %ebx
80102b20:	5e                   	pop    %esi
80102b21:	5f                   	pop    %edi
80102b22:	5d                   	pop    %ebp
80102b23:	f3 c3                	repz ret 
80102b25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b30 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b30:	55                   	push   %ebp
80102b31:	89 e5                	mov    %esp,%ebp
80102b33:	53                   	push   %ebx
80102b34:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b37:	ff 35 14 22 11 80    	pushl  0x80112214
80102b3d:	ff 35 24 22 11 80    	pushl  0x80112224
80102b43:	e8 78 d5 ff ff       	call   801000c0 <bread>
80102b48:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b4a:	a1 28 22 11 80       	mov    0x80112228,%eax
  for (i = 0; i < log.lh.n; i++) {
80102b4f:	83 c4 10             	add    $0x10,%esp
80102b52:	31 d2                	xor    %edx,%edx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b54:	89 43 18             	mov    %eax,0x18(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102b57:	a1 28 22 11 80       	mov    0x80112228,%eax
80102b5c:	85 c0                	test   %eax,%eax
80102b5e:	7e 16                	jle    80102b76 <write_head+0x46>
    hb->block[i] = log.lh.block[i];
80102b60:	8b 0c 95 2c 22 11 80 	mov    -0x7feeddd4(,%edx,4),%ecx
80102b67:	89 4c 93 1c          	mov    %ecx,0x1c(%ebx,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102b6b:	83 c2 01             	add    $0x1,%edx
80102b6e:	39 15 28 22 11 80    	cmp    %edx,0x80112228
80102b74:	7f ea                	jg     80102b60 <write_head+0x30>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102b76:	83 ec 0c             	sub    $0xc,%esp
80102b79:	53                   	push   %ebx
80102b7a:	e8 21 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b7f:	89 1c 24             	mov    %ebx,(%esp)
80102b82:	e8 49 d6 ff ff       	call   801001d0 <brelse>
}
80102b87:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b8a:	c9                   	leave  
80102b8b:	c3                   	ret    
80102b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b90 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102b90:	55                   	push   %ebp
80102b91:	89 e5                	mov    %esp,%ebp
80102b93:	53                   	push   %ebx
80102b94:	83 ec 2c             	sub    $0x2c,%esp
80102b97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102b9a:	68 5c 81 10 80       	push   $0x8010815c
80102b9f:	68 e0 21 11 80       	push   $0x801121e0
80102ba4:	e8 37 1f 00 00       	call   80104ae0 <initlock>
  readsb(dev, &sb);
80102ba9:	58                   	pop    %eax
80102baa:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bad:	5a                   	pop    %edx
80102bae:	50                   	push   %eax
80102baf:	53                   	push   %ebx
80102bb0:	e8 3b e8 ff ff       	call   801013f0 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102bb5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102bb8:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102bbb:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102bbc:	89 1d 24 22 11 80    	mov    %ebx,0x80112224

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102bc2:	89 15 18 22 11 80    	mov    %edx,0x80112218
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102bc8:	a3 14 22 11 80       	mov    %eax,0x80112214

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102bcd:	5a                   	pop    %edx
80102bce:	50                   	push   %eax
80102bcf:	53                   	push   %ebx
80102bd0:	e8 eb d4 ff ff       	call   801000c0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102bd5:	8b 48 18             	mov    0x18(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102bd8:	83 c4 10             	add    $0x10,%esp
80102bdb:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102bdd:	89 0d 28 22 11 80    	mov    %ecx,0x80112228
  for (i = 0; i < log.lh.n; i++) {
80102be3:	7e 1c                	jle    80102c01 <initlog+0x71>
80102be5:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102bec:	31 d2                	xor    %edx,%edx
80102bee:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102bf0:	8b 4c 10 1c          	mov    0x1c(%eax,%edx,1),%ecx
80102bf4:	83 c2 04             	add    $0x4,%edx
80102bf7:	89 8a 28 22 11 80    	mov    %ecx,-0x7feeddd8(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102bfd:	39 da                	cmp    %ebx,%edx
80102bff:	75 ef                	jne    80102bf0 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102c01:	83 ec 0c             	sub    $0xc,%esp
80102c04:	50                   	push   %eax
80102c05:	e8 c6 d5 ff ff       	call   801001d0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c0a:	e8 81 fe ff ff       	call   80102a90 <install_trans>
  log.lh.n = 0;
80102c0f:	c7 05 28 22 11 80 00 	movl   $0x0,0x80112228
80102c16:	00 00 00 
  write_head(); // clear the log
80102c19:	e8 12 ff ff ff       	call   80102b30 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102c1e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c21:	c9                   	leave  
80102c22:	c3                   	ret    
80102c23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c30 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c30:	55                   	push   %ebp
80102c31:	89 e5                	mov    %esp,%ebp
80102c33:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102c36:	68 e0 21 11 80       	push   $0x801121e0
80102c3b:	e8 c0 1e 00 00       	call   80104b00 <acquire>
80102c40:	83 c4 10             	add    $0x10,%esp
80102c43:	eb 18                	jmp    80102c5d <begin_op+0x2d>
80102c45:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c48:	83 ec 08             	sub    $0x8,%esp
80102c4b:	68 e0 21 11 80       	push   $0x801121e0
80102c50:	68 e0 21 11 80       	push   $0x801121e0
80102c55:	e8 b6 14 00 00       	call   80104110 <sleep>
80102c5a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102c5d:	a1 20 22 11 80       	mov    0x80112220,%eax
80102c62:	85 c0                	test   %eax,%eax
80102c64:	75 e2                	jne    80102c48 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102c66:	a1 1c 22 11 80       	mov    0x8011221c,%eax
80102c6b:	8b 15 28 22 11 80    	mov    0x80112228,%edx
80102c71:	83 c0 01             	add    $0x1,%eax
80102c74:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c77:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c7a:	83 fa 1e             	cmp    $0x1e,%edx
80102c7d:	7f c9                	jg     80102c48 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c7f:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102c82:	a3 1c 22 11 80       	mov    %eax,0x8011221c
      release(&log.lock);
80102c87:	68 e0 21 11 80       	push   $0x801121e0
80102c8c:	e8 4f 20 00 00       	call   80104ce0 <release>
      break;
    }
  }
}
80102c91:	83 c4 10             	add    $0x10,%esp
80102c94:	c9                   	leave  
80102c95:	c3                   	ret    
80102c96:	8d 76 00             	lea    0x0(%esi),%esi
80102c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ca0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102ca0:	55                   	push   %ebp
80102ca1:	89 e5                	mov    %esp,%ebp
80102ca3:	57                   	push   %edi
80102ca4:	56                   	push   %esi
80102ca5:	53                   	push   %ebx
80102ca6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102ca9:	68 e0 21 11 80       	push   $0x801121e0
80102cae:	e8 4d 1e 00 00       	call   80104b00 <acquire>
  log.outstanding -= 1;
80102cb3:	a1 1c 22 11 80       	mov    0x8011221c,%eax
  if(log.committing)
80102cb8:	8b 1d 20 22 11 80    	mov    0x80112220,%ebx
80102cbe:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102cc1:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102cc4:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102cc6:	a3 1c 22 11 80       	mov    %eax,0x8011221c
  if(log.committing)
80102ccb:	0f 85 23 01 00 00    	jne    80102df4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102cd1:	85 c0                	test   %eax,%eax
80102cd3:	0f 85 f7 00 00 00    	jne    80102dd0 <end_op+0x130>
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102cd9:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102cdc:	c7 05 20 22 11 80 01 	movl   $0x1,0x80112220
80102ce3:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102ce6:	31 db                	xor    %ebx,%ebx
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102ce8:	68 e0 21 11 80       	push   $0x801121e0
80102ced:	e8 ee 1f 00 00       	call   80104ce0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102cf2:	8b 0d 28 22 11 80    	mov    0x80112228,%ecx
80102cf8:	83 c4 10             	add    $0x10,%esp
80102cfb:	85 c9                	test   %ecx,%ecx
80102cfd:	0f 8e 8a 00 00 00    	jle    80102d8d <end_op+0xed>
80102d03:	90                   	nop
80102d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d08:	a1 14 22 11 80       	mov    0x80112214,%eax
80102d0d:	83 ec 08             	sub    $0x8,%esp
80102d10:	01 d8                	add    %ebx,%eax
80102d12:	83 c0 01             	add    $0x1,%eax
80102d15:	50                   	push   %eax
80102d16:	ff 35 24 22 11 80    	pushl  0x80112224
80102d1c:	e8 9f d3 ff ff       	call   801000c0 <bread>
80102d21:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d23:	58                   	pop    %eax
80102d24:	5a                   	pop    %edx
80102d25:	ff 34 9d 2c 22 11 80 	pushl  -0x7feeddd4(,%ebx,4)
80102d2c:	ff 35 24 22 11 80    	pushl  0x80112224
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d32:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d35:	e8 86 d3 ff ff       	call   801000c0 <bread>
80102d3a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d3c:	8d 40 18             	lea    0x18(%eax),%eax
80102d3f:	83 c4 0c             	add    $0xc,%esp
80102d42:	68 00 02 00 00       	push   $0x200
80102d47:	50                   	push   %eax
80102d48:	8d 46 18             	lea    0x18(%esi),%eax
80102d4b:	50                   	push   %eax
80102d4c:	e8 8f 20 00 00       	call   80104de0 <memmove>
    bwrite(to);  // write the log
80102d51:	89 34 24             	mov    %esi,(%esp)
80102d54:	e8 47 d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d59:	89 3c 24             	mov    %edi,(%esp)
80102d5c:	e8 6f d4 ff ff       	call   801001d0 <brelse>
    brelse(to);
80102d61:	89 34 24             	mov    %esi,(%esp)
80102d64:	e8 67 d4 ff ff       	call   801001d0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d69:	83 c4 10             	add    $0x10,%esp
80102d6c:	3b 1d 28 22 11 80    	cmp    0x80112228,%ebx
80102d72:	7c 94                	jl     80102d08 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d74:	e8 b7 fd ff ff       	call   80102b30 <write_head>
    install_trans(); // Now install writes to home locations
80102d79:	e8 12 fd ff ff       	call   80102a90 <install_trans>
    log.lh.n = 0;
80102d7e:	c7 05 28 22 11 80 00 	movl   $0x0,0x80112228
80102d85:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d88:	e8 a3 fd ff ff       	call   80102b30 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102d8d:	83 ec 0c             	sub    $0xc,%esp
80102d90:	68 e0 21 11 80       	push   $0x801121e0
80102d95:	e8 66 1d 00 00       	call   80104b00 <acquire>
    log.committing = 0;
    wakeup(&log);
80102d9a:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102da1:	c7 05 20 22 11 80 00 	movl   $0x0,0x80112220
80102da8:	00 00 00 
    wakeup(&log);
80102dab:	e8 d0 15 00 00       	call   80104380 <wakeup>
    release(&log.lock);
80102db0:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80102db7:	e8 24 1f 00 00       	call   80104ce0 <release>
80102dbc:	83 c4 10             	add    $0x10,%esp
  }
}
80102dbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102dc2:	5b                   	pop    %ebx
80102dc3:	5e                   	pop    %esi
80102dc4:	5f                   	pop    %edi
80102dc5:	5d                   	pop    %ebp
80102dc6:	c3                   	ret    
80102dc7:	89 f6                	mov    %esi,%esi
80102dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
80102dd0:	83 ec 0c             	sub    $0xc,%esp
80102dd3:	68 e0 21 11 80       	push   $0x801121e0
80102dd8:	e8 a3 15 00 00       	call   80104380 <wakeup>
  }
  release(&log.lock);
80102ddd:	c7 04 24 e0 21 11 80 	movl   $0x801121e0,(%esp)
80102de4:	e8 f7 1e 00 00       	call   80104ce0 <release>
80102de9:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102dec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102def:	5b                   	pop    %ebx
80102df0:	5e                   	pop    %esi
80102df1:	5f                   	pop    %edi
80102df2:	5d                   	pop    %ebp
80102df3:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102df4:	83 ec 0c             	sub    $0xc,%esp
80102df7:	68 60 81 10 80       	push   $0x80108160
80102dfc:	e8 4f d5 ff ff       	call   80100350 <panic>
80102e01:	eb 0d                	jmp    80102e10 <log_write>
80102e03:	90                   	nop
80102e04:	90                   	nop
80102e05:	90                   	nop
80102e06:	90                   	nop
80102e07:	90                   	nop
80102e08:	90                   	nop
80102e09:	90                   	nop
80102e0a:	90                   	nop
80102e0b:	90                   	nop
80102e0c:	90                   	nop
80102e0d:	90                   	nop
80102e0e:	90                   	nop
80102e0f:	90                   	nop

80102e10 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	53                   	push   %ebx
80102e14:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e17:	8b 15 28 22 11 80    	mov    0x80112228,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e1d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e20:	83 fa 1d             	cmp    $0x1d,%edx
80102e23:	0f 8f 97 00 00 00    	jg     80102ec0 <log_write+0xb0>
80102e29:	a1 18 22 11 80       	mov    0x80112218,%eax
80102e2e:	83 e8 01             	sub    $0x1,%eax
80102e31:	39 c2                	cmp    %eax,%edx
80102e33:	0f 8d 87 00 00 00    	jge    80102ec0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e39:	a1 1c 22 11 80       	mov    0x8011221c,%eax
80102e3e:	85 c0                	test   %eax,%eax
80102e40:	0f 8e 87 00 00 00    	jle    80102ecd <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e46:	83 ec 0c             	sub    $0xc,%esp
80102e49:	68 e0 21 11 80       	push   $0x801121e0
80102e4e:	e8 ad 1c 00 00       	call   80104b00 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e53:	8b 15 28 22 11 80    	mov    0x80112228,%edx
80102e59:	83 c4 10             	add    $0x10,%esp
80102e5c:	83 fa 00             	cmp    $0x0,%edx
80102e5f:	7e 50                	jle    80102eb1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e61:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102e64:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e66:	3b 0d 2c 22 11 80    	cmp    0x8011222c,%ecx
80102e6c:	75 0b                	jne    80102e79 <log_write+0x69>
80102e6e:	eb 38                	jmp    80102ea8 <log_write+0x98>
80102e70:	39 0c 85 2c 22 11 80 	cmp    %ecx,-0x7feeddd4(,%eax,4)
80102e77:	74 2f                	je     80102ea8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102e79:	83 c0 01             	add    $0x1,%eax
80102e7c:	39 d0                	cmp    %edx,%eax
80102e7e:	75 f0                	jne    80102e70 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102e80:	89 0c 95 2c 22 11 80 	mov    %ecx,-0x7feeddd4(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e87:	83 c2 01             	add    $0x1,%edx
80102e8a:	89 15 28 22 11 80    	mov    %edx,0x80112228
  b->flags |= B_DIRTY; // prevent eviction
80102e90:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e93:	c7 45 08 e0 21 11 80 	movl   $0x801121e0,0x8(%ebp)
}
80102e9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e9d:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102e9e:	e9 3d 1e 00 00       	jmp    80104ce0 <release>
80102ea3:	90                   	nop
80102ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102ea8:	89 0c 85 2c 22 11 80 	mov    %ecx,-0x7feeddd4(,%eax,4)
80102eaf:	eb df                	jmp    80102e90 <log_write+0x80>
80102eb1:	8b 43 08             	mov    0x8(%ebx),%eax
80102eb4:	a3 2c 22 11 80       	mov    %eax,0x8011222c
  if (i == log.lh.n)
80102eb9:	75 d5                	jne    80102e90 <log_write+0x80>
80102ebb:	eb ca                	jmp    80102e87 <log_write+0x77>
80102ebd:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102ec0:	83 ec 0c             	sub    $0xc,%esp
80102ec3:	68 6f 81 10 80       	push   $0x8010816f
80102ec8:	e8 83 d4 ff ff       	call   80100350 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102ecd:	83 ec 0c             	sub    $0xc,%esp
80102ed0:	68 85 81 10 80       	push   $0x80108185
80102ed5:	e8 76 d4 ff ff       	call   80100350 <panic>
80102eda:	66 90                	xchg   %ax,%ax
80102edc:	66 90                	xchg   %ax,%ax
80102ede:	66 90                	xchg   %ax,%ax

80102ee0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102ee0:	55                   	push   %ebp
80102ee1:	89 e5                	mov    %esp,%ebp
80102ee3:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpunum());
80102ee6:	e8 65 f8 ff ff       	call   80102750 <cpunum>
80102eeb:	83 ec 08             	sub    $0x8,%esp
80102eee:	50                   	push   %eax
80102eef:	68 a0 81 10 80       	push   $0x801081a0
80102ef4:	e8 47 d7 ff ff       	call   80100640 <cprintf>
  idtinit();       // load idt register
80102ef9:	e8 e2 32 00 00       	call   801061e0 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80102efe:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f05:	b8 01 00 00 00       	mov    $0x1,%eax
80102f0a:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
80102f11:	e8 7a 0e 00 00       	call   80103d90 <scheduler>
80102f16:	8d 76 00             	lea    0x0(%esi),%esi
80102f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f20 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f26:	e8 05 45 00 00       	call   80107430 <switchkvm>
  seginit();
80102f2b:	e8 20 43 00 00       	call   80107250 <seginit>
  lapicinit();
80102f30:	e8 1b f7 ff ff       	call   80102650 <lapicinit>
  mpmain();
80102f35:	e8 a6 ff ff ff       	call   80102ee0 <mpmain>
80102f3a:	66 90                	xchg   %ax,%ax
80102f3c:	66 90                	xchg   %ax,%ax
80102f3e:	66 90                	xchg   %ax,%ax

80102f40 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102f40:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102f44:	83 e4 f0             	and    $0xfffffff0,%esp
80102f47:	ff 71 fc             	pushl  -0x4(%ecx)
80102f4a:	55                   	push   %ebp
80102f4b:	89 e5                	mov    %esp,%ebp
80102f4d:	53                   	push   %ebx
80102f4e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f4f:	83 ec 08             	sub    $0x8,%esp
80102f52:	68 00 00 40 80       	push   $0x80400000
80102f57:	68 40 cc 12 80       	push   $0x8012cc40
80102f5c:	e8 bf f4 ff ff       	call   80102420 <kinit1>
  kvmalloc();      // kernel page table
80102f61:	e8 aa 44 00 00       	call   80107410 <kvmalloc>
  mpinit();        // detect other processors
80102f66:	e8 b5 01 00 00       	call   80103120 <mpinit>
  lapicinit();     // interrupt controller
80102f6b:	e8 e0 f6 ff ff       	call   80102650 <lapicinit>
  seginit();       // segment descriptors
80102f70:	e8 db 42 00 00       	call   80107250 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80102f75:	e8 d6 f7 ff ff       	call   80102750 <cpunum>
80102f7a:	5a                   	pop    %edx
80102f7b:	59                   	pop    %ecx
80102f7c:	50                   	push   %eax
80102f7d:	68 b1 81 10 80       	push   $0x801081b1
80102f82:	e8 b9 d6 ff ff       	call   80100640 <cprintf>
  picinit();       // another interrupt controller
80102f87:	e8 a4 03 00 00       	call   80103330 <picinit>
  ioapicinit();    // another interrupt controller
80102f8c:	e8 af f2 ff ff       	call   80102240 <ioapicinit>
  consoleinit();   // console hardware
80102f91:	e8 ea d9 ff ff       	call   80100980 <consoleinit>
  uartinit();      // serial port
80102f96:	e8 05 36 00 00       	call   801065a0 <uartinit>
  pinit();         // process table
80102f9b:	e8 70 08 00 00       	call   80103810 <pinit>
  tvinit();        // trap vectors
80102fa0:	e8 9b 31 00 00       	call   80106140 <tvinit>
  binit();         // buffer cache
80102fa5:	e8 96 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102faa:	e8 f1 dd ff ff       	call   80100da0 <fileinit>
  ideinit();       // disk
80102faf:	e8 6c f0 ff ff       	call   80102020 <ideinit>
  if(!ismp)
80102fb4:	8b 1d c4 22 11 80    	mov    0x801122c4,%ebx
80102fba:	83 c4 10             	add    $0x10,%esp
80102fbd:	85 db                	test   %ebx,%ebx
80102fbf:	0f 84 cb 00 00 00    	je     80103090 <main+0x150>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fc5:	83 ec 04             	sub    $0x4,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80102fc8:	bb e0 22 11 80       	mov    $0x801122e0,%ebx

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fcd:	68 8a 00 00 00       	push   $0x8a
80102fd2:	68 8c b4 10 80       	push   $0x8010b48c
80102fd7:	68 00 70 00 80       	push   $0x80007000
80102fdc:	e8 ff 1d 00 00       	call   80104de0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102fe1:	a1 e0 28 11 80       	mov    0x801128e0,%eax
80102fe6:	83 c4 10             	add    $0x10,%esp
80102fe9:	8d 04 40             	lea    (%eax,%eax,2),%eax
80102fec:	c1 e0 06             	shl    $0x6,%eax
80102fef:	05 e0 22 11 80       	add    $0x801122e0,%eax
80102ff4:	39 d8                	cmp    %ebx,%eax
80102ff6:	76 7c                	jbe    80103074 <main+0x134>
80102ff8:	90                   	nop
80102ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(c == cpus+cpunum())  // We've started already.
80103000:	e8 4b f7 ff ff       	call   80102750 <cpunum>
80103005:	8d 04 40             	lea    (%eax,%eax,2),%eax
80103008:	c1 e0 06             	shl    $0x6,%eax
8010300b:	05 e0 22 11 80       	add    $0x801122e0,%eax
80103010:	39 c3                	cmp    %eax,%ebx
80103012:	74 46                	je     8010305a <main+0x11a>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103014:	e8 d7 f4 ff ff       	call   801024f0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103019:	83 ec 08             	sub    $0x8,%esp

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
8010301c:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80103021:	c7 05 f8 6f 00 80 20 	movl   $0x80102f20,0x80006ff8
80103028:	2f 10 80 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
8010302b:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103030:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80103037:	a0 10 00 

    lapicstartap(c->apicid, V2P(code));
8010303a:	68 00 70 00 00       	push   $0x7000
8010303f:	0f b6 03             	movzbl (%ebx),%eax
80103042:	50                   	push   %eax
80103043:	e8 d8 f7 ff ff       	call   80102820 <lapicstartap>
80103048:	83 c4 10             	add    $0x10,%esp
8010304b:	90                   	nop
8010304c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103050:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
80103056:	85 c0                	test   %eax,%eax
80103058:	74 f6                	je     80103050 <main+0x110>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010305a:	a1 e0 28 11 80       	mov    0x801128e0,%eax
8010305f:	81 c3 c0 00 00 00    	add    $0xc0,%ebx
80103065:	8d 04 40             	lea    (%eax,%eax,2),%eax
80103068:	c1 e0 06             	shl    $0x6,%eax
8010306b:	05 e0 22 11 80       	add    $0x801122e0,%eax
80103070:	39 c3                	cmp    %eax,%ebx
80103072:	72 8c                	jb     80103000 <main+0xc0>
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103074:	83 ec 08             	sub    $0x8,%esp
80103077:	68 00 00 00 8e       	push   $0x8e000000
8010307c:	68 00 00 40 80       	push   $0x80400000
80103081:	e8 0a f4 ff ff       	call   80102490 <kinit2>
  userinit();      // first user process
80103086:	e8 65 09 00 00       	call   801039f0 <userinit>
  mpmain();        // finish this processor's setup
8010308b:	e8 50 fe ff ff       	call   80102ee0 <mpmain>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
80103090:	e8 4b 30 00 00       	call   801060e0 <timerinit>
80103095:	e9 2b ff ff ff       	jmp    80102fc5 <main+0x85>
8010309a:	66 90                	xchg   %ax,%ax
8010309c:	66 90                	xchg   %ax,%ax
8010309e:	66 90                	xchg   %ax,%ax

801030a0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030a0:	55                   	push   %ebp
801030a1:	89 e5                	mov    %esp,%ebp
801030a3:	57                   	push   %edi
801030a4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801030a5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030ab:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
801030ac:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030af:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801030b2:	39 de                	cmp    %ebx,%esi
801030b4:	73 48                	jae    801030fe <mpsearch1+0x5e>
801030b6:	8d 76 00             	lea    0x0(%esi),%esi
801030b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030c0:	83 ec 04             	sub    $0x4,%esp
801030c3:	8d 7e 10             	lea    0x10(%esi),%edi
801030c6:	6a 04                	push   $0x4
801030c8:	68 c8 81 10 80       	push   $0x801081c8
801030cd:	56                   	push   %esi
801030ce:	e8 ad 1c 00 00       	call   80104d80 <memcmp>
801030d3:	83 c4 10             	add    $0x10,%esp
801030d6:	85 c0                	test   %eax,%eax
801030d8:	75 1e                	jne    801030f8 <mpsearch1+0x58>
801030da:	8d 7e 10             	lea    0x10(%esi),%edi
801030dd:	89 f2                	mov    %esi,%edx
801030df:	31 c9                	xor    %ecx,%ecx
801030e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
801030e8:	0f b6 02             	movzbl (%edx),%eax
801030eb:	83 c2 01             	add    $0x1,%edx
801030ee:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030f0:	39 fa                	cmp    %edi,%edx
801030f2:	75 f4                	jne    801030e8 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030f4:	84 c9                	test   %cl,%cl
801030f6:	74 10                	je     80103108 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801030f8:	39 fb                	cmp    %edi,%ebx
801030fa:	89 fe                	mov    %edi,%esi
801030fc:	77 c2                	ja     801030c0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
801030fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103101:	31 c0                	xor    %eax,%eax
}
80103103:	5b                   	pop    %ebx
80103104:	5e                   	pop    %esi
80103105:	5f                   	pop    %edi
80103106:	5d                   	pop    %ebp
80103107:	c3                   	ret    
80103108:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010310b:	89 f0                	mov    %esi,%eax
8010310d:	5b                   	pop    %ebx
8010310e:	5e                   	pop    %esi
8010310f:	5f                   	pop    %edi
80103110:	5d                   	pop    %ebp
80103111:	c3                   	ret    
80103112:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103120 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103120:	55                   	push   %ebp
80103121:	89 e5                	mov    %esp,%ebp
80103123:	57                   	push   %edi
80103124:	56                   	push   %esi
80103125:	53                   	push   %ebx
80103126:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103129:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103130:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103137:	c1 e0 08             	shl    $0x8,%eax
8010313a:	09 d0                	or     %edx,%eax
8010313c:	c1 e0 04             	shl    $0x4,%eax
8010313f:	85 c0                	test   %eax,%eax
80103141:	75 1b                	jne    8010315e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103143:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010314a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103151:	c1 e0 08             	shl    $0x8,%eax
80103154:	09 d0                	or     %edx,%eax
80103156:	c1 e0 0a             	shl    $0xa,%eax
80103159:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010315e:	ba 00 04 00 00       	mov    $0x400,%edx
80103163:	e8 38 ff ff ff       	call   801030a0 <mpsearch1>
80103168:	85 c0                	test   %eax,%eax
8010316a:	89 c6                	mov    %eax,%esi
8010316c:	0f 84 66 01 00 00    	je     801032d8 <mpinit+0x1b8>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103172:	8b 5e 04             	mov    0x4(%esi),%ebx
80103175:	85 db                	test   %ebx,%ebx
80103177:	0f 84 d6 00 00 00    	je     80103253 <mpinit+0x133>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010317d:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103183:	83 ec 04             	sub    $0x4,%esp
80103186:	6a 04                	push   $0x4
80103188:	68 cd 81 10 80       	push   $0x801081cd
8010318d:	50                   	push   %eax
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010318e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103191:	e8 ea 1b 00 00       	call   80104d80 <memcmp>
80103196:	83 c4 10             	add    $0x10,%esp
80103199:	85 c0                	test   %eax,%eax
8010319b:	0f 85 b2 00 00 00    	jne    80103253 <mpinit+0x133>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801031a1:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801031a8:	3c 01                	cmp    $0x1,%al
801031aa:	74 08                	je     801031b4 <mpinit+0x94>
801031ac:	3c 04                	cmp    $0x4,%al
801031ae:	0f 85 9f 00 00 00    	jne    80103253 <mpinit+0x133>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801031b4:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031bb:	85 ff                	test   %edi,%edi
801031bd:	74 1e                	je     801031dd <mpinit+0xbd>
801031bf:	31 d2                	xor    %edx,%edx
801031c1:	31 c0                	xor    %eax,%eax
801031c3:	90                   	nop
801031c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801031c8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801031cf:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031d0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801031d3:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031d5:	39 c7                	cmp    %eax,%edi
801031d7:	75 ef                	jne    801031c8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801031d9:	84 d2                	test   %dl,%dl
801031db:	75 76                	jne    80103253 <mpinit+0x133>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801031dd:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801031e0:	85 ff                	test   %edi,%edi
801031e2:	74 6f                	je     80103253 <mpinit+0x133>
    return;
  ismp = 1;
801031e4:	c7 05 c4 22 11 80 01 	movl   $0x1,0x801122c4
801031eb:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
801031ee:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801031f4:	a3 dc 21 11 80       	mov    %eax,0x801121dc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031f9:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
80103200:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80103206:	01 f9                	add    %edi,%ecx
80103208:	39 c8                	cmp    %ecx,%eax
8010320a:	0f 83 a0 00 00 00    	jae    801032b0 <mpinit+0x190>
    switch(*p){
80103210:	80 38 04             	cmpb   $0x4,(%eax)
80103213:	0f 87 87 00 00 00    	ja     801032a0 <mpinit+0x180>
80103219:	0f b6 10             	movzbl (%eax),%edx
8010321c:	ff 24 95 d4 81 10 80 	jmp    *-0x7fef7e2c(,%edx,4)
80103223:	90                   	nop
80103224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103228:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010322b:	39 c1                	cmp    %eax,%ecx
8010322d:	77 e1                	ja     80103210 <mpinit+0xf0>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
8010322f:	a1 c4 22 11 80       	mov    0x801122c4,%eax
80103234:	85 c0                	test   %eax,%eax
80103236:	75 78                	jne    801032b0 <mpinit+0x190>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103238:	c7 05 e0 28 11 80 01 	movl   $0x1,0x801128e0
8010323f:	00 00 00 
    lapic = 0;
80103242:	c7 05 dc 21 11 80 00 	movl   $0x0,0x801121dc
80103249:	00 00 00 
    ioapicid = 0;
8010324c:	c6 05 c0 22 11 80 00 	movb   $0x0,0x801122c0
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103253:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103256:	5b                   	pop    %ebx
80103257:	5e                   	pop    %esi
80103258:	5f                   	pop    %edi
80103259:	5d                   	pop    %ebp
8010325a:	c3                   	ret    
8010325b:	90                   	nop
8010325c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103260:	8b 15 e0 28 11 80    	mov    0x801128e0,%edx
80103266:	83 fa 07             	cmp    $0x7,%edx
80103269:	7f 19                	jg     80103284 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010326b:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
8010326f:	8d 3c 52             	lea    (%edx,%edx,2),%edi
        ncpu++;
80103272:	83 c2 01             	add    $0x1,%edx
80103275:	89 15 e0 28 11 80    	mov    %edx,0x801128e0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010327b:	c1 e7 06             	shl    $0x6,%edi
8010327e:	88 9f e0 22 11 80    	mov    %bl,-0x7feedd20(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
80103284:	83 c0 14             	add    $0x14,%eax
      continue;
80103287:	eb a2                	jmp    8010322b <mpinit+0x10b>
80103289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103290:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
80103294:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103297:	88 15 c0 22 11 80    	mov    %dl,0x801122c0
      p += sizeof(struct mpioapic);
      continue;
8010329d:	eb 8c                	jmp    8010322b <mpinit+0x10b>
8010329f:	90                   	nop
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801032a0:	c7 05 c4 22 11 80 00 	movl   $0x0,0x801122c4
801032a7:	00 00 00 
      break;
801032aa:	e9 7c ff ff ff       	jmp    8010322b <mpinit+0x10b>
801032af:	90                   	nop
    lapic = 0;
    ioapicid = 0;
    return;
  }

  if(mp->imcrp){
801032b0:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
801032b4:	74 9d                	je     80103253 <mpinit+0x133>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032b6:	ba 22 00 00 00       	mov    $0x22,%edx
801032bb:	b8 70 00 00 00       	mov    $0x70,%eax
801032c0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032c1:	ba 23 00 00 00       	mov    $0x23,%edx
801032c6:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032c7:	83 c8 01             	or     $0x1,%eax
801032ca:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
801032cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032ce:	5b                   	pop    %ebx
801032cf:	5e                   	pop    %esi
801032d0:	5f                   	pop    %edi
801032d1:	5d                   	pop    %ebp
801032d2:	c3                   	ret    
801032d3:	90                   	nop
801032d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801032d8:	ba 00 00 01 00       	mov    $0x10000,%edx
801032dd:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801032e2:	e8 b9 fd ff ff       	call   801030a0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032e7:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801032e9:	89 c6                	mov    %eax,%esi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032eb:	0f 85 81 fe ff ff    	jne    80103172 <mpinit+0x52>
801032f1:	e9 5d ff ff ff       	jmp    80103253 <mpinit+0x133>
801032f6:	66 90                	xchg   %ax,%ax
801032f8:	66 90                	xchg   %ax,%ax
801032fa:	66 90                	xchg   %ax,%ax
801032fc:	66 90                	xchg   %ax,%ax
801032fe:	66 90                	xchg   %ax,%ax

80103300 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
80103300:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
80103301:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80103306:	ba 21 00 00 00       	mov    $0x21,%edx
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
8010330b:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
8010330d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103310:	d3 c0                	rol    %cl,%eax
80103312:	66 23 05 00 b0 10 80 	and    0x8010b000,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  irqmask = mask;
80103319:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
8010331f:	ee                   	out    %al,(%dx)
80103320:	ba a1 00 00 00       	mov    $0xa1,%edx
80103325:	66 c1 e8 08          	shr    $0x8,%ax
80103329:	ee                   	out    %al,(%dx)

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
}
8010332a:	5d                   	pop    %ebp
8010332b:	c3                   	ret    
8010332c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103330 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103330:	55                   	push   %ebp
80103331:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103336:	89 e5                	mov    %esp,%ebp
80103338:	57                   	push   %edi
80103339:	56                   	push   %esi
8010333a:	53                   	push   %ebx
8010333b:	bb 21 00 00 00       	mov    $0x21,%ebx
80103340:	89 da                	mov    %ebx,%edx
80103342:	ee                   	out    %al,(%dx)
80103343:	b9 a1 00 00 00       	mov    $0xa1,%ecx
80103348:	89 ca                	mov    %ecx,%edx
8010334a:	ee                   	out    %al,(%dx)
8010334b:	bf 11 00 00 00       	mov    $0x11,%edi
80103350:	be 20 00 00 00       	mov    $0x20,%esi
80103355:	89 f8                	mov    %edi,%eax
80103357:	89 f2                	mov    %esi,%edx
80103359:	ee                   	out    %al,(%dx)
8010335a:	b8 20 00 00 00       	mov    $0x20,%eax
8010335f:	89 da                	mov    %ebx,%edx
80103361:	ee                   	out    %al,(%dx)
80103362:	b8 04 00 00 00       	mov    $0x4,%eax
80103367:	ee                   	out    %al,(%dx)
80103368:	b8 03 00 00 00       	mov    $0x3,%eax
8010336d:	ee                   	out    %al,(%dx)
8010336e:	bb a0 00 00 00       	mov    $0xa0,%ebx
80103373:	89 f8                	mov    %edi,%eax
80103375:	89 da                	mov    %ebx,%edx
80103377:	ee                   	out    %al,(%dx)
80103378:	b8 28 00 00 00       	mov    $0x28,%eax
8010337d:	89 ca                	mov    %ecx,%edx
8010337f:	ee                   	out    %al,(%dx)
80103380:	b8 02 00 00 00       	mov    $0x2,%eax
80103385:	ee                   	out    %al,(%dx)
80103386:	b8 03 00 00 00       	mov    $0x3,%eax
8010338b:	ee                   	out    %al,(%dx)
8010338c:	bf 68 00 00 00       	mov    $0x68,%edi
80103391:	89 f2                	mov    %esi,%edx
80103393:	89 f8                	mov    %edi,%eax
80103395:	ee                   	out    %al,(%dx)
80103396:	b9 0a 00 00 00       	mov    $0xa,%ecx
8010339b:	89 c8                	mov    %ecx,%eax
8010339d:	ee                   	out    %al,(%dx)
8010339e:	89 f8                	mov    %edi,%eax
801033a0:	89 da                	mov    %ebx,%edx
801033a2:	ee                   	out    %al,(%dx)
801033a3:	89 c8                	mov    %ecx,%eax
801033a5:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
801033a6:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
801033ad:	66 83 f8 ff          	cmp    $0xffff,%ax
801033b1:	74 10                	je     801033c3 <picinit+0x93>
801033b3:	ba 21 00 00 00       	mov    $0x21,%edx
801033b8:	ee                   	out    %al,(%dx)
801033b9:	ba a1 00 00 00       	mov    $0xa1,%edx
801033be:	66 c1 e8 08          	shr    $0x8,%ax
801033c2:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
801033c3:	5b                   	pop    %ebx
801033c4:	5e                   	pop    %esi
801033c5:	5f                   	pop    %edi
801033c6:	5d                   	pop    %ebp
801033c7:	c3                   	ret    
801033c8:	66 90                	xchg   %ax,%ax
801033ca:	66 90                	xchg   %ax,%ax
801033cc:	66 90                	xchg   %ax,%ax
801033ce:	66 90                	xchg   %ax,%ax

801033d0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033d0:	55                   	push   %ebp
801033d1:	89 e5                	mov    %esp,%ebp
801033d3:	57                   	push   %edi
801033d4:	56                   	push   %esi
801033d5:	53                   	push   %ebx
801033d6:	83 ec 0c             	sub    $0xc,%esp
801033d9:	8b 75 08             	mov    0x8(%ebp),%esi
801033dc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033df:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801033e5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801033eb:	e8 d0 d9 ff ff       	call   80100dc0 <filealloc>
801033f0:	85 c0                	test   %eax,%eax
801033f2:	89 06                	mov    %eax,(%esi)
801033f4:	0f 84 a8 00 00 00    	je     801034a2 <pipealloc+0xd2>
801033fa:	e8 c1 d9 ff ff       	call   80100dc0 <filealloc>
801033ff:	85 c0                	test   %eax,%eax
80103401:	89 03                	mov    %eax,(%ebx)
80103403:	0f 84 87 00 00 00    	je     80103490 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103409:	e8 e2 f0 ff ff       	call   801024f0 <kalloc>
8010340e:	85 c0                	test   %eax,%eax
80103410:	89 c7                	mov    %eax,%edi
80103412:	0f 84 b0 00 00 00    	je     801034c8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103418:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010341b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103422:	00 00 00 
  p->writeopen = 1;
80103425:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010342c:	00 00 00 
  p->nwrite = 0;
8010342f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103436:	00 00 00 
  p->nread = 0;
80103439:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103440:	00 00 00 
  initlock(&p->lock, "pipe");
80103443:	68 e8 81 10 80       	push   $0x801081e8
80103448:	50                   	push   %eax
80103449:	e8 92 16 00 00       	call   80104ae0 <initlock>
  (*f0)->type = FD_PIPE;
8010344e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103450:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103453:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103459:	8b 06                	mov    (%esi),%eax
8010345b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010345f:	8b 06                	mov    (%esi),%eax
80103461:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103465:	8b 06                	mov    (%esi),%eax
80103467:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010346a:	8b 03                	mov    (%ebx),%eax
8010346c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103472:	8b 03                	mov    (%ebx),%eax
80103474:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103478:	8b 03                	mov    (%ebx),%eax
8010347a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010347e:	8b 03                	mov    (%ebx),%eax
80103480:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103483:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103486:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103488:	5b                   	pop    %ebx
80103489:	5e                   	pop    %esi
8010348a:	5f                   	pop    %edi
8010348b:	5d                   	pop    %ebp
8010348c:	c3                   	ret    
8010348d:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103490:	8b 06                	mov    (%esi),%eax
80103492:	85 c0                	test   %eax,%eax
80103494:	74 1e                	je     801034b4 <pipealloc+0xe4>
    fileclose(*f0);
80103496:	83 ec 0c             	sub    $0xc,%esp
80103499:	50                   	push   %eax
8010349a:	e8 e1 d9 ff ff       	call   80100e80 <fileclose>
8010349f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801034a2:	8b 03                	mov    (%ebx),%eax
801034a4:	85 c0                	test   %eax,%eax
801034a6:	74 0c                	je     801034b4 <pipealloc+0xe4>
    fileclose(*f1);
801034a8:	83 ec 0c             	sub    $0xc,%esp
801034ab:	50                   	push   %eax
801034ac:	e8 cf d9 ff ff       	call   80100e80 <fileclose>
801034b1:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801034b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801034b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801034bc:	5b                   	pop    %ebx
801034bd:	5e                   	pop    %esi
801034be:	5f                   	pop    %edi
801034bf:	5d                   	pop    %ebp
801034c0:	c3                   	ret    
801034c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801034c8:	8b 06                	mov    (%esi),%eax
801034ca:	85 c0                	test   %eax,%eax
801034cc:	75 c8                	jne    80103496 <pipealloc+0xc6>
801034ce:	eb d2                	jmp    801034a2 <pipealloc+0xd2>

801034d0 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
801034d0:	55                   	push   %ebp
801034d1:	89 e5                	mov    %esp,%ebp
801034d3:	56                   	push   %esi
801034d4:	53                   	push   %ebx
801034d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034db:	83 ec 0c             	sub    $0xc,%esp
801034de:	53                   	push   %ebx
801034df:	e8 1c 16 00 00       	call   80104b00 <acquire>
  if(writable){
801034e4:	83 c4 10             	add    $0x10,%esp
801034e7:	85 f6                	test   %esi,%esi
801034e9:	74 45                	je     80103530 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801034eb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034f1:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
801034f4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801034fb:	00 00 00 
    wakeup(&p->nread);
801034fe:	50                   	push   %eax
801034ff:	e8 7c 0e 00 00       	call   80104380 <wakeup>
80103504:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103507:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010350d:	85 d2                	test   %edx,%edx
8010350f:	75 0a                	jne    8010351b <pipeclose+0x4b>
80103511:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103517:	85 c0                	test   %eax,%eax
80103519:	74 35                	je     80103550 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010351b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010351e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103521:	5b                   	pop    %ebx
80103522:	5e                   	pop    %esi
80103523:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103524:	e9 b7 17 00 00       	jmp    80104ce0 <release>
80103529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103530:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103536:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103539:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103540:	00 00 00 
    wakeup(&p->nwrite);
80103543:	50                   	push   %eax
80103544:	e8 37 0e 00 00       	call   80104380 <wakeup>
80103549:	83 c4 10             	add    $0x10,%esp
8010354c:	eb b9                	jmp    80103507 <pipeclose+0x37>
8010354e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103550:	83 ec 0c             	sub    $0xc,%esp
80103553:	53                   	push   %ebx
80103554:	e8 87 17 00 00       	call   80104ce0 <release>
    kfree((char*)p);
80103559:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010355c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010355f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103562:	5b                   	pop    %ebx
80103563:	5e                   	pop    %esi
80103564:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103565:	e9 d6 ed ff ff       	jmp    80102340 <kfree>
8010356a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103570 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103570:	55                   	push   %ebp
80103571:	89 e5                	mov    %esp,%ebp
80103573:	57                   	push   %edi
80103574:	56                   	push   %esi
80103575:	53                   	push   %ebx
80103576:	83 ec 28             	sub    $0x28,%esp
80103579:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
8010357c:	57                   	push   %edi
8010357d:	e8 7e 15 00 00       	call   80104b00 <acquire>
  for(i = 0; i < n; i++){
80103582:	8b 45 10             	mov    0x10(%ebp),%eax
80103585:	83 c4 10             	add    $0x10,%esp
80103588:	85 c0                	test   %eax,%eax
8010358a:	0f 8e c6 00 00 00    	jle    80103656 <pipewrite+0xe6>
80103590:	8b 45 0c             	mov    0xc(%ebp),%eax
80103593:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
80103599:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
8010359f:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
801035a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801035a8:	03 45 10             	add    0x10(%ebp),%eax
801035ab:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035ae:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
801035b4:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801035ba:	39 d1                	cmp    %edx,%ecx
801035bc:	0f 85 cf 00 00 00    	jne    80103691 <pipewrite+0x121>
      if(p->readopen == 0 || proc->killed){
801035c2:	8b 97 3c 02 00 00    	mov    0x23c(%edi),%edx
801035c8:	85 d2                	test   %edx,%edx
801035ca:	0f 84 a8 00 00 00    	je     80103678 <pipewrite+0x108>
801035d0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801035d7:	8b 42 14             	mov    0x14(%edx),%eax
801035da:	85 c0                	test   %eax,%eax
801035dc:	74 25                	je     80103603 <pipewrite+0x93>
801035de:	e9 95 00 00 00       	jmp    80103678 <pipewrite+0x108>
801035e3:	90                   	nop
801035e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035e8:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
801035ee:	85 c0                	test   %eax,%eax
801035f0:	0f 84 82 00 00 00    	je     80103678 <pipewrite+0x108>
801035f6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801035fc:	8b 40 14             	mov    0x14(%eax),%eax
801035ff:	85 c0                	test   %eax,%eax
80103601:	75 75                	jne    80103678 <pipewrite+0x108>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103603:	83 ec 0c             	sub    $0xc,%esp
80103606:	56                   	push   %esi
80103607:	e8 74 0d 00 00       	call   80104380 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010360c:	59                   	pop    %ecx
8010360d:	58                   	pop    %eax
8010360e:	57                   	push   %edi
8010360f:	53                   	push   %ebx
80103610:	e8 fb 0a 00 00       	call   80104110 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103615:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
8010361b:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
80103621:	83 c4 10             	add    $0x10,%esp
80103624:	05 00 02 00 00       	add    $0x200,%eax
80103629:	39 c2                	cmp    %eax,%edx
8010362b:	74 bb                	je     801035e8 <pipewrite+0x78>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010362d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103630:	8d 4a 01             	lea    0x1(%edx),%ecx
80103633:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80103637:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010363d:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
80103643:	0f b6 00             	movzbl (%eax),%eax
80103646:	88 44 17 34          	mov    %al,0x34(%edi,%edx,1)
8010364a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010364d:	3b 45 e0             	cmp    -0x20(%ebp),%eax
80103650:	0f 85 58 ff ff ff    	jne    801035ae <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103656:	8d 97 34 02 00 00    	lea    0x234(%edi),%edx
8010365c:	83 ec 0c             	sub    $0xc,%esp
8010365f:	52                   	push   %edx
80103660:	e8 1b 0d 00 00       	call   80104380 <wakeup>
  release(&p->lock);
80103665:	89 3c 24             	mov    %edi,(%esp)
80103668:	e8 73 16 00 00       	call   80104ce0 <release>
  return n;
8010366d:	83 c4 10             	add    $0x10,%esp
80103670:	8b 45 10             	mov    0x10(%ebp),%eax
80103673:	eb 14                	jmp    80103689 <pipewrite+0x119>
80103675:	8d 76 00             	lea    0x0(%esi),%esi

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
80103678:	83 ec 0c             	sub    $0xc,%esp
8010367b:	57                   	push   %edi
8010367c:	e8 5f 16 00 00       	call   80104ce0 <release>
        return -1;
80103681:	83 c4 10             	add    $0x10,%esp
80103684:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103689:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010368c:	5b                   	pop    %ebx
8010368d:	5e                   	pop    %esi
8010368e:	5f                   	pop    %edi
8010368f:	5d                   	pop    %ebp
80103690:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103691:	89 ca                	mov    %ecx,%edx
80103693:	eb 98                	jmp    8010362d <pipewrite+0xbd>
80103695:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036a0 <piperead>:
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
{
801036a0:	55                   	push   %ebp
801036a1:	89 e5                	mov    %esp,%ebp
801036a3:	57                   	push   %edi
801036a4:	56                   	push   %esi
801036a5:	53                   	push   %ebx
801036a6:	83 ec 18             	sub    $0x18,%esp
801036a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801036ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801036af:	53                   	push   %ebx
801036b0:	e8 4b 14 00 00       	call   80104b00 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036b5:	83 c4 10             	add    $0x10,%esp
801036b8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801036be:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801036c4:	75 6a                	jne    80103730 <piperead+0x90>
801036c6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801036cc:	85 f6                	test   %esi,%esi
801036ce:	0f 84 cc 00 00 00    	je     801037a0 <piperead+0x100>
801036d4:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801036da:	eb 2d                	jmp    80103709 <piperead+0x69>
801036dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801036e0:	83 ec 08             	sub    $0x8,%esp
801036e3:	53                   	push   %ebx
801036e4:	56                   	push   %esi
801036e5:	e8 26 0a 00 00       	call   80104110 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036ea:	83 c4 10             	add    $0x10,%esp
801036ed:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801036f3:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
801036f9:	75 35                	jne    80103730 <piperead+0x90>
801036fb:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80103701:	85 d2                	test   %edx,%edx
80103703:	0f 84 97 00 00 00    	je     801037a0 <piperead+0x100>
    if(proc->killed){
80103709:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103710:	8b 4a 14             	mov    0x14(%edx),%ecx
80103713:	85 c9                	test   %ecx,%ecx
80103715:	74 c9                	je     801036e0 <piperead+0x40>
      release(&p->lock);
80103717:	83 ec 0c             	sub    $0xc,%esp
8010371a:	53                   	push   %ebx
8010371b:	e8 c0 15 00 00       	call   80104ce0 <release>
      return -1;
80103720:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103723:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
      release(&p->lock);
      return -1;
80103726:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
8010372b:	5b                   	pop    %ebx
8010372c:	5e                   	pop    %esi
8010372d:	5f                   	pop    %edi
8010372e:	5d                   	pop    %ebp
8010372f:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103730:	8b 45 10             	mov    0x10(%ebp),%eax
80103733:	85 c0                	test   %eax,%eax
80103735:	7e 69                	jle    801037a0 <piperead+0x100>
    if(p->nread == p->nwrite)
80103737:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
8010373d:	31 c9                	xor    %ecx,%ecx
8010373f:	eb 15                	jmp    80103756 <piperead+0xb6>
80103741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103748:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
8010374e:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
80103754:	74 5a                	je     801037b0 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103756:	8d 72 01             	lea    0x1(%edx),%esi
80103759:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010375f:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103765:	0f b6 54 13 34       	movzbl 0x34(%ebx,%edx,1),%edx
8010376a:	88 14 0f             	mov    %dl,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010376d:	83 c1 01             	add    $0x1,%ecx
80103770:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103773:	75 d3                	jne    80103748 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103775:	8d 93 38 02 00 00    	lea    0x238(%ebx),%edx
8010377b:	83 ec 0c             	sub    $0xc,%esp
8010377e:	52                   	push   %edx
8010377f:	e8 fc 0b 00 00       	call   80104380 <wakeup>
  release(&p->lock);
80103784:	89 1c 24             	mov    %ebx,(%esp)
80103787:	e8 54 15 00 00       	call   80104ce0 <release>
  return i;
8010378c:	8b 45 10             	mov    0x10(%ebp),%eax
8010378f:	83 c4 10             	add    $0x10,%esp
}
80103792:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103795:	5b                   	pop    %ebx
80103796:	5e                   	pop    %esi
80103797:	5f                   	pop    %edi
80103798:	5d                   	pop    %ebp
80103799:	c3                   	ret    
8010379a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801037a0:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
801037a7:	eb cc                	jmp    80103775 <piperead+0xd5>
801037a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801037b0:	89 4d 10             	mov    %ecx,0x10(%ebp)
801037b3:	eb c0                	jmp    80103775 <piperead+0xd5>
801037b5:	66 90                	xchg   %ax,%ax
801037b7:	66 90                	xchg   %ax,%ax
801037b9:	66 90                	xchg   %ax,%ax
801037bb:	66 90                	xchg   %ax,%ax
801037bd:	66 90                	xchg   %ax,%ax
801037bf:	90                   	nop

801037c0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801037c6:	68 40 2b 11 80       	push   $0x80112b40
801037cb:	e8 10 15 00 00       	call   80104ce0 <release>

  if (first) {
801037d0:	a1 04 b0 10 80       	mov    0x8010b004,%eax
801037d5:	83 c4 10             	add    $0x10,%esp
801037d8:	85 c0                	test   %eax,%eax
801037da:	75 04                	jne    801037e0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801037dc:	c9                   	leave  
801037dd:	c3                   	ret    
801037de:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
801037e0:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801037e3:	c7 05 04 b0 10 80 00 	movl   $0x0,0x8010b004
801037ea:	00 00 00 
    iinit(ROOTDEV);
801037ed:	6a 01                	push   $0x1
801037ef:	e8 bc dc ff ff       	call   801014b0 <iinit>
    initlog(ROOTDEV);
801037f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801037fb:	e8 90 f3 ff ff       	call   80102b90 <initlog>
80103800:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103803:	c9                   	leave  
80103804:	c3                   	ret    
80103805:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103810 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103810:	55                   	push   %ebp
80103811:	89 e5                	mov    %esp,%ebp
80103813:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103816:	68 ed 81 10 80       	push   $0x801081ed
8010381b:	68 40 2b 11 80       	push   $0x80112b40
80103820:	e8 bb 12 00 00       	call   80104ae0 <initlock>
}
80103825:	83 c4 10             	add    $0x10,%esp
80103828:	c9                   	leave  
80103829:	c3                   	ret    
8010382a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103830 <allocthread>:

struct thread*
allocthread(struct proc * p)
{
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	57                   	push   %edi
80103834:	56                   	push   %esi
80103835:	53                   	push   %ebx
80103836:	83 ec 0c             	sub    $0xc,%esp
80103839:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct thread *t;
  char *sp;
  int found = 0;

  for(t = p->threads; found != 1 && t < &p->threads[NTHREAD]; t++)
8010383c:	8d 5f 6c             	lea    0x6c(%edi),%ebx
8010383f:	8d 97 6c 02 00 00    	lea    0x26c(%edi),%edx
80103845:	39 d3                	cmp    %edx,%ebx
80103847:	0f 83 8b 00 00 00    	jae    801038d8 <allocthread+0xa8>
  {
    if(t->state == TUNUSED)
8010384d:	8b 43 04             	mov    0x4(%ebx),%eax
80103850:	85 c0                	test   %eax,%eax
80103852:	75 74                	jne    801038c8 <allocthread+0x98>
    {
      found = 1;
      t--;
80103854:	8d 73 e0             	lea    -0x20(%ebx),%esi
  }

  if(!found)
    return 0;

  t->tid = nexttid++;
80103857:	a1 0c b0 10 80       	mov    0x8010b00c,%eax
  t->state = TEMBRYO;
8010385c:	c7 46 24 01 00 00 00 	movl   $0x1,0x24(%esi)
  t->parent = p;
80103863:	89 7e 2c             	mov    %edi,0x2c(%esi)
  t->killed = 0;
80103866:	c7 46 3c 00 00 00 00 	movl   $0x0,0x3c(%esi)
  }

  if(!found)
    return 0;

  t->tid = nexttid++;
8010386d:	8d 50 01             	lea    0x1(%eax),%edx
80103870:	89 46 20             	mov    %eax,0x20(%esi)
80103873:	89 15 0c b0 10 80    	mov    %edx,0x8010b00c
  t->state = TEMBRYO;
  t->parent = p;
  t->killed = 0;

  // Allocate kernel stack.
  if((t->kstack = kalloc()) == 0){
80103879:	e8 72 ec ff ff       	call   801024f0 <kalloc>
8010387e:	85 c0                	test   %eax,%eax
80103880:	89 46 28             	mov    %eax,0x28(%esi)
80103883:	0f 84 97 00 00 00    	je     80103920 <allocthread+0xf0>
    return 0;
  }
  sp = t->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *t->tf;
80103889:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *t->context;
  t->context = (struct context*)sp;
  memset(t->context, 0, sizeof *t->context);
8010388f:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *t->context;
80103892:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = t->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *t->tf;
80103897:	89 56 30             	mov    %edx,0x30(%esi)
  t->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
8010389a:	c7 40 14 2e 61 10 80 	movl   $0x8010612e,0x14(%eax)

  sp -= sizeof *t->context;
  t->context = (struct context*)sp;
801038a1:	89 46 34             	mov    %eax,0x34(%esi)
  memset(t->context, 0, sizeof *t->context);
801038a4:	6a 14                	push   $0x14
801038a6:	6a 00                	push   $0x0
801038a8:	50                   	push   %eax
801038a9:	e8 82 14 00 00       	call   80104d30 <memset>
  t->context->eip = (uint)forkret;
801038ae:	8b 46 34             	mov    0x34(%esi),%eax

  return t;
801038b1:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *t->context;
  t->context = (struct context*)sp;
  memset(t->context, 0, sizeof *t->context);
  t->context->eip = (uint)forkret;
801038b4:	c7 40 10 c0 37 10 80 	movl   $0x801037c0,0x10(%eax)

  return t;
}
801038bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
  sp -= sizeof *t->context;
  t->context = (struct context*)sp;
  memset(t->context, 0, sizeof *t->context);
  t->context->eip = (uint)forkret;

  return t;
801038be:	89 d8                	mov    %ebx,%eax
}
801038c0:	5b                   	pop    %ebx
801038c1:	5e                   	pop    %esi
801038c2:	5f                   	pop    %edi
801038c3:	5d                   	pop    %ebp
801038c4:	c3                   	ret    
801038c5:	8d 76 00             	lea    0x0(%esi),%esi
    if(t->state == TUNUSED)
    {
      found = 1;
      t--;
    }
    else if(t->state == TZOMBIE)
801038c8:	83 f8 05             	cmp    $0x5,%eax
801038cb:	74 1b                	je     801038e8 <allocthread+0xb8>
{
  struct thread *t;
  char *sp;
  int found = 0;

  for(t = p->threads; found != 1 && t < &p->threads[NTHREAD]; t++)
801038cd:	83 c3 20             	add    $0x20,%ebx
801038d0:	39 d3                	cmp    %edx,%ebx
801038d2:	0f 82 75 ff ff ff    	jb     8010384d <allocthread+0x1d>
  t->killed = 0;

  // Allocate kernel stack.
  if((t->kstack = kalloc()) == 0){
    t->state = TUNUSED;
    return 0;
801038d8:	31 c0                	xor    %eax,%eax
  t->context = (struct context*)sp;
  memset(t->context, 0, sizeof *t->context);
  t->context->eip = (uint)forkret;

  return t;
}
801038da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038dd:	5b                   	pop    %ebx
801038de:	5e                   	pop    %esi
801038df:	5f                   	pop    %edi
801038e0:	5d                   	pop    %ebp
801038e1:	c3                   	ret    
801038e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

void
clearThread(struct thread * t)
{
  if(t->state == TINVALID || t->state == TZOMBIE)
    kfree(t->kstack);
801038e8:	83 ec 0c             	sub    $0xc,%esp
801038eb:	ff 73 08             	pushl  0x8(%ebx)
    else if(t->state == TZOMBIE)
    {
      clearThread(t);
      t->state = TUNUSED;
      found = 1;
      t--;
801038ee:	8d 73 e0             	lea    -0x20(%ebx),%esi

void
clearThread(struct thread * t)
{
  if(t->state == TINVALID || t->state == TZOMBIE)
    kfree(t->kstack);
801038f1:	e8 4a ea ff ff       	call   80102340 <kfree>

  t->kstack = 0;
801038f6:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  t->tid = 0;
801038fd:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    else if(t->state == TZOMBIE)
    {
      clearThread(t);
      t->state = TUNUSED;
      found = 1;
      t--;
80103903:	83 c4 10             	add    $0x10,%esp
  if(t->state == TINVALID || t->state == TZOMBIE)
    kfree(t->kstack);

  t->kstack = 0;
  t->tid = 0;
  t->state = TUNUSED;
80103906:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  t->parent = 0;
8010390d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  t->killed = 0;
80103914:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
8010391b:	e9 37 ff ff ff       	jmp    80103857 <allocthread+0x27>
  t->parent = p;
  t->killed = 0;

  // Allocate kernel stack.
  if((t->kstack = kalloc()) == 0){
    t->state = TUNUSED;
80103920:	c7 46 24 00 00 00 00 	movl   $0x0,0x24(%esi)
    return 0;
80103927:	31 c0                	xor    %eax,%eax
80103929:	eb af                	jmp    801038da <allocthread+0xaa>
8010392b:	90                   	nop
8010392c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103930 <allocproc>:
// state required to run in the kernel.
// Otherwise return 0.
// Must hold ptable.lock.
static struct proc*
allocproc(void)
{
80103930:	55                   	push   %ebp
80103931:	89 e5                	mov    %esp,%ebp
80103933:	53                   	push   %ebx
  struct proc *p;
  struct thread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103934:	bb 74 2b 11 80       	mov    $0x80112b74,%ebx
// state required to run in the kernel.
// Otherwise return 0.
// Must hold ptable.lock.
static struct proc*
allocproc(void)
{
80103939:	83 ec 04             	sub    $0x4,%esp
8010393c:	eb 14                	jmp    80103952 <allocproc+0x22>
8010393e:	66 90                	xchg   %ax,%ax
  struct proc *p;
  struct thread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103940:	81 c3 a0 02 00 00    	add    $0x2a0,%ebx
80103946:	81 fb 74 d3 11 80    	cmp    $0x8011d374,%ebx
8010394c:	0f 84 8e 00 00 00    	je     801039e0 <allocproc+0xb0>
    if(p->state == UNUSED)
80103952:	8b 43 08             	mov    0x8(%ebx),%eax
80103955:	85 c0                	test   %eax,%eax
80103957:	75 e7                	jne    80103940 <allocproc+0x10>
      goto found;
  return 0;

found:
  p->state = USED;
  p->pid = nextpid++;
80103959:	a1 10 b0 10 80       	mov    0x8010b010,%eax

  t = allocthread(p);
8010395e:	83 ec 0c             	sub    $0xc,%esp
    if(p->state == UNUSED)
      goto found;
  return 0;

found:
  p->state = USED;
80103961:	c7 43 08 01 00 00 00 	movl   $0x1,0x8(%ebx)
  p->pid = nextpid++;

  t = allocthread(p);
80103968:	53                   	push   %ebx
      goto found;
  return 0;

found:
  p->state = USED;
  p->pid = nextpid++;
80103969:	8d 50 01             	lea    0x1(%eax),%edx
8010396c:	89 43 0c             	mov    %eax,0xc(%ebx)
8010396f:	89 15 10 b0 10 80    	mov    %edx,0x8010b010

  t = allocthread(p);
80103975:	e8 b6 fe ff ff       	call   80103830 <allocthread>

  if(t == 0)
8010397a:	83 c4 10             	add    $0x10,%esp
8010397d:	85 c0                	test   %eax,%eax
8010397f:	74 66                	je     801039e7 <allocproc+0xb7>
  {
    p->state = UNUSED;
    return 0;
  }
  p->threads[0] = *t;
80103981:	8b 10                	mov    (%eax),%edx
80103983:	89 53 6c             	mov    %edx,0x6c(%ebx)
80103986:	8b 50 04             	mov    0x4(%eax),%edx
80103989:	89 53 70             	mov    %edx,0x70(%ebx)
8010398c:	8b 50 08             	mov    0x8(%eax),%edx
8010398f:	89 53 74             	mov    %edx,0x74(%ebx)
80103992:	8b 50 0c             	mov    0xc(%eax),%edx
80103995:	89 53 78             	mov    %edx,0x78(%ebx)
80103998:	8b 50 10             	mov    0x10(%eax),%edx
8010399b:	89 53 7c             	mov    %edx,0x7c(%ebx)
8010399e:	8b 50 14             	mov    0x14(%eax),%edx
801039a1:	89 93 80 00 00 00    	mov    %edx,0x80(%ebx)
801039a7:	8b 50 18             	mov    0x18(%eax),%edx
801039aa:	89 93 84 00 00 00    	mov    %edx,0x84(%ebx)
801039b0:	8b 40 1c             	mov    0x1c(%eax),%eax

  for(t = p->threads; t < &p->threads[NTHREAD]; t++)
801039b3:	8d 93 6c 02 00 00    	lea    0x26c(%ebx),%edx
  if(t == 0)
  {
    p->state = UNUSED;
    return 0;
  }
  p->threads[0] = *t;
801039b9:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)

  for(t = p->threads; t < &p->threads[NTHREAD]; t++)
801039bf:	8d 43 6c             	lea    0x6c(%ebx),%eax
801039c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    t->state = TUNUSED;
801039c8:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    p->state = UNUSED;
    return 0;
  }
  p->threads[0] = *t;

  for(t = p->threads; t < &p->threads[NTHREAD]; t++)
801039cf:	83 c0 20             	add    $0x20,%eax
801039d2:	39 d0                	cmp    %edx,%eax
801039d4:	72 f2                	jb     801039c8 <allocproc+0x98>
801039d6:	89 d8                	mov    %ebx,%eax
    t->state = TUNUSED;

  return p;
}
801039d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039db:	c9                   	leave  
801039dc:	c3                   	ret    
801039dd:	8d 76 00             	lea    0x0(%esi),%esi
  struct thread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
  return 0;
801039e0:	31 c0                	xor    %eax,%eax

  for(t = p->threads; t < &p->threads[NTHREAD]; t++)
    t->state = TUNUSED;

  return p;
}
801039e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039e5:	c9                   	leave  
801039e6:	c3                   	ret    

  t = allocthread(p);

  if(t == 0)
  {
    p->state = UNUSED;
801039e7:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return 0;
801039ee:	eb e8                	jmp    801039d8 <allocproc+0xa8>

801039f0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801039f0:	55                   	push   %ebp
801039f1:	89 e5                	mov    %esp,%ebp
801039f3:	53                   	push   %ebx
801039f4:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  struct thread *t;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  acquire(&ptable.lock);
801039f7:	68 40 2b 11 80       	push   $0x80112b40
801039fc:	e8 ff 10 00 00       	call   80104b00 <acquire>

  p = allocproc();
80103a01:	e8 2a ff ff ff       	call   80103930 <allocproc>
80103a06:	89 c3                	mov    %eax,%ebx
  t = p->threads;
  initproc = p;
80103a08:	a3 bc b5 10 80       	mov    %eax,0x8010b5bc
  if((p->pgdir = setupkvm()) == 0)
80103a0d:	e8 8e 39 00 00       	call   801073a0 <setupkvm>
80103a12:	83 c4 10             	add    $0x10,%esp
80103a15:	85 c0                	test   %eax,%eax
80103a17:	89 43 04             	mov    %eax,0x4(%ebx)
80103a1a:	0f 84 b1 00 00 00    	je     80103ad1 <userinit+0xe1>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a20:	83 ec 04             	sub    $0x4,%esp
80103a23:	68 2c 00 00 00       	push   $0x2c
80103a28:	68 60 b4 10 80       	push   $0x8010b460
80103a2d:	50                   	push   %eax
80103a2e:	e8 bd 3a 00 00       	call   801074f0 <inituvm>
  p->sz = PGSIZE;
  memset(t->tf, 0, sizeof(*t->tf));
80103a33:	83 c4 0c             	add    $0xc,%esp
  t = p->threads;
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103a36:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(t->tf, 0, sizeof(*t->tf));
80103a3c:	6a 4c                	push   $0x4c
80103a3e:	6a 00                	push   $0x0
80103a40:	ff 73 7c             	pushl  0x7c(%ebx)
80103a43:	e8 e8 12 00 00       	call   80104d30 <memset>
  t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a48:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103a4b:	ba 23 00 00 00       	mov    $0x23,%edx
  t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a50:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  t->tf->ss = t->tf->ds;
  t->tf->eflags = FL_IF;
  t->tf->esp = PGSIZE;
  t->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a55:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(t->tf, 0, sizeof(*t->tf));
  t->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a58:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  t->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a5c:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103a5f:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  t->tf->es = t->tf->ds;
80103a63:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103a66:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a6a:	66 89 50 28          	mov    %dx,0x28(%eax)
  t->tf->ss = t->tf->ds;
80103a6e:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103a71:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a75:	66 89 50 48          	mov    %dx,0x48(%eax)
  t->tf->eflags = FL_IF;
80103a79:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103a7c:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  t->tf->esp = PGSIZE;
80103a83:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103a86:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  t->tf->eip = 0;  // beginning of initcode.S
80103a8d:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103a90:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a97:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103a9a:	6a 10                	push   $0x10
80103a9c:	68 0d 82 10 80       	push   $0x8010820d
80103aa1:	50                   	push   %eax
80103aa2:	e8 89 14 00 00       	call   80104f30 <safestrcpy>
  p->cwd = namei("/");
80103aa7:	c7 04 24 16 82 10 80 	movl   $0x80108216,(%esp)
80103aae:	e8 5d e4 ff ff       	call   80101f10 <namei>

  t->state = TRUNNABLE;
80103ab3:	c7 43 70 03 00 00 00 	movl   $0x3,0x70(%ebx)
  t->tf->eflags = FL_IF;
  t->tf->esp = PGSIZE;
  t->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
  p->cwd = namei("/");
80103aba:	89 43 58             	mov    %eax,0x58(%ebx)

  t->state = TRUNNABLE;

  release(&ptable.lock);
80103abd:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
80103ac4:	e8 17 12 00 00       	call   80104ce0 <release>
}
80103ac9:	83 c4 10             	add    $0x10,%esp
80103acc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103acf:	c9                   	leave  
80103ad0:	c3                   	ret    

  p = allocproc();
  t = p->threads;
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103ad1:	83 ec 0c             	sub    $0xc,%esp
80103ad4:	68 f4 81 10 80       	push   $0x801081f4
80103ad9:	e8 72 c8 ff ff       	call   80100350 <panic>
80103ade:	66 90                	xchg   %ax,%ax

80103ae0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103ae0:	55                   	push   %ebp
80103ae1:	89 e5                	mov    %esp,%ebp
80103ae3:	53                   	push   %ebx
80103ae4:	83 ec 10             	sub    $0x10,%esp
80103ae7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint sz;

  acquire(&ptable.lock);
80103aea:	68 40 2b 11 80       	push   $0x80112b40
80103aef:	e8 0c 10 00 00       	call   80104b00 <acquire>
  sz = proc->sz;
80103af4:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
  if(n > 0){
80103afb:	83 c4 10             	add    $0x10,%esp
80103afe:	83 fb 00             	cmp    $0x0,%ebx
growproc(int n)
{
  uint sz;

  acquire(&ptable.lock);
  sz = proc->sz;
80103b01:	8b 02                	mov    (%edx),%eax
  if(n > 0){
80103b03:	7e 4b                	jle    80103b50 <growproc+0x70>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0){
80103b05:	83 ec 04             	sub    $0x4,%esp
80103b08:	01 c3                	add    %eax,%ebx
80103b0a:	53                   	push   %ebx
80103b0b:	50                   	push   %eax
80103b0c:	ff 72 04             	pushl  0x4(%edx)
80103b0f:	e8 1c 3c 00 00       	call   80107730 <allocuvm>
80103b14:	83 c4 10             	add    $0x10,%esp
80103b17:	85 c0                	test   %eax,%eax
80103b19:	74 4d                	je     80103b68 <growproc+0x88>
80103b1b:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
      release(&ptable.lock);
      return -1;
    }
  }
  proc->sz = sz;
  switchuvm(proc);
80103b22:	83 ec 0c             	sub    $0xc,%esp
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0){
      release(&ptable.lock);
      return -1;
    }
  }
  proc->sz = sz;
80103b25:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
80103b27:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
80103b2e:	e8 1d 39 00 00       	call   80107450 <switchuvm>
  release(&ptable.lock);
80103b33:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
80103b3a:	e8 a1 11 00 00       	call   80104ce0 <release>
  return 0;
80103b3f:	83 c4 10             	add    $0x10,%esp
80103b42:	31 c0                	xor    %eax,%eax
}
80103b44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b47:	c9                   	leave  
80103b48:	c3                   	ret    
80103b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0){
      release(&ptable.lock);
      return -1;
    }
  } else if(n < 0){
80103b50:	74 d0                	je     80103b22 <growproc+0x42>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0){
80103b52:	83 ec 04             	sub    $0x4,%esp
80103b55:	01 c3                	add    %eax,%ebx
80103b57:	53                   	push   %ebx
80103b58:	50                   	push   %eax
80103b59:	ff 72 04             	pushl  0x4(%edx)
80103b5c:	e8 cf 3a 00 00       	call   80107630 <deallocuvm>
80103b61:	83 c4 10             	add    $0x10,%esp
80103b64:	85 c0                	test   %eax,%eax
80103b66:	75 b3                	jne    80103b1b <growproc+0x3b>

  acquire(&ptable.lock);
  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0){
      release(&ptable.lock);
80103b68:	83 ec 0c             	sub    $0xc,%esp
80103b6b:	68 40 2b 11 80       	push   $0x80112b40
80103b70:	e8 6b 11 00 00       	call   80104ce0 <release>
      return -1;
80103b75:	83 c4 10             	add    $0x10,%esp
80103b78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b7d:	eb c5                	jmp    80103b44 <growproc+0x64>
80103b7f:	90                   	nop

80103b80 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103b80:	55                   	push   %ebp
80103b81:	89 e5                	mov    %esp,%ebp
80103b83:	57                   	push   %edi
80103b84:	56                   	push   %esi
80103b85:	53                   	push   %ebx
80103b86:	83 ec 18             	sub    $0x18,%esp
  int i, pid;
  struct proc *np;
  struct thread *nt;

  acquire(&ptable.lock);
80103b89:	68 40 2b 11 80       	push   $0x80112b40
80103b8e:	e8 6d 0f 00 00       	call   80104b00 <acquire>

  // Allocate process.
  if((np = allocproc()) == 0){
80103b93:	e8 98 fd ff ff       	call   80103930 <allocproc>
80103b98:	83 c4 10             	add    $0x10,%esp
80103b9b:	85 c0                	test   %eax,%eax
80103b9d:	0f 84 cd 00 00 00    	je     80103c70 <fork+0xf0>
80103ba3:	89 c3                	mov    %eax,%ebx
    return -1;
  }
  nt = np->threads;

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80103ba5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103bab:	83 ec 08             	sub    $0x8,%esp
80103bae:	ff 30                	pushl  (%eax)
80103bb0:	ff 70 04             	pushl  0x4(%eax)
80103bb3:	e8 58 3d 00 00       	call   80107910 <copyuvm>
80103bb8:	83 c4 10             	add    $0x10,%esp
80103bbb:	85 c0                	test   %eax,%eax
80103bbd:	89 43 04             	mov    %eax,0x4(%ebx)
80103bc0:	0f 84 c1 00 00 00    	je     80103c87 <fork+0x107>
    np->state = UNUSED;
    release(&ptable.lock);
    return -1;
  }

  np->sz = proc->sz;
80103bc6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  np->parent = proc;
  *nt->tf = *thread->tf;
80103bcc:	8b 7b 7c             	mov    0x7c(%ebx),%edi
80103bcf:	b9 13 00 00 00       	mov    $0x13,%ecx
    np->state = UNUSED;
    release(&ptable.lock);
    return -1;
  }

  np->sz = proc->sz;
80103bd4:	8b 00                	mov    (%eax),%eax
80103bd6:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80103bd8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103bde:	89 43 10             	mov    %eax,0x10(%ebx)
  *nt->tf = *thread->tf;
80103be1:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80103be7:	8b 70 10             	mov    0x10(%eax),%esi
80103bea:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  nt->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103bec:	31 f6                	xor    %esi,%esi
  np->sz = proc->sz;
  np->parent = proc;
  *nt->tf = *thread->tf;

  // Clear %eax so that fork returns 0 in the child.
  nt->tf->eax = 0;
80103bee:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103bf1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103bf8:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103bff:	90                   	nop

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
80103c00:	8b 44 b2 18          	mov    0x18(%edx,%esi,4),%eax
80103c04:	85 c0                	test   %eax,%eax
80103c06:	74 17                	je     80103c1f <fork+0x9f>
      np->ofile[i] = filedup(proc->ofile[i]);
80103c08:	83 ec 0c             	sub    $0xc,%esp
80103c0b:	50                   	push   %eax
80103c0c:	e8 1f d2 ff ff       	call   80100e30 <filedup>
80103c11:	89 44 b3 18          	mov    %eax,0x18(%ebx,%esi,4)
80103c15:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103c1c:	83 c4 10             	add    $0x10,%esp
  *nt->tf = *thread->tf;

  // Clear %eax so that fork returns 0 in the child.
  nt->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103c1f:	83 c6 01             	add    $0x1,%esi
80103c22:	83 fe 10             	cmp    $0x10,%esi
80103c25:	75 d9                	jne    80103c00 <fork+0x80>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80103c27:	83 ec 0c             	sub    $0xc,%esp
80103c2a:	ff 72 58             	pushl  0x58(%edx)
80103c2d:	e8 1e da ff ff       	call   80101650 <idup>
80103c32:	89 43 58             	mov    %eax,0x58(%ebx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103c35:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c3b:	83 c4 0c             	add    $0xc,%esp
80103c3e:	6a 10                	push   $0x10
80103c40:	83 c0 5c             	add    $0x5c,%eax
80103c43:	50                   	push   %eax
80103c44:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103c47:	50                   	push   %eax
80103c48:	e8 e3 12 00 00       	call   80104f30 <safestrcpy>

  pid = np->pid;
80103c4d:	8b 73 0c             	mov    0xc(%ebx),%esi

  nt->state = TRUNNABLE;
80103c50:	c7 43 70 03 00 00 00 	movl   $0x3,0x70(%ebx)

  release(&ptable.lock);
80103c57:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
80103c5e:	e8 7d 10 00 00       	call   80104ce0 <release>

  return pid;
80103c63:	83 c4 10             	add    $0x10,%esp
80103c66:	89 f0                	mov    %esi,%eax
}
80103c68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c6b:	5b                   	pop    %ebx
80103c6c:	5e                   	pop    %esi
80103c6d:	5f                   	pop    %edi
80103c6e:	5d                   	pop    %ebp
80103c6f:	c3                   	ret    

  acquire(&ptable.lock);

  // Allocate process.
  if((np = allocproc()) == 0){
    release(&ptable.lock);
80103c70:	83 ec 0c             	sub    $0xc,%esp
80103c73:	68 40 2b 11 80       	push   $0x80112b40
80103c78:	e8 63 10 00 00       	call   80104ce0 <release>
    return -1;
80103c7d:	83 c4 10             	add    $0x10,%esp
80103c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c85:	eb e1                	jmp    80103c68 <fork+0xe8>
  }
  nt = np->threads;

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(nt->kstack);
80103c87:	83 ec 0c             	sub    $0xc,%esp
80103c8a:	ff 73 74             	pushl  0x74(%ebx)
80103c8d:	e8 ae e6 ff ff       	call   80102340 <kfree>
    nt->kstack = 0;
80103c92:	c7 43 74 00 00 00 00 	movl   $0x0,0x74(%ebx)
    np->state = UNUSED;
80103c99:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    release(&ptable.lock);
80103ca0:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
80103ca7:	e8 34 10 00 00       	call   80104ce0 <release>
    return -1;
80103cac:	83 c4 10             	add    $0x10,%esp
80103caf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cb4:	eb b2                	jmp    80103c68 <fork+0xe8>
80103cb6:	8d 76 00             	lea    0x0(%esi),%esi
80103cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103cc0 <kill_all>:

// kill_all

void
kill_all()
{
80103cc0:	55                   	push   %ebp
  struct thread *t;
  acquire(&proc->lock);
80103cc1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// kill_all

void
kill_all()
{
80103cc7:	89 e5                	mov    %esp,%ebp
80103cc9:	56                   	push   %esi
80103cca:	53                   	push   %ebx
  struct thread *t;
  acquire(&proc->lock);
80103ccb:	05 6c 02 00 00       	add    $0x26c,%eax
80103cd0:	83 ec 0c             	sub    $0xc,%esp
80103cd3:	50                   	push   %eax
80103cd4:	e8 27 0e 00 00       	call   80104b00 <acquire>

  for(t = proc->threads; t < &proc->threads[NTHREAD]; t++) {
80103cd9:	65 8b 1d 04 00 00 00 	mov    %gs:0x4,%ebx
80103ce0:	65 8b 0d 08 00 00 00 	mov    %gs:0x8,%ecx
80103ce7:	83 c4 10             	add    $0x10,%esp
80103cea:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103ced:	8d 93 6c 02 00 00    	lea    0x26c(%ebx),%edx
80103cf3:	90                   	nop
80103cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(t->tid != thread->tid 
80103cf8:	8b 31                	mov    (%ecx),%esi
80103cfa:	39 30                	cmp    %esi,(%eax)
80103cfc:	74 10                	je     80103d0e <kill_all+0x4e>
        && t->state != TRUNNING && t->state != TUNUSED) {
80103cfe:	f7 40 04 fb ff ff ff 	testl  $0xfffffffb,0x4(%eax)
80103d05:	74 07                	je     80103d0e <kill_all+0x4e>
      t->state = TZOMBIE;
80103d07:	c7 40 04 05 00 00 00 	movl   $0x5,0x4(%eax)
kill_all()
{
  struct thread *t;
  acquire(&proc->lock);

  for(t = proc->threads; t < &proc->threads[NTHREAD]; t++) {
80103d0e:	83 c0 20             	add    $0x20,%eax
80103d11:	39 d0                	cmp    %edx,%eax
80103d13:	72 e3                	jb     80103cf8 <kill_all+0x38>
    }
  }

  thread->state = TZOMBIE;
  proc->killed = 1;
  release(&proc->lock);
80103d15:	83 ec 0c             	sub    $0xc,%esp
        && t->state != TRUNNING && t->state != TUNUSED) {
      t->state = TZOMBIE;
    }
  }

  thread->state = TZOMBIE;
80103d18:	c7 41 04 05 00 00 00 	movl   $0x5,0x4(%ecx)
  proc->killed = 1;
80103d1f:	c7 43 14 01 00 00 00 	movl   $0x1,0x14(%ebx)
  release(&proc->lock);
80103d26:	52                   	push   %edx
80103d27:	e8 b4 0f 00 00       	call   80104ce0 <release>
}
80103d2c:	83 c4 10             	add    $0x10,%esp
80103d2f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d32:	5b                   	pop    %ebx
80103d33:	5e                   	pop    %esi
80103d34:	5d                   	pop    %ebp
80103d35:	c3                   	ret    
80103d36:	8d 76 00             	lea    0x0(%esi),%esi
80103d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d40 <clearThread>:
  panic("zombie exit");
}

void
clearThread(struct thread * t)
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	53                   	push   %ebx
80103d44:	83 ec 04             	sub    $0x4,%esp
80103d47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(t->state == TINVALID || t->state == TZOMBIE)
80103d4a:	8b 43 04             	mov    0x4(%ebx),%eax
80103d4d:	83 e8 05             	sub    $0x5,%eax
80103d50:	83 f8 01             	cmp    $0x1,%eax
80103d53:	76 2b                	jbe    80103d80 <clearThread+0x40>
    kfree(t->kstack);

  t->kstack = 0;
80103d55:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  t->tid = 0;
80103d5c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  t->state = TUNUSED;
80103d62:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  t->parent = 0;
80103d69:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  t->killed = 0;
80103d70:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
}
80103d77:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d7a:	c9                   	leave  
80103d7b:	c3                   	ret    
80103d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void
clearThread(struct thread * t)
{
  if(t->state == TINVALID || t->state == TZOMBIE)
    kfree(t->kstack);
80103d80:	83 ec 0c             	sub    $0xc,%esp
80103d83:	ff 73 08             	pushl  0x8(%ebx)
80103d86:	e8 b5 e5 ff ff       	call   80102340 <kfree>
80103d8b:	83 c4 10             	add    $0x10,%esp
80103d8e:	eb c5                	jmp    80103d55 <clearThread+0x15>

80103d90 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103d90:	55                   	push   %ebp
80103d91:	89 e5                	mov    %esp,%ebp
80103d93:	57                   	push   %edi
80103d94:	56                   	push   %esi
80103d95:	53                   	push   %ebx
80103d96:	83 ec 0c             	sub    $0xc,%esp
}

static inline void
sti(void)
{
  asm volatile("sti");
80103d99:	fb                   	sti    

  for(;;){
    // Enable interrupts on this processor.
    sti();
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103d9a:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d9d:	be 74 2b 11 80       	mov    $0x80112b74,%esi

  for(;;){
    // Enable interrupts on this processor.
    sti();
    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103da2:	68 40 2b 11 80       	push   $0x80112b40
80103da7:	e8 54 0d 00 00       	call   80104b00 <acquire>
80103dac:	83 c4 10             	add    $0x10,%esp
80103daf:	eb 19                	jmp    80103dca <scheduler+0x3a>
80103db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103db8:	81 c6 a0 02 00 00    	add    $0x2a0,%esi
80103dbe:	81 fe 74 d3 11 80    	cmp    $0x8011d374,%esi
80103dc4:	0f 84 7c 00 00 00    	je     80103e46 <scheduler+0xb6>
      if(p->state != USED)
80103dca:	83 7e 08 01          	cmpl   $0x1,0x8(%esi)
80103dce:	75 e8                	jne    80103db8 <scheduler+0x28>
80103dd0:	8d 5e 6c             	lea    0x6c(%esi),%ebx
80103dd3:	8d be 6c 02 00 00    	lea    0x26c(%esi),%edi
80103dd9:	eb 0c                	jmp    80103de7 <scheduler+0x57>
80103ddb:	90                   	nop
80103ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          continue;

      for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80103de0:	83 c3 20             	add    $0x20,%ebx
80103de3:	39 df                	cmp    %ebx,%edi
80103de5:	76 d1                	jbe    80103db8 <scheduler+0x28>
        if(t->state != TRUNNABLE)
80103de7:	83 7b 04 03          	cmpl   $0x3,0x4(%ebx)
80103deb:	75 f3                	jne    80103de0 <scheduler+0x50>
        // before jumping back to us.


        proc = p;
        thread = t;
        switchuvm(p);
80103ded:	83 ec 0c             	sub    $0xc,%esp
        // to release ptable.lock and then reacquire it
        // before jumping back to us.


        proc = p;
        thread = t;
80103df0:	65 89 1d 08 00 00 00 	mov    %ebx,%gs:0x8
        // Switch to chosen process.  It is the process's job
        // to release ptable.lock and then reacquire it
        // before jumping back to us.


        proc = p;
80103df7:	65 89 35 04 00 00 00 	mov    %esi,%gs:0x4
        thread = t;
        switchuvm(p);
80103dfe:	56                   	push   %esi
80103dff:	e8 4c 36 00 00       	call   80107450 <switchuvm>
		
		 //cprintf("scheduler p loop 2 state=%d\n",p->state);
		
        t->state = TRUNNING;
80103e04:	c7 43 04 04 00 00 00 	movl   $0x4,0x4(%ebx)
        swtch(&cpu->scheduler, t->context);
80103e0b:	58                   	pop    %eax
80103e0c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103e12:	5a                   	pop    %edx
80103e13:	ff 73 14             	pushl  0x14(%ebx)
80103e16:	83 c0 04             	add    $0x4,%eax
80103e19:	50                   	push   %eax
80103e1a:	e8 6c 11 00 00       	call   80104f8b <swtch>
		
				 //cprintf("scheduler p loop 3\n");
		
		
        switchkvm();
80103e1f:	e8 0c 36 00 00       	call   80107430 <switchkvm>


        // Process is done running for now.
        // It should have changed its p->state before coming back.
        proc = 0;
        if(p->state != USED)
80103e24:	83 c4 10             	add    $0x10,%esp
80103e27:	83 7e 08 01          	cmpl   $0x1,0x8(%esi)
        switchkvm();


        // Process is done running for now.
        // It should have changed its p->state before coming back.
        proc = 0;
80103e2b:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103e32:	00 00 00 00 
        if(p->state != USED)
          t = &p->threads[NTHREAD];
        
        thread = 0;
80103e36:	65 c7 05 08 00 00 00 	movl   $0x0,%gs:0x8
80103e3d:	00 00 00 00 


        // Process is done running for now.
        // It should have changed its p->state before coming back.
        proc = 0;
        if(p->state != USED)
80103e41:	0f 45 df             	cmovne %edi,%ebx
80103e44:	eb 9a                	jmp    80103de0 <scheduler+0x50>
        
        thread = 0;
      }

    }
    release(&ptable.lock);
80103e46:	83 ec 0c             	sub    $0xc,%esp
80103e49:	68 40 2b 11 80       	push   $0x80112b40
80103e4e:	e8 8d 0e 00 00       	call   80104ce0 <release>

  }
80103e53:	83 c4 10             	add    $0x10,%esp
80103e56:	e9 3e ff ff ff       	jmp    80103d99 <scheduler+0x9>
80103e5b:	90                   	nop
80103e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103e60 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	53                   	push   %ebx
80103e64:	83 ec 10             	sub    $0x10,%esp
  int intena;
  if(!holding(&ptable.lock))
80103e67:	68 40 2b 11 80       	push   $0x80112b40
80103e6c:	e8 bf 0d 00 00       	call   80104c30 <holding>
80103e71:	83 c4 10             	add    $0x10,%esp
80103e74:	85 c0                	test   %eax,%eax
80103e76:	74 76                	je     80103eee <sched+0x8e>
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
80103e78:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103e7e:	83 b8 ac 00 00 00 01 	cmpl   $0x1,0xac(%eax)
80103e85:	0f 85 97 00 00 00    	jne    80103f22 <sched+0xc2>
    panic("sched locks");
  if(thread->state == TRUNNING)
80103e8b:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80103e91:	83 78 04 04          	cmpl   $0x4,0x4(%eax)
80103e95:	74 7e                	je     80103f15 <sched+0xb5>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e97:	9c                   	pushf  
80103e98:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103e99:	f6 c4 02             	test   $0x2,%ah
80103e9c:	75 6a                	jne    80103f08 <sched+0xa8>
    panic("sched interruptible");
  if(holding(&proc->lock))        // adding this for debug
80103e9e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103ea4:	83 ec 0c             	sub    $0xc,%esp
80103ea7:	05 6c 02 00 00       	add    $0x26c,%eax
80103eac:	50                   	push   %eax
80103ead:	e8 7e 0d 00 00       	call   80104c30 <holding>
80103eb2:	83 c4 10             	add    $0x10,%esp
80103eb5:	85 c0                	test   %eax,%eax
80103eb7:	75 42                	jne    80103efb <sched+0x9b>
    panic("sched proc->lock");

  intena = cpu->intena;
80103eb9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
  swtch(&thread->context, cpu->scheduler);
80103ebf:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  if(holding(&proc->lock))        // adding this for debug
    panic("sched proc->lock");

  intena = cpu->intena;
80103ec2:	8b 98 b0 00 00 00    	mov    0xb0(%eax),%ebx
  swtch(&thread->context, cpu->scheduler);
80103ec8:	ff 70 04             	pushl  0x4(%eax)
80103ecb:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80103ed1:	83 c0 14             	add    $0x14,%eax
80103ed4:	50                   	push   %eax
80103ed5:	e8 b1 10 00 00       	call   80104f8b <swtch>
  cpu->intena = intena;
80103eda:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
}
80103ee0:	83 c4 10             	add    $0x10,%esp
  if(holding(&proc->lock))        // adding this for debug
    panic("sched proc->lock");

  intena = cpu->intena;
  swtch(&thread->context, cpu->scheduler);
  cpu->intena = intena;
80103ee3:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
80103ee9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103eec:	c9                   	leave  
80103eed:	c3                   	ret    
void
sched(void)
{
  int intena;
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103eee:	83 ec 0c             	sub    $0xc,%esp
80103ef1:	68 18 82 10 80       	push   $0x80108218
80103ef6:	e8 55 c4 ff ff       	call   80100350 <panic>
  if(thread->state == TRUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  if(holding(&proc->lock))        // adding this for debug
    panic("sched proc->lock");
80103efb:	83 ec 0c             	sub    $0xc,%esp
80103efe:	68 58 82 10 80       	push   $0x80108258
80103f03:	e8 48 c4 ff ff       	call   80100350 <panic>
  if(cpu->ncli != 1)
    panic("sched locks");
  if(thread->state == TRUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103f08:	83 ec 0c             	sub    $0xc,%esp
80103f0b:	68 44 82 10 80       	push   $0x80108244
80103f10:	e8 3b c4 ff ff       	call   80100350 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(thread->state == TRUNNING)
    panic("sched running");
80103f15:	83 ec 0c             	sub    $0xc,%esp
80103f18:	68 36 82 10 80       	push   $0x80108236
80103f1d:	e8 2e c4 ff ff       	call   80100350 <panic>
{
  int intena;
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
80103f22:	83 ec 0c             	sub    $0xc,%esp
80103f25:	68 2a 82 10 80       	push   $0x8010822a
80103f2a:	e8 21 c4 ff ff       	call   80100350 <panic>
80103f2f:	90                   	nop

80103f30 <exit>:
exit(void)
{
  struct proc *p;
  int fd;

  if(proc == initproc)
80103f30:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103f37:	3b 15 bc b5 10 80    	cmp    0x8010b5bc,%edx
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103f3d:	55                   	push   %ebp
80103f3e:	89 e5                	mov    %esp,%ebp
80103f40:	56                   	push   %esi
80103f41:	53                   	push   %ebx
  struct proc *p;
  int fd;

  if(proc == initproc)
80103f42:	0f 84 74 01 00 00    	je     801040bc <exit+0x18c>
80103f48:	31 db                	xor    %ebx,%ebx
80103f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
80103f50:	8d 73 04             	lea    0x4(%ebx),%esi
80103f53:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103f57:	85 c0                	test   %eax,%eax
80103f59:	74 1b                	je     80103f76 <exit+0x46>
      fileclose(proc->ofile[fd]);
80103f5b:	83 ec 0c             	sub    $0xc,%esp
80103f5e:	50                   	push   %eax
80103f5f:	e8 1c cf ff ff       	call   80100e80 <fileclose>
      proc->ofile[fd] = 0;
80103f64:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103f6b:	83 c4 10             	add    $0x10,%esp
80103f6e:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
80103f75:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103f76:	83 c3 01             	add    $0x1,%ebx
80103f79:	83 fb 10             	cmp    $0x10,%ebx
80103f7c:	75 d2                	jne    80103f50 <exit+0x20>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
80103f7e:	e8 ad ec ff ff       	call   80102c30 <begin_op>
  iput(proc->cwd);
80103f83:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f89:	83 ec 0c             	sub    $0xc,%esp
80103f8c:	ff 70 58             	pushl  0x58(%eax)
80103f8f:	e8 5c d8 ff ff       	call   801017f0 <iput>
  end_op();
80103f94:	e8 07 ed ff ff       	call   80102ca0 <end_op>
  proc->cwd = 0;
80103f99:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f9f:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)

  acquire(&ptable.lock);
80103fa6:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
80103fad:	e8 4e 0b 00 00       	call   80104b00 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80103fb2:	65 8b 1d 04 00 00 00 	mov    %gs:0x4,%ebx
80103fb9:	83 c4 10             	add    $0x10,%esp
80103fbc:	ba e0 2d 11 80       	mov    $0x80112de0,%edx
80103fc1:	8b 4b 10             	mov    0x10(%ebx),%ecx
80103fc4:	eb 18                	jmp    80103fde <exit+0xae>
80103fc6:	8d 76 00             	lea    0x0(%esi),%esi
80103fc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80103fd0:	81 c2 a0 02 00 00    	add    $0x2a0,%edx
wakeup1(void *chan)
{
  struct proc *p;
  struct thread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fd6:	81 fa e0 d5 11 80    	cmp    $0x8011d5e0,%edx
80103fdc:	74 2d                	je     8010400b <exit+0xdb>
    if(p->state == USED)
80103fde:	83 ba 9c fd ff ff 01 	cmpl   $0x1,-0x264(%edx)
80103fe5:	75 e9                	jne    80103fd0 <exit+0xa0>
80103fe7:	8d 82 00 fe ff ff    	lea    -0x200(%edx),%eax
80103fed:	eb 08                	jmp    80103ff7 <exit+0xc7>
80103fef:	90                   	nop
    {
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80103ff0:	83 c0 20             	add    $0x20,%eax
80103ff3:	39 d0                	cmp    %edx,%eax
80103ff5:	73 d9                	jae    80103fd0 <exit+0xa0>
        if(t->state == TSLEEPING && t->chan == chan)
80103ff7:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
80103ffb:	75 f3                	jne    80103ff0 <exit+0xc0>
80103ffd:	3b 48 18             	cmp    0x18(%eax),%ecx
80104000:	75 ee                	jne    80103ff0 <exit+0xc0>
          t->state = TRUNNABLE;
80104002:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
80104009:	eb e5                	jmp    80103ff0 <exit+0xc0>
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
8010400b:	8b 35 bc b5 10 80    	mov    0x8010b5bc,%esi
80104011:	b9 74 2b 11 80       	mov    $0x80112b74,%ecx
80104016:	eb 16                	jmp    8010402e <exit+0xfe>
80104018:	90                   	nop
80104019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104020:	81 c1 a0 02 00 00    	add    $0x2a0,%ecx
80104026:	81 f9 74 d3 11 80    	cmp    $0x8011d374,%ecx
8010402c:	74 5d                	je     8010408b <exit+0x15b>
    if(p->parent == proc){
8010402e:	3b 59 10             	cmp    0x10(%ecx),%ebx
80104031:	75 ed                	jne    80104020 <exit+0xf0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80104033:	83 79 08 02          	cmpl   $0x2,0x8(%ecx)
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80104037:	89 71 10             	mov    %esi,0x10(%ecx)
      if(p->state == ZOMBIE)
8010403a:	75 e4                	jne    80104020 <exit+0xf0>
8010403c:	ba e0 2d 11 80       	mov    $0x80112de0,%edx
80104041:	eb 13                	jmp    80104056 <exit+0x126>
80104043:	90                   	nop
80104044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104048:	81 c2 a0 02 00 00    	add    $0x2a0,%edx
wakeup1(void *chan)
{
  struct proc *p;
  struct thread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010404e:	81 fa e0 d5 11 80    	cmp    $0x8011d5e0,%edx
80104054:	74 ca                	je     80104020 <exit+0xf0>
    if(p->state == USED)
80104056:	83 ba 9c fd ff ff 01 	cmpl   $0x1,-0x264(%edx)
8010405d:	75 e9                	jne    80104048 <exit+0x118>
8010405f:	8d 82 00 fe ff ff    	lea    -0x200(%edx),%eax
80104065:	eb 10                	jmp    80104077 <exit+0x147>
80104067:	89 f6                	mov    %esi,%esi
80104069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    {
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80104070:	83 c0 20             	add    $0x20,%eax
80104073:	39 c2                	cmp    %eax,%edx
80104075:	76 d1                	jbe    80104048 <exit+0x118>
        if(t->state == TSLEEPING && t->chan == chan)
80104077:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
8010407b:	75 f3                	jne    80104070 <exit+0x140>
8010407d:	3b 70 18             	cmp    0x18(%eax),%esi
80104080:	75 ee                	jne    80104070 <exit+0x140>
          t->state = TRUNNABLE;
80104082:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
80104089:	eb e5                	jmp    80104070 <exit+0x140>
      if(p->state == ZOMBIE)
        wakeup1(initproc);
    }
  }

  kill_all();
8010408b:	e8 30 fc ff ff       	call   80103cc0 <kill_all>

  // Jump into the scheduler, never to return.
  thread->state = TINVALID;
80104090:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80104096:	c7 40 04 06 00 00 00 	movl   $0x6,0x4(%eax)
  proc->state = ZOMBIE;
8010409d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801040a3:	c7 40 08 02 00 00 00 	movl   $0x2,0x8(%eax)

  sched();
801040aa:	e8 b1 fd ff ff       	call   80103e60 <sched>
  panic("zombie exit");
801040af:	83 ec 0c             	sub    $0xc,%esp
801040b2:	68 76 82 10 80       	push   $0x80108276
801040b7:	e8 94 c2 ff ff       	call   80100350 <panic>
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");
801040bc:	83 ec 0c             	sub    $0xc,%esp
801040bf:	68 69 82 10 80       	push   $0x80108269
801040c4:	e8 87 c2 ff ff       	call   80100350 <panic>
801040c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801040d0 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
801040d0:	55                   	push   %ebp
801040d1:	89 e5                	mov    %esp,%ebp
801040d3:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801040d6:	68 40 2b 11 80       	push   $0x80112b40
801040db:	e8 20 0a 00 00       	call   80104b00 <acquire>
  thread->state = TRUNNABLE;
801040e0:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
801040e6:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
  sched();
801040ed:	e8 6e fd ff ff       	call   80103e60 <sched>
  release(&ptable.lock);
801040f2:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
801040f9:	e8 e2 0b 00 00       	call   80104ce0 <release>
}
801040fe:	83 c4 10             	add    $0x10,%esp
80104101:	c9                   	leave  
80104102:	c3                   	ret    
80104103:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104110 <sleep>:
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
	
  if(proc == 0 || thread == 0)
80104110:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80104116:	55                   	push   %ebp
80104117:	89 e5                	mov    %esp,%ebp
80104119:	56                   	push   %esi
8010411a:	53                   	push   %ebx
	
  if(proc == 0 || thread == 0)
8010411b:	85 c0                	test   %eax,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
8010411d:	8b 75 08             	mov    0x8(%ebp),%esi
80104120:	8b 5d 0c             	mov    0xc(%ebp),%ebx
	
  if(proc == 0 || thread == 0)
80104123:	0f 84 f4 00 00 00    	je     8010421d <sleep+0x10d>
80104129:	65 8b 15 08 00 00 00 	mov    %gs:0x8,%edx
80104130:	85 d2                	test   %edx,%edx
80104132:	0f 84 e5 00 00 00    	je     8010421d <sleep+0x10d>
    panic("sleep");

  if(lk == 0)
80104138:	85 db                	test   %ebx,%ebx
8010413a:	0f 84 ea 00 00 00    	je     8010422a <sleep+0x11a>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104140:	81 fb 40 2b 11 80    	cmp    $0x80112b40,%ebx
80104146:	0f 84 84 00 00 00    	je     801041d0 <sleep+0xc0>
    acquire(&ptable.lock);  //DOC: 4lock1
8010414c:	83 ec 0c             	sub    $0xc,%esp
8010414f:	68 40 2b 11 80       	push   $0x80112b40
80104154:	e8 a7 09 00 00       	call   80104b00 <acquire>
    release(lk);
80104159:	89 1c 24             	mov    %ebx,(%esp)
8010415c:	e8 7f 0b 00 00       	call   80104ce0 <release>
  }

  
  // Go to sleep.
  acquire(&proc->lock);
80104161:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104167:	05 6c 02 00 00       	add    $0x26c,%eax
8010416c:	89 04 24             	mov    %eax,(%esp)
8010416f:	e8 8c 09 00 00       	call   80104b00 <acquire>
  thread->chan = chan;
80104174:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
8010417a:	89 70 18             	mov    %esi,0x18(%eax)
  thread->state = TSLEEPING;
8010417d:	c7 40 04 02 00 00 00 	movl   $0x2,0x4(%eax)
  release(&proc->lock);
80104184:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010418a:	05 6c 02 00 00       	add    $0x26c,%eax
8010418f:	89 04 24             	mov    %eax,(%esp)
80104192:	e8 49 0b 00 00       	call   80104ce0 <release>
  sched();
80104197:	e8 c4 fc ff ff       	call   80103e60 <sched>

  // Tidy up.
  thread->chan = 0;
8010419c:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
801041a2:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
801041a9:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
801041b0:	e8 2b 0b 00 00       	call   80104ce0 <release>
    acquire(lk);
801041b5:	89 5d 08             	mov    %ebx,0x8(%ebp)
801041b8:	83 c4 10             	add    $0x10,%esp
  }
}
801041bb:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041be:	5b                   	pop    %ebx
801041bf:	5e                   	pop    %esi
801041c0:	5d                   	pop    %ebp
  thread->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
801041c1:	e9 3a 09 00 00       	jmp    80104b00 <acquire>
801041c6:	8d 76 00             	lea    0x0(%esi),%esi
801041c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    release(lk);
  }

  
  // Go to sleep.
  acquire(&proc->lock);
801041d0:	83 ec 0c             	sub    $0xc,%esp
801041d3:	05 6c 02 00 00       	add    $0x26c,%eax
801041d8:	50                   	push   %eax
801041d9:	e8 22 09 00 00       	call   80104b00 <acquire>
  thread->chan = chan;
801041de:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
801041e4:	89 70 18             	mov    %esi,0x18(%eax)
  thread->state = TSLEEPING;
801041e7:	c7 40 04 02 00 00 00 	movl   $0x2,0x4(%eax)
  release(&proc->lock);
801041ee:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801041f4:	05 6c 02 00 00       	add    $0x26c,%eax
801041f9:	89 04 24             	mov    %eax,(%esp)
801041fc:	e8 df 0a 00 00       	call   80104ce0 <release>
  sched();
80104201:	e8 5a fc ff ff       	call   80103e60 <sched>

  // Tidy up.
  thread->chan = 0;
80104206:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
8010420c:	83 c4 10             	add    $0x10,%esp
8010420f:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80104216:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104219:	5b                   	pop    %ebx
8010421a:	5e                   	pop    %esi
8010421b:	5d                   	pop    %ebp
8010421c:	c3                   	ret    
void
sleep(void *chan, struct spinlock *lk)
{
	
  if(proc == 0 || thread == 0)
    panic("sleep");
8010421d:	83 ec 0c             	sub    $0xc,%esp
80104220:	68 82 82 10 80       	push   $0x80108282
80104225:	e8 26 c1 ff ff       	call   80100350 <panic>

  if(lk == 0)
    panic("sleep without lk");
8010422a:	83 ec 0c             	sub    $0xc,%esp
8010422d:	68 88 82 10 80       	push   $0x80108288
80104232:	e8 19 c1 ff ff       	call   80100350 <panic>
80104237:	89 f6                	mov    %esi,%esi
80104239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104240 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	57                   	push   %edi
80104244:	56                   	push   %esi
80104245:	53                   	push   %ebx
80104246:	83 ec 28             	sub    $0x28,%esp
  struct proc *p;
  int havekids, pid;
  struct thread * t;

  acquire(&ptable.lock);
80104249:	68 40 2b 11 80       	push   $0x80112b40
8010424e:	e8 ad 08 00 00       	call   80104b00 <acquire>
80104253:	83 c4 10             	add    $0x10,%esp
80104256:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
8010425c:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010425e:	bb 74 2b 11 80       	mov    $0x80112b74,%ebx
80104263:	eb 11                	jmp    80104276 <wait+0x36>
80104265:	8d 76 00             	lea    0x0(%esi),%esi
80104268:	81 c3 a0 02 00 00    	add    $0x2a0,%ebx
8010426e:	81 fb 74 d3 11 80    	cmp    $0x8011d374,%ebx
80104274:	74 22                	je     80104298 <wait+0x58>
      if(p->parent != proc)
80104276:	39 43 10             	cmp    %eax,0x10(%ebx)
80104279:	75 ed                	jne    80104268 <wait+0x28>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
8010427b:	83 7b 08 02          	cmpl   $0x2,0x8(%ebx)
8010427f:	74 3d                	je     801042be <wait+0x7e>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104281:	81 c3 a0 02 00 00    	add    $0x2a0,%ebx
      if(p->parent != proc)
        continue;
      havekids = 1;
80104287:	ba 01 00 00 00       	mov    $0x1,%edx

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010428c:	81 fb 74 d3 11 80    	cmp    $0x8011d374,%ebx
80104292:	75 e2                	jne    80104276 <wait+0x36>
80104294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80104298:	85 d2                	test   %edx,%edx
8010429a:	0f 84 b9 00 00 00    	je     80104359 <wait+0x119>
801042a0:	8b 50 14             	mov    0x14(%eax),%edx
801042a3:	85 d2                	test   %edx,%edx
801042a5:	0f 85 ae 00 00 00    	jne    80104359 <wait+0x119>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
801042ab:	83 ec 08             	sub    $0x8,%esp
801042ae:	68 40 2b 11 80       	push   $0x80112b40
801042b3:	50                   	push   %eax
801042b4:	e8 57 fe ff ff       	call   80104110 <sleep>
  }
801042b9:	83 c4 10             	add    $0x10,%esp
801042bc:	eb 98                	jmp    80104256 <wait+0x16>
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
801042be:	8b 43 0c             	mov    0xc(%ebx),%eax

        for(t = p->threads; t < &p->threads[NTHREAD]; t++)
801042c1:	8d 73 6c             	lea    0x6c(%ebx),%esi
801042c4:	8d bb 6c 02 00 00    	lea    0x26c(%ebx),%edi
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
801042ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801042cd:	eb 2a                	jmp    801042f9 <wait+0xb9>
801042cf:	90                   	nop
clearThread(struct thread * t)
{
  if(t->state == TINVALID || t->state == TZOMBIE)
    kfree(t->kstack);

  t->kstack = 0;
801042d0:	c7 46 08 00 00 00 00 	movl   $0x0,0x8(%esi)
  t->tid = 0;
801042d7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;

        for(t = p->threads; t < &p->threads[NTHREAD]; t++)
801042dd:	83 c6 20             	add    $0x20,%esi
  if(t->state == TINVALID || t->state == TZOMBIE)
    kfree(t->kstack);

  t->kstack = 0;
  t->tid = 0;
  t->state = TUNUSED;
801042e0:	c7 46 e4 00 00 00 00 	movl   $0x0,-0x1c(%esi)
  t->parent = 0;
801042e7:	c7 46 ec 00 00 00 00 	movl   $0x0,-0x14(%esi)
  t->killed = 0;
801042ee:	c7 46 fc 00 00 00 00 	movl   $0x0,-0x4(%esi)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;

        for(t = p->threads; t < &p->threads[NTHREAD]; t++)
801042f5:	39 f7                	cmp    %esi,%edi
801042f7:	76 1b                	jbe    80104314 <wait+0xd4>
}

void
clearThread(struct thread * t)
{
  if(t->state == TINVALID || t->state == TZOMBIE)
801042f9:	8b 46 04             	mov    0x4(%esi),%eax
801042fc:	83 e8 05             	sub    $0x5,%eax
801042ff:	83 f8 01             	cmp    $0x1,%eax
80104302:	77 cc                	ja     801042d0 <wait+0x90>
    kfree(t->kstack);
80104304:	83 ec 0c             	sub    $0xc,%esp
80104307:	ff 76 08             	pushl  0x8(%esi)
8010430a:	e8 31 e0 ff ff       	call   80102340 <kfree>
8010430f:	83 c4 10             	add    $0x10,%esp
80104312:	eb bc                	jmp    801042d0 <wait+0x90>
        pid = p->pid;

        for(t = p->threads; t < &p->threads[NTHREAD]; t++)
          clearThread(t);

        freevm(p->pgdir);
80104314:	83 ec 0c             	sub    $0xc,%esp
80104317:	ff 73 04             	pushl  0x4(%ebx)
8010431a:	e8 21 35 00 00       	call   80107840 <freevm>
        p->pid = 0;
8010431f:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        p->parent = 0;
80104326:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->name[0] = 0;
8010432d:	c6 43 5c 00          	movb   $0x0,0x5c(%ebx)
        p->killed = 0;
80104331:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->state = UNUSED;
80104338:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        release(&ptable.lock);
8010433f:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
80104346:	e8 95 09 00 00       	call   80104ce0 <release>
        return pid;
8010434b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010434e:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104351:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104354:	5b                   	pop    %ebx
80104355:	5e                   	pop    %esi
80104356:	5f                   	pop    %edi
80104357:	5d                   	pop    %ebp
80104358:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
80104359:	83 ec 0c             	sub    $0xc,%esp
8010435c:	68 40 2b 11 80       	push   $0x80112b40
80104361:	e8 7a 09 00 00       	call   80104ce0 <release>
      return -1;
80104366:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104369:	8d 65 f4             	lea    -0xc(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
8010436c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104371:	5b                   	pop    %ebx
80104372:	5e                   	pop    %esi
80104373:	5f                   	pop    %edi
80104374:	5d                   	pop    %ebp
80104375:	c3                   	ret    
80104376:	8d 76 00             	lea    0x0(%esi),%esi
80104379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104380 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	53                   	push   %ebx
80104384:	83 ec 10             	sub    $0x10,%esp
80104387:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010438a:	68 40 2b 11 80       	push   $0x80112b40
8010438f:	e8 6c 07 00 00       	call   80104b00 <acquire>
80104394:	ba e0 2d 11 80       	mov    $0x80112de0,%edx
80104399:	83 c4 10             	add    $0x10,%esp
8010439c:	eb 10                	jmp    801043ae <wakeup+0x2e>
8010439e:	66 90                	xchg   %ax,%ax
801043a0:	81 c2 a0 02 00 00    	add    $0x2a0,%edx
wakeup1(void *chan)
{
  struct proc *p;
  struct thread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043a6:	81 fa e0 d5 11 80    	cmp    $0x8011d5e0,%edx
801043ac:	74 2d                	je     801043db <wakeup+0x5b>
    if(p->state == USED)
801043ae:	83 ba 9c fd ff ff 01 	cmpl   $0x1,-0x264(%edx)
801043b5:	75 e9                	jne    801043a0 <wakeup+0x20>
801043b7:	8d 82 00 fe ff ff    	lea    -0x200(%edx),%eax
801043bd:	eb 08                	jmp    801043c7 <wakeup+0x47>
801043bf:	90                   	nop
    {
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
801043c0:	83 c0 20             	add    $0x20,%eax
801043c3:	39 d0                	cmp    %edx,%eax
801043c5:	73 d9                	jae    801043a0 <wakeup+0x20>
        if(t->state == TSLEEPING && t->chan == chan)
801043c7:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
801043cb:	75 f3                	jne    801043c0 <wakeup+0x40>
801043cd:	3b 58 18             	cmp    0x18(%eax),%ebx
801043d0:	75 ee                	jne    801043c0 <wakeup+0x40>
          t->state = TRUNNABLE;
801043d2:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
801043d9:	eb e5                	jmp    801043c0 <wakeup+0x40>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801043db:	c7 45 08 40 2b 11 80 	movl   $0x80112b40,0x8(%ebp)
}
801043e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043e5:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
801043e6:	e9 f5 08 00 00       	jmp    80104ce0 <release>
801043eb:	90                   	nop
801043ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043f0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	53                   	push   %ebx
801043f4:	83 ec 10             	sub    $0x10,%esp
801043f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;
  struct thread *t;

  acquire(&ptable.lock);
801043fa:	68 40 2b 11 80       	push   $0x80112b40
801043ff:	e8 fc 06 00 00       	call   80104b00 <acquire>
80104404:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104407:	b8 74 2b 11 80       	mov    $0x80112b74,%eax
8010440c:	eb 0e                	jmp    8010441c <kill+0x2c>
8010440e:	66 90                	xchg   %ax,%ax
80104410:	05 a0 02 00 00       	add    $0x2a0,%eax
80104415:	3d 74 d3 11 80       	cmp    $0x8011d374,%eax
8010441a:	74 54                	je     80104470 <kill+0x80>
    if(p->pid == pid){
8010441c:	39 58 0c             	cmp    %ebx,0xc(%eax)
8010441f:	75 ef                	jne    80104410 <kill+0x20>
      p->killed = 1;
80104421:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
      // Wake process from sleep if necessary.
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80104428:	8d 50 6c             	lea    0x6c(%eax),%edx
8010442b:	05 6c 02 00 00       	add    $0x26c,%eax
80104430:	eb 0d                	jmp    8010443f <kill+0x4f>
80104432:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104438:	83 c2 20             	add    $0x20,%edx
8010443b:	39 c2                	cmp    %eax,%edx
8010443d:	73 14                	jae    80104453 <kill+0x63>
        if(t->state == TSLEEPING)
8010443f:	83 7a 04 02          	cmpl   $0x2,0x4(%edx)
80104443:	75 f3                	jne    80104438 <kill+0x48>
          t->state = TRUNNABLE;
80104445:	c7 42 04 03 00 00 00 	movl   $0x3,0x4(%edx)
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
8010444c:	83 c2 20             	add    $0x20,%edx
8010444f:	39 c2                	cmp    %eax,%edx
80104451:	72 ec                	jb     8010443f <kill+0x4f>
        if(t->state == TSLEEPING)
          t->state = TRUNNABLE;

      release(&ptable.lock);
80104453:	83 ec 0c             	sub    $0xc,%esp
80104456:	68 40 2b 11 80       	push   $0x80112b40
8010445b:	e8 80 08 00 00       	call   80104ce0 <release>
      return 0;
80104460:	83 c4 10             	add    $0x10,%esp
80104463:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104465:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104468:	c9                   	leave  
80104469:	c3                   	ret    
8010446a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104470:	83 ec 0c             	sub    $0xc,%esp
80104473:	68 40 2b 11 80       	push   $0x80112b40
80104478:	e8 63 08 00 00       	call   80104ce0 <release>
  return -1;
8010447d:	83 c4 10             	add    $0x10,%esp
80104480:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104485:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104488:	c9                   	leave  
80104489:	c3                   	ret    
8010448a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104490 <killSelf>:
// Kill the threads with of given process with pid.
// Thread won't exit until it returns
// to user space (see trap in trap.c).
void
killSelf()
{
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
80104496:	68 40 2b 11 80       	push   $0x80112b40
8010449b:	e8 60 06 00 00       	call   80104b00 <acquire>
  wakeup1(thread);
801044a0:	65 8b 0d 08 00 00 00 	mov    %gs:0x8,%ecx
801044a7:	ba e0 2d 11 80       	mov    $0x80112de0,%edx
801044ac:	83 c4 10             	add    $0x10,%esp
801044af:	eb 15                	jmp    801044c6 <killSelf+0x36>
801044b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044b8:	81 c2 a0 02 00 00    	add    $0x2a0,%edx
wakeup1(void *chan)
{
  struct proc *p;
  struct thread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801044be:	81 fa e0 d5 11 80    	cmp    $0x8011d5e0,%edx
801044c4:	74 35                	je     801044fb <killSelf+0x6b>
    if(p->state == USED)
801044c6:	83 ba 9c fd ff ff 01 	cmpl   $0x1,-0x264(%edx)
801044cd:	75 e9                	jne    801044b8 <killSelf+0x28>
801044cf:	8d 82 00 fe ff ff    	lea    -0x200(%edx),%eax
801044d5:	eb 10                	jmp    801044e7 <killSelf+0x57>
801044d7:	89 f6                	mov    %esi,%esi
801044d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    {
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
801044e0:	83 c0 20             	add    $0x20,%eax
801044e3:	39 d0                	cmp    %edx,%eax
801044e5:	73 d1                	jae    801044b8 <killSelf+0x28>
        if(t->state == TSLEEPING && t->chan == chan)
801044e7:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
801044eb:	75 f3                	jne    801044e0 <killSelf+0x50>
801044ed:	3b 48 18             	cmp    0x18(%eax),%ecx
801044f0:	75 ee                	jne    801044e0 <killSelf+0x50>
          t->state = TRUNNABLE;
801044f2:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
801044f9:	eb e5                	jmp    801044e0 <killSelf+0x50>
void
killSelf()
{
  acquire(&ptable.lock);
  wakeup1(thread);
  thread->state = TINVALID; // thread must INVALID itself! - else two cpu's can run on the same thread
801044fb:	c7 41 04 06 00 00 00 	movl   $0x6,0x4(%ecx)
  sched();
}
80104502:	c9                   	leave  
killSelf()
{
  acquire(&ptable.lock);
  wakeup1(thread);
  thread->state = TINVALID; // thread must INVALID itself! - else two cpu's can run on the same thread
  sched();
80104503:	e9 58 f9 ff ff       	jmp    80103e60 <sched>
80104508:	90                   	nop
80104509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104510 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	57                   	push   %edi
80104514:	56                   	push   %esi
80104515:	53                   	push   %ebx
80104516:	bb e0 2d 11 80       	mov    $0x80112de0,%ebx
8010451b:	83 ec 3c             	sub    $0x3c,%esp
8010451e:	66 90                	xchg   %ax,%ax
  struct thread *t;
  char *state;//, *threadState;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
80104520:	8b 83 9c fd ff ff    	mov    -0x264(%ebx),%eax
80104526:	85 c0                	test   %eax,%eax
80104528:	0f 84 b2 00 00 00    	je     801045e0 <procdump+0xd0>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010452e:	83 f8 02             	cmp    $0x2,%eax
      state = states[p->state];
    else
      state = "???";
80104531:	ba 99 82 10 80       	mov    $0x80108299,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104536:	77 11                	ja     80104549 <procdump+0x39>
80104538:	8b 14 85 bc 82 10 80 	mov    -0x7fef7d44(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
8010453f:	b8 99 82 10 80       	mov    $0x80108299,%eax
80104544:	85 d2                	test   %edx,%edx
80104546:	0f 44 d0             	cmove  %eax,%edx

    cprintf("%d %s %s\n", p->pid, state, p->name);
80104549:	8d 83 f0 fd ff ff    	lea    -0x210(%ebx),%eax
8010454f:	8d bb 00 fe ff ff    	lea    -0x200(%ebx),%edi
80104555:	50                   	push   %eax
80104556:	52                   	push   %edx
80104557:	ff b3 a0 fd ff ff    	pushl  -0x260(%ebx)
8010455d:	68 9d 82 10 80       	push   $0x8010829d
80104562:	e8 d9 c0 ff ff       	call   80100640 <cprintf>
80104567:	83 c4 10             	add    $0x10,%esp
8010456a:	eb 0b                	jmp    80104577 <procdump+0x67>
8010456c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
80104570:	83 c7 20             	add    $0x20,%edi
80104573:	39 df                	cmp    %ebx,%edi
80104575:	73 69                	jae    801045e0 <procdump+0xd0>
 

      if(t->state == TSLEEPING){
80104577:	83 7f 04 02          	cmpl   $0x2,0x4(%edi)
8010457b:	75 f3                	jne    80104570 <procdump+0x60>
        getcallerpcs((uint*)t->context->ebp+2, pc);
8010457d:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104580:	83 ec 08             	sub    $0x8,%esp
80104583:	8d 75 c0             	lea    -0x40(%ebp),%esi
80104586:	50                   	push   %eax
80104587:	8b 57 14             	mov    0x14(%edi),%edx
8010458a:	8b 52 0c             	mov    0xc(%edx),%edx
8010458d:	83 c2 08             	add    $0x8,%edx
80104590:	52                   	push   %edx
80104591:	e8 3a 06 00 00       	call   80104bd0 <getcallerpcs>
80104596:	83 c4 10             	add    $0x10,%esp
80104599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        for(i=0; i<10 && pc[i] != 0; i++)
801045a0:	8b 0e                	mov    (%esi),%ecx
801045a2:	85 c9                	test   %ecx,%ecx
801045a4:	74 1b                	je     801045c1 <procdump+0xb1>
          cprintf("%p ", pc[i]);
801045a6:	83 ec 08             	sub    $0x8,%esp
801045a9:	83 c6 04             	add    $0x4,%esi
801045ac:	51                   	push   %ecx
801045ad:	68 a7 82 10 80       	push   $0x801082a7
801045b2:	e8 89 c0 ff ff       	call   80100640 <cprintf>
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
 

      if(t->state == TSLEEPING){
        getcallerpcs((uint*)t->context->ebp+2, pc);
        for(i=0; i<10 && pc[i] != 0; i++)
801045b7:	8d 45 e8             	lea    -0x18(%ebp),%eax
801045ba:	83 c4 10             	add    $0x10,%esp
801045bd:	39 c6                	cmp    %eax,%esi
801045bf:	75 df                	jne    801045a0 <procdump+0x90>
          cprintf("%p ", pc[i]);
        cprintf("\n");
801045c1:	83 ec 0c             	sub    $0xc,%esp
      state = states[p->state];
    else
      state = "???";

    cprintf("%d %s %s\n", p->pid, state, p->name);
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801045c4:	83 c7 20             	add    $0x20,%edi

      if(t->state == TSLEEPING){
        getcallerpcs((uint*)t->context->ebp+2, pc);
        for(i=0; i<10 && pc[i] != 0; i++)
          cprintf("%p ", pc[i]);
        cprintf("\n");
801045c7:	68 c6 81 10 80       	push   $0x801081c6
801045cc:	e8 6f c0 ff ff       	call   80100640 <cprintf>
801045d1:	83 c4 10             	add    $0x10,%esp
      state = states[p->state];
    else
      state = "???";

    cprintf("%d %s %s\n", p->pid, state, p->name);
    for(t = p->threads; t < &p->threads[NTHREAD]; t++){
801045d4:	39 df                	cmp    %ebx,%edi
801045d6:	72 9f                	jb     80104577 <procdump+0x67>
801045d8:	90                   	nop
801045d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045e0:	81 c3 a0 02 00 00    	add    $0x2a0,%ebx
  struct proc *p;
  struct thread *t;
  char *state;//, *threadState;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045e6:	81 fb e0 d5 11 80    	cmp    $0x8011d5e0,%ebx
801045ec:	0f 85 2e ff ff ff    	jne    80104520 <procdump+0x10>
      }
    }


  }
}
801045f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045f5:	5b                   	pop    %ebx
801045f6:	5e                   	pop    %esi
801045f7:	5f                   	pop    %edi
801045f8:	5d                   	pop    %ebp
801045f9:	c3                   	ret    
801045fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104600 <kthread_create>:

// kthread_create

int 
kthread_create(void* (*start_func)(), void* stack, int stack_size)
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	57                   	push   %edi
80104604:	56                   	push   %esi
  struct thread * t;
  t = allocthread(proc);
80104605:	83 ec 0c             	sub    $0xc,%esp
80104608:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
8010460f:	e8 1c f2 ff ff       	call   80103830 <allocthread>

  if(t == 0) {
80104614:	83 c4 10             	add    $0x10,%esp
80104617:	85 c0                	test   %eax,%eax
80104619:	74 42                	je     8010465d <kthread_create+0x5d>

    return -1; 

  } else {

    *t->tf = *thread->tf;                   // Copy current thread's trap frame
8010461b:	65 8b 15 08 00 00 00 	mov    %gs:0x8,%edx
80104622:	8b 78 10             	mov    0x10(%eax),%edi
80104625:	b9 13 00 00 00       	mov    $0x13,%ecx
8010462a:	8b 72 10             	mov    0x10(%edx),%esi
    t->tf->esp = (int) stack + stack_size;  // Make stack pointer inside trap frame = stack address + stack size
8010462d:	8b 55 0c             	mov    0xc(%ebp),%edx

    return -1; 

  } else {

    *t->tf = *thread->tf;                   // Copy current thread's trap frame
80104630:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    t->tf->esp = (int) stack + stack_size;  // Make stack pointer inside trap frame = stack address + stack size
80104632:	03 55 10             	add    0x10(%ebp),%edx
80104635:	8b 48 10             	mov    0x10(%eax),%ecx
80104638:	89 51 44             	mov    %edx,0x44(%ecx)
    t->tf->ebp = t->tf->esp;                // Update base pointer inside trap frame as stack pointer
8010463b:	8b 50 10             	mov    0x10(%eax),%edx
8010463e:	8b 4a 44             	mov    0x44(%edx),%ecx
80104641:	89 4a 08             	mov    %ecx,0x8(%edx)
    t->tf->eip = (int) start_func;          // Make instruction pointer inside trap frame start address
80104644:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104647:	8b 50 10             	mov    0x10(%eax),%edx
8010464a:	89 4a 38             	mov    %ecx,0x38(%edx)
    t->state = TRUNNABLE;
8010464d:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
    return t->tid;
80104654:	8b 00                	mov    (%eax),%eax

  }
}
80104656:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104659:	5e                   	pop    %esi
8010465a:	5f                   	pop    %edi
8010465b:	5d                   	pop    %ebp
8010465c:	c3                   	ret    
  struct thread * t;
  t = allocthread(proc);

  if(t == 0) {

    return -1; 
8010465d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104662:	eb f2                	jmp    80104656 <kthread_create+0x56>
80104664:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010466a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104670 <kthread_id>:
// kthread_id

int 
kthread_id()
{
  if(proc && thread) {
80104670:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// kthread_id

int 
kthread_id()
{
80104676:	55                   	push   %ebp
80104677:	89 e5                	mov    %esp,%ebp
  if(proc && thread) {
80104679:	85 c0                	test   %eax,%eax
8010467b:	74 13                	je     80104690 <kthread_id+0x20>
8010467d:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80104683:	85 c0                	test   %eax,%eax
80104685:	74 09                	je     80104690 <kthread_id+0x20>
    return thread->tid;
80104687:	8b 00                	mov    (%eax),%eax
  } else {
    return -1;  
  }
}
80104689:	5d                   	pop    %ebp
8010468a:	c3                   	ret    
8010468b:	90                   	nop
8010468c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
kthread_id()
{
  if(proc && thread) {
    return thread->tid;
  } else {
    return -1;  
80104690:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
}
80104695:	5d                   	pop    %ebp
80104696:	c3                   	ret    
80104697:	89 f6                	mov    %esi,%esi
80104699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046a0 <kthread_exit>:

// kthread_exit

void 
kthread_exit()
{
801046a0:	55                   	push   %ebp
  struct thread * t;
  int found = 0;

  acquire(&proc->lock);
801046a1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// kthread_exit

void 
kthread_exit()
{
801046a7:	89 e5                	mov    %esp,%ebp
801046a9:	56                   	push   %esi
801046aa:	53                   	push   %ebx
  struct thread * t;
  int found = 0;

  acquire(&proc->lock);
801046ab:	05 6c 02 00 00       	add    $0x26c,%eax
801046b0:	83 ec 0c             	sub    $0xc,%esp
801046b3:	50                   	push   %eax
801046b4:	e8 47 04 00 00       	call   80104b00 <acquire>
801046b9:	65 8b 15 08 00 00 00 	mov    %gs:0x8,%edx

  for(t = proc->threads; t < &proc->threads[NTHREAD]; t++) {
801046c0:	65 8b 1d 04 00 00 00 	mov    %gs:0x4,%ebx
801046c7:	83 c4 10             	add    $0x10,%esp
801046ca:	8b 32                	mov    (%edx),%esi
801046cc:	8d 43 6c             	lea    0x6c(%ebx),%eax
801046cf:	81 c3 6c 02 00 00    	add    $0x26c,%ebx
801046d5:	8d 76 00             	lea    0x0(%esi),%esi
    if( t->tid != thread->tid 
801046d8:	39 30                	cmp    %esi,(%eax)
801046da:	74 0f                	je     801046eb <kthread_exit+0x4b>
          && (t->state != TUNUSED && t->state != TZOMBIE && t->state != TINVALID)) {
801046dc:	8b 50 04             	mov    0x4(%eax),%edx
801046df:	8d 4a fb             	lea    -0x5(%edx),%ecx
801046e2:	83 f9 01             	cmp    $0x1,%ecx
801046e5:	76 04                	jbe    801046eb <kthread_exit+0x4b>
801046e7:	85 d2                	test   %edx,%edx
801046e9:	75 15                	jne    80104700 <kthread_exit+0x60>
  struct thread * t;
  int found = 0;

  acquire(&proc->lock);

  for(t = proc->threads; t < &proc->threads[NTHREAD]; t++) {
801046eb:	83 c0 20             	add    $0x20,%eax
801046ee:	39 d8                	cmp    %ebx,%eax
801046f0:	72 e6                	jb     801046d8 <kthread_exit+0x38>
    release(&proc->lock);

    acquire(&ptable.lock);  // need this lock here~!
    wakeup1(thread);
  } else {    // no other thread
    release(&proc->lock);
801046f2:	83 ec 0c             	sub    $0xc,%esp
801046f5:	53                   	push   %ebx
801046f6:	e8 e5 05 00 00       	call   80104ce0 <release>
    exit();
801046fb:	e8 30 f8 ff ff       	call   80103f30 <exit>
      break;    // only 1 running t is enough
    }
  }

  if(found) { // there is other thread(s)
    release(&proc->lock);
80104700:	83 ec 0c             	sub    $0xc,%esp
80104703:	53                   	push   %ebx
80104704:	e8 d7 05 00 00       	call   80104ce0 <release>

    acquire(&ptable.lock);  // need this lock here~!
80104709:	c7 04 24 40 2b 11 80 	movl   $0x80112b40,(%esp)
80104710:	e8 eb 03 00 00       	call   80104b00 <acquire>
    wakeup1(thread);
80104715:	65 8b 1d 08 00 00 00 	mov    %gs:0x8,%ebx
8010471c:	ba e0 2d 11 80       	mov    $0x80112de0,%edx
80104721:	b9 e0 d5 11 80       	mov    $0x8011d5e0,%ecx
80104726:	83 c4 10             	add    $0x10,%esp
80104729:	eb 0f                	jmp    8010473a <kthread_exit+0x9a>
8010472b:	90                   	nop
8010472c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104730:	81 c2 a0 02 00 00    	add    $0x2a0,%edx
wakeup1(void *chan)
{
  struct proc *p;
  struct thread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104736:	39 d1                	cmp    %edx,%ecx
80104738:	74 31                	je     8010476b <kthread_exit+0xcb>
    if(p->state == USED)
8010473a:	83 ba 9c fd ff ff 01 	cmpl   $0x1,-0x264(%edx)
80104741:	75 ed                	jne    80104730 <kthread_exit+0x90>
80104743:	8d 82 00 fe ff ff    	lea    -0x200(%edx),%eax
80104749:	eb 0c                	jmp    80104757 <kthread_exit+0xb7>
8010474b:	90                   	nop
8010474c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    {
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80104750:	83 c0 20             	add    $0x20,%eax
80104753:	39 c2                	cmp    %eax,%edx
80104755:	76 d9                	jbe    80104730 <kthread_exit+0x90>
        if(t->state == TSLEEPING && t->chan == chan)
80104757:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
8010475b:	75 f3                	jne    80104750 <kthread_exit+0xb0>
8010475d:	3b 58 18             	cmp    0x18(%eax),%ebx
80104760:	75 ee                	jne    80104750 <kthread_exit+0xb0>
          t->state = TRUNNABLE;
80104762:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
80104769:	eb e5                	jmp    80104750 <kthread_exit+0xb0>
    release(&proc->lock);
    exit();
    wakeup(t);
  }

  thread->state = TZOMBIE;
8010476b:	c7 43 04 05 00 00 00 	movl   $0x5,0x4(%ebx)

  //release(&ptable.lock);
  
  sched();
}
80104772:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104775:	5b                   	pop    %ebx
80104776:	5e                   	pop    %esi
80104777:	5d                   	pop    %ebp

  thread->state = TZOMBIE;

  //release(&ptable.lock);
  
  sched();
80104778:	e9 e3 f6 ff ff       	jmp    80103e60 <sched>
8010477d:	8d 76 00             	lea    0x0(%esi),%esi

80104780 <kthread_join>:

// kthread_join

int 
kthread_join(int thread_id)
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	53                   	push   %ebx
80104784:	83 ec 04             	sub    $0x4,%esp
  struct thread * t;
  int found = 0;

  if(thread_id == thread->tid) {  // attempt to join with the thread itself
80104787:	65 8b 15 08 00 00 00 	mov    %gs:0x8,%edx

// kthread_join

int 
kthread_join(int thread_id)
{
8010478e:	8b 45 08             	mov    0x8(%ebp),%eax
  struct thread * t;
  int found = 0;

  if(thread_id == thread->tid) {  // attempt to join with the thread itself
80104791:	39 02                	cmp    %eax,(%edx)
80104793:	74 26                	je     801047bb <kthread_join+0x3b>
    return -1;
  }

  for(t = proc->threads; t < &proc->threads[NTHREAD]; t++){
80104795:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
    // loop to find the target thread
    if (t->tid == thread_id) {
8010479c:	3b 41 6c             	cmp    0x6c(%ecx),%eax

  if(thread_id == thread->tid) {  // attempt to join with the thread itself
    return -1;
  }

  for(t = proc->threads; t < &proc->threads[NTHREAD]; t++){
8010479f:	8d 59 6c             	lea    0x6c(%ecx),%ebx
801047a2:	8d 91 6c 02 00 00    	lea    0x26c(%ecx),%edx
    // loop to find the target thread
    if (t->tid == thread_id) {
801047a8:	75 0a                	jne    801047b4 <kthread_join+0x34>
801047aa:	eb 1c                	jmp    801047c8 <kthread_join+0x48>
801047ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047b0:	3b 03                	cmp    (%ebx),%eax
801047b2:	74 14                	je     801047c8 <kthread_join+0x48>

  if(thread_id == thread->tid) {  // attempt to join with the thread itself
    return -1;
  }

  for(t = proc->threads; t < &proc->threads[NTHREAD]; t++){
801047b4:	83 c3 20             	add    $0x20,%ebx
801047b7:	39 d3                	cmp    %edx,%ebx
801047b9:	72 f5                	jb     801047b0 <kthread_join+0x30>
{
  struct thread * t;
  int found = 0;

  if(thread_id == thread->tid) {  // attempt to join with the thread itself
    return -1;
801047bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(t->state == TZOMBIE) {
    clearThread(t);
  }

  return 0;
}
801047c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047c3:	c9                   	leave  
801047c4:	c3                   	ret    
801047c5:	8d 76 00             	lea    0x0(%esi),%esi
  }  

  // Error: not found
  if (!found) return -1;

  acquire(&ptable.lock);
801047c8:	83 ec 0c             	sub    $0xc,%esp
801047cb:	68 40 2b 11 80       	push   $0x80112b40
801047d0:	e8 2b 03 00 00       	call   80104b00 <acquire>
801047d5:	eb 1b                	jmp    801047f2 <kthread_join+0x72>
801047d7:	89 f6                	mov    %esi,%esi
801047d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  while(found && (t->state != TUNUSED && t->state != TZOMBIE && t->state != TINVALID)) {
801047e0:	85 c0                	test   %eax,%eax
801047e2:	74 1c                	je     80104800 <kthread_join+0x80>
    // t is found and is not in a bad state
    sleep(t, &ptable.lock);
801047e4:	83 ec 08             	sub    $0x8,%esp
801047e7:	68 40 2b 11 80       	push   $0x80112b40
801047ec:	53                   	push   %ebx
801047ed:	e8 1e f9 ff ff       	call   80104110 <sleep>
  // Error: not found
  if (!found) return -1;

  acquire(&ptable.lock);

  while(found && (t->state != TUNUSED && t->state != TZOMBIE && t->state != TINVALID)) {
801047f2:	8b 43 04             	mov    0x4(%ebx),%eax
801047f5:	83 c4 10             	add    $0x10,%esp
801047f8:	8d 50 fb             	lea    -0x5(%eax),%edx
801047fb:	83 fa 01             	cmp    $0x1,%edx
801047fe:	77 e0                	ja     801047e0 <kthread_join+0x60>
    // t is found and is not in a bad state
    sleep(t, &ptable.lock);
  }

  release(&ptable.lock);
80104800:	83 ec 0c             	sub    $0xc,%esp
80104803:	68 40 2b 11 80       	push   $0x80112b40
80104808:	e8 d3 04 00 00       	call   80104ce0 <release>

  if(t->state == TZOMBIE) {
8010480d:	83 c4 10             	add    $0x10,%esp
80104810:	83 7b 04 05          	cmpl   $0x5,0x4(%ebx)
80104814:	74 07                	je     8010481d <kthread_join+0x9d>
    clearThread(t);
  }

  return 0;
80104816:	31 c0                	xor    %eax,%eax
}
80104818:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010481b:	c9                   	leave  
8010481c:	c3                   	ret    

void
clearThread(struct thread * t)
{
  if(t->state == TINVALID || t->state == TZOMBIE)
    kfree(t->kstack);
8010481d:	83 ec 0c             	sub    $0xc,%esp
80104820:	ff 73 08             	pushl  0x8(%ebx)
80104823:	e8 18 db ff ff       	call   80102340 <kfree>

  t->kstack = 0;
80104828:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  t->tid = 0;
8010482f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  t->state = TUNUSED;
  t->parent = 0;
  t->killed = 0;
80104835:	83 c4 10             	add    $0x10,%esp
  if(t->state == TINVALID || t->state == TZOMBIE)
    kfree(t->kstack);

  t->kstack = 0;
  t->tid = 0;
  t->state = TUNUSED;
80104838:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
  t->parent = 0;
8010483f:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)

  if(t->state == TZOMBIE) {
    clearThread(t);
  }

  return 0;
80104846:	31 c0                	xor    %eax,%eax

  t->kstack = 0;
  t->tid = 0;
  t->state = TUNUSED;
  t->parent = 0;
  t->killed = 0;
80104848:	c7 43 1c 00 00 00 00 	movl   $0x0,0x1c(%ebx)
  if(t->state == TZOMBIE) {
    clearThread(t);
  }

  return 0;
}
8010484f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104852:	c9                   	leave  
80104853:	c3                   	ret    
80104854:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010485a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104860 <kthread_mutex_alloc>:

// kthread_mutex_alloc()

int 
kthread_mutex_alloc()
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	53                   	push   %ebx
  struct kthread_mutex_t *m;
  
  acquire(&mtable.lock);
  // max mutex is 64, loop through to find a unused one
  for(m = mtable.mutex; m < &mtable.mutex[NPROC]; m++) {
80104864:	bb 34 29 11 80       	mov    $0x80112934,%ebx

// kthread_mutex_alloc()

int 
kthread_mutex_alloc()
{
80104869:	83 ec 10             	sub    $0x10,%esp
  struct kthread_mutex_t *m;
  
  acquire(&mtable.lock);
8010486c:	68 00 29 11 80       	push   $0x80112900
80104871:	e8 8a 02 00 00       	call   80104b00 <acquire>
80104876:	83 c4 10             	add    $0x10,%esp
80104879:	eb 10                	jmp    8010488b <kthread_mutex_alloc+0x2b>
8010487b:	90                   	nop
8010487c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  // max mutex is 64, loop through to find a unused one
  for(m = mtable.mutex; m < &mtable.mutex[NPROC]; m++) {
80104880:	83 c3 08             	add    $0x8,%ebx
80104883:	81 fb 34 2b 11 80    	cmp    $0x80112b34,%ebx
80104889:	74 45                	je     801048d0 <kthread_mutex_alloc+0x70>
    if (m->state == MUNUSED) {
8010488b:	8b 43 04             	mov    0x4(%ebx),%eax
8010488e:	85 c0                	test   %eax,%eax
80104890:	75 ee                	jne    80104880 <kthread_mutex_alloc+0x20>
      m->mid = nextmid++;
80104892:	a1 08 b0 10 80       	mov    0x8010b008,%eax
      m->state = MUNLOCKED;
      break;
    }
  }

  if(m == &mtable.mutex[NPROC]) {
80104897:	81 fb 34 2b 11 80    	cmp    $0x80112b34,%ebx
  acquire(&mtable.lock);
  // max mutex is 64, loop through to find a unused one
  for(m = mtable.mutex; m < &mtable.mutex[NPROC]; m++) {
    if (m->state == MUNUSED) {
      m->mid = nextmid++;
      m->state = MUNLOCKED;
8010489d:	c7 43 04 02 00 00 00 	movl   $0x2,0x4(%ebx)
  
  acquire(&mtable.lock);
  // max mutex is 64, loop through to find a unused one
  for(m = mtable.mutex; m < &mtable.mutex[NPROC]; m++) {
    if (m->state == MUNUSED) {
      m->mid = nextmid++;
801048a4:	8d 50 01             	lea    0x1(%eax),%edx
801048a7:	89 03                	mov    %eax,(%ebx)
801048a9:	89 15 08 b0 10 80    	mov    %edx,0x8010b008
      m->state = MUNLOCKED;
      break;
    }
  }

  if(m == &mtable.mutex[NPROC]) {
801048af:	74 1f                	je     801048d0 <kthread_mutex_alloc+0x70>
    // 64, no spare mutex now
    release(&mtable.lock);
    return -1;
  }

  release(&mtable.lock);
801048b1:	83 ec 0c             	sub    $0xc,%esp
801048b4:	68 00 29 11 80       	push   $0x80112900
801048b9:	e8 22 04 00 00       	call   80104ce0 <release>
  return m->mid;
801048be:	8b 03                	mov    (%ebx),%eax
801048c0:	83 c4 10             	add    $0x10,%esp
}
801048c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048c6:	c9                   	leave  
801048c7:	c3                   	ret    
801048c8:	90                   	nop
801048c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(m == &mtable.mutex[NPROC]) {
    // 64, no spare mutex now
    release(&mtable.lock);
801048d0:	83 ec 0c             	sub    $0xc,%esp
801048d3:	68 00 29 11 80       	push   $0x80112900
801048d8:	e8 03 04 00 00       	call   80104ce0 <release>
    return -1;
801048dd:	83 c4 10             	add    $0x10,%esp
801048e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048e5:	eb dc                	jmp    801048c3 <kthread_mutex_alloc+0x63>
801048e7:	89 f6                	mov    %esi,%esi
801048e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801048f0 <kthread_mutex_dealloc>:

// kthread_mutex_dealloc()

int 
kthread_mutex_dealloc(int mutex_id)
{
801048f0:	55                   	push   %ebp
801048f1:	89 e5                	mov    %esp,%ebp
801048f3:	53                   	push   %ebx
801048f4:	83 ec 10             	sub    $0x10,%esp
801048f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct kthread_mutex_t *m;

  acquire(&mtable.lock);
801048fa:	68 00 29 11 80       	push   $0x80112900
801048ff:	e8 fc 01 00 00       	call   80104b00 <acquire>
80104904:	83 c4 10             	add    $0x10,%esp
  // loop through to find the target mutex
  for(m = mtable.mutex; m < &mtable.mutex[NPROC]; m++) {
80104907:	b8 34 29 11 80       	mov    $0x80112934,%eax
8010490c:	eb 0c                	jmp    8010491a <kthread_mutex_dealloc+0x2a>
8010490e:	66 90                	xchg   %ax,%ax
80104910:	83 c0 08             	add    $0x8,%eax
80104913:	3d 34 2b 11 80       	cmp    $0x80112b34,%eax
80104918:	74 36                	je     80104950 <kthread_mutex_dealloc+0x60>
    if (m->mid == mutex_id) {
8010491a:	39 18                	cmp    %ebx,(%eax)
8010491c:	75 f2                	jne    80104910 <kthread_mutex_dealloc+0x20>
      // check if locked?
      if (m->state == MLOCKED) {
8010491e:	83 78 04 01          	cmpl   $0x1,0x4(%eax)
80104922:	74 2c                	je     80104950 <kthread_mutex_dealloc+0x60>
        break;
      }
    }
  }

  if (m == &mtable.mutex[NPROC]) {
80104924:	3d 34 2b 11 80       	cmp    $0x80112b34,%eax
80104929:	74 25                	je     80104950 <kthread_mutex_dealloc+0x60>
    // target found
    m->mid = 0;
    m->state = MUNUSED;
    // no other value

    release(&mtable.lock);
8010492b:	83 ec 0c             	sub    $0xc,%esp
    // unused target not found
    release(&mtable.lock);
    return -1;
  } else {
    // target found
    m->mid = 0;
8010492e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    m->state = MUNUSED;
80104934:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    // no other value

    release(&mtable.lock);
8010493b:	68 00 29 11 80       	push   $0x80112900
80104940:	e8 9b 03 00 00       	call   80104ce0 <release>
    return 0;
80104945:	83 c4 10             	add    $0x10,%esp
80104948:	31 c0                	xor    %eax,%eax
  }

  release(&mtable.lock);
  return -1;
}
8010494a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010494d:	c9                   	leave  
8010494e:	c3                   	ret    
8010494f:	90                   	nop
  // loop through to find the target mutex
  for(m = mtable.mutex; m < &mtable.mutex[NPROC]; m++) {
    if (m->mid == mutex_id) {
      // check if locked?
      if (m->state == MLOCKED) {
        release(&mtable.lock);
80104950:	83 ec 0c             	sub    $0xc,%esp
80104953:	68 00 29 11 80       	push   $0x80112900
80104958:	e8 83 03 00 00       	call   80104ce0 <release>
        return -1;
8010495d:	83 c4 10             	add    $0x10,%esp
80104960:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104965:	eb e3                	jmp    8010494a <kthread_mutex_dealloc+0x5a>
80104967:	89 f6                	mov    %esi,%esi
80104969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104970 <kthread_mutex_lock>:

// kthread_mutex_lock()

int 
kthread_mutex_lock(int mutex_id)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	56                   	push   %esi
80104974:	53                   	push   %ebx
80104975:	8b 75 08             	mov    0x8(%ebp),%esi
  struct kthread_mutex_t *m;
  
  acquire(&mtable.lock);
  // loop through to find the target mutex
  for(m = mtable.mutex; m < &mtable.mutex[NPROC]; m++) {
80104978:	bb 34 29 11 80       	mov    $0x80112934,%ebx
int 
kthread_mutex_lock(int mutex_id)
{
  struct kthread_mutex_t *m;
  
  acquire(&mtable.lock);
8010497d:	83 ec 0c             	sub    $0xc,%esp
80104980:	68 00 29 11 80       	push   $0x80112900
80104985:	e8 76 01 00 00       	call   80104b00 <acquire>
8010498a:	83 c4 10             	add    $0x10,%esp
8010498d:	eb 0c                	jmp    8010499b <kthread_mutex_lock+0x2b>
8010498f:	90                   	nop
  // loop through to find the target mutex
  for(m = mtable.mutex; m < &mtable.mutex[NPROC]; m++) {
80104990:	83 c3 08             	add    $0x8,%ebx
80104993:	81 fb 34 2b 11 80    	cmp    $0x80112b34,%ebx
80104999:	74 65                	je     80104a00 <kthread_mutex_lock+0x90>
    if (m->mid == mutex_id) {
8010499b:	39 33                	cmp    %esi,(%ebx)
8010499d:	75 f1                	jne    80104990 <kthread_mutex_lock+0x20>
      break;
    }
  }

  if(m == &mtable.mutex[NPROC] || m->state == MUNUSED) {
8010499f:	81 fb 34 2b 11 80    	cmp    $0x80112b34,%ebx
801049a5:	74 59                	je     80104a00 <kthread_mutex_lock+0x90>
801049a7:	8b 43 04             	mov    0x4(%ebx),%eax
801049aa:	85 c0                	test   %eax,%eax
801049ac:	75 16                	jne    801049c4 <kthread_mutex_lock+0x54>
801049ae:	eb 50                	jmp    80104a00 <kthread_mutex_lock+0x90>
    return -1;
  }

  // spinlock
  while(m->state == MLOCKED) {
    sleep(m, &mtable.lock);
801049b0:	83 ec 08             	sub    $0x8,%esp
801049b3:	68 00 29 11 80       	push   $0x80112900
801049b8:	53                   	push   %ebx
801049b9:	e8 52 f7 ff ff       	call   80104110 <sleep>
    release(&mtable.lock);
    return -1;
  }

  // spinlock
  while(m->state == MLOCKED) {
801049be:	8b 43 04             	mov    0x4(%ebx),%eax
801049c1:	83 c4 10             	add    $0x10,%esp
801049c4:	83 f8 01             	cmp    $0x1,%eax
801049c7:	74 e7                	je     801049b0 <kthread_mutex_lock+0x40>
    sleep(m, &mtable.lock);
  }

  if(m->state != MUNLOCKED) {
801049c9:	83 f8 02             	cmp    $0x2,%eax
801049cc:	75 20                	jne    801049ee <kthread_mutex_lock+0x7e>
    return -1; 
  }

  m->state = MLOCKED;

  release(&mtable.lock);
801049ce:	83 ec 0c             	sub    $0xc,%esp

    release(&mtable.lock);
    return -1; 
  }

  m->state = MLOCKED;
801049d1:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)

  release(&mtable.lock);
801049d8:	68 00 29 11 80       	push   $0x80112900
801049dd:	e8 fe 02 00 00       	call   80104ce0 <release>

  return 0;
801049e2:	83 c4 10             	add    $0x10,%esp
}
801049e5:	8d 65 f8             	lea    -0x8(%ebp),%esp

  m->state = MLOCKED;

  release(&mtable.lock);

  return 0;
801049e8:	31 c0                	xor    %eax,%eax
}
801049ea:	5b                   	pop    %ebx
801049eb:	5e                   	pop    %esi
801049ec:	5d                   	pop    %ebp
801049ed:	c3                   	ret    
    sleep(m, &mtable.lock);
  }

  if(m->state != MUNLOCKED) {
    // locked by some other thread?
    thread->state = TBLOCKED;
801049ee:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
801049f4:	c7 40 04 07 00 00 00 	movl   $0x7,0x4(%eax)
    sched();
801049fb:	e8 60 f4 ff ff       	call   80103e60 <sched>

    release(&mtable.lock);
80104a00:	83 ec 0c             	sub    $0xc,%esp
80104a03:	68 00 29 11 80       	push   $0x80112900
80104a08:	e8 d3 02 00 00       	call   80104ce0 <release>
    return -1; 
80104a0d:	83 c4 10             	add    $0x10,%esp
  m->state = MLOCKED;

  release(&mtable.lock);

  return 0;
}
80104a10:	8d 65 f8             	lea    -0x8(%ebp),%esp
    // locked by some other thread?
    thread->state = TBLOCKED;
    sched();

    release(&mtable.lock);
    return -1; 
80104a13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  m->state = MLOCKED;

  release(&mtable.lock);

  return 0;
}
80104a18:	5b                   	pop    %ebx
80104a19:	5e                   	pop    %esi
80104a1a:	5d                   	pop    %ebp
80104a1b:	c3                   	ret    
80104a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a20 <kthread_mutex_unlock>:

// kthread_mutex_unlock()

int 
kthread_mutex_unlock(int mutex_id)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	53                   	push   %ebx
80104a24:	83 ec 10             	sub    $0x10,%esp
80104a27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct kthread_mutex_t *m;
  
  acquire(&mtable.lock);
80104a2a:	68 00 29 11 80       	push   $0x80112900
80104a2f:	e8 cc 00 00 00       	call   80104b00 <acquire>
80104a34:	83 c4 10             	add    $0x10,%esp
  // loop through to find the target mutex
  for(m = mtable.mutex; m < &mtable.mutex[NPROC]; m++) {
80104a37:	b9 34 29 11 80       	mov    $0x80112934,%ecx
80104a3c:	eb 0d                	jmp    80104a4b <kthread_mutex_unlock+0x2b>
80104a3e:	66 90                	xchg   %ax,%ax
80104a40:	83 c1 08             	add    $0x8,%ecx
80104a43:	81 f9 34 2b 11 80    	cmp    $0x80112b34,%ecx
80104a49:	74 77                	je     80104ac2 <kthread_mutex_unlock+0xa2>
    if (m->mid == mutex_id) {
80104a4b:	39 19                	cmp    %ebx,(%ecx)
80104a4d:	75 f1                	jne    80104a40 <kthread_mutex_unlock+0x20>
      break;
    }
  }

  if(m == &mtable.mutex[NPROC] || m->state != MLOCKED)
80104a4f:	81 f9 34 2b 11 80    	cmp    $0x80112b34,%ecx
80104a55:	74 6b                	je     80104ac2 <kthread_mutex_unlock+0xa2>
80104a57:	83 79 04 01          	cmpl   $0x1,0x4(%ecx)
80104a5b:	75 65                	jne    80104ac2 <kthread_mutex_unlock+0xa2>
    // Unused or Unlocked
    release(&mtable.lock);
    return -1;
  }

  m->state = MUNLOCKED;
80104a5d:	c7 41 04 02 00 00 00 	movl   $0x2,0x4(%ecx)
80104a64:	ba e0 2d 11 80       	mov    $0x80112de0,%edx
80104a69:	eb 13                	jmp    80104a7e <kthread_mutex_unlock+0x5e>
80104a6b:	90                   	nop
80104a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a70:	81 c2 a0 02 00 00    	add    $0x2a0,%edx
wakeup1(void *chan)
{
  struct proc *p;
  struct thread *t;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a76:	81 fa e0 d5 11 80    	cmp    $0x8011d5e0,%edx
80104a7c:	74 2d                	je     80104aab <kthread_mutex_unlock+0x8b>
    if(p->state == USED)
80104a7e:	83 ba 9c fd ff ff 01 	cmpl   $0x1,-0x264(%edx)
80104a85:	75 e9                	jne    80104a70 <kthread_mutex_unlock+0x50>
80104a87:	8d 82 00 fe ff ff    	lea    -0x200(%edx),%eax
80104a8d:	eb 08                	jmp    80104a97 <kthread_mutex_unlock+0x77>
80104a8f:	90                   	nop
    {
      for(t = p->threads; t < &p->threads[NTHREAD]; t++)
80104a90:	83 c0 20             	add    $0x20,%eax
80104a93:	39 d0                	cmp    %edx,%eax
80104a95:	73 d9                	jae    80104a70 <kthread_mutex_unlock+0x50>
        if(t->state == TSLEEPING && t->chan == chan)
80104a97:	83 78 04 02          	cmpl   $0x2,0x4(%eax)
80104a9b:	75 f3                	jne    80104a90 <kthread_mutex_unlock+0x70>
80104a9d:	39 48 18             	cmp    %ecx,0x18(%eax)
80104aa0:	75 ee                	jne    80104a90 <kthread_mutex_unlock+0x70>
          t->state = TRUNNABLE;
80104aa2:	c7 40 04 03 00 00 00 	movl   $0x3,0x4(%eax)
80104aa9:	eb e5                	jmp    80104a90 <kthread_mutex_unlock+0x70>
  }

  m->state = MUNLOCKED;
  wakeup1(m); 

  release(&mtable.lock);
80104aab:	83 ec 0c             	sub    $0xc,%esp
80104aae:	68 00 29 11 80       	push   $0x80112900
80104ab3:	e8 28 02 00 00       	call   80104ce0 <release>
  return 0;
80104ab8:	83 c4 10             	add    $0x10,%esp
80104abb:	31 c0                	xor    %eax,%eax
80104abd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ac0:	c9                   	leave  
80104ac1:	c3                   	ret    
  }

  if(m == &mtable.mutex[NPROC] || m->state != MLOCKED)
  {
    // Unused or Unlocked
    release(&mtable.lock);
80104ac2:	83 ec 0c             	sub    $0xc,%esp
80104ac5:	68 00 29 11 80       	push   $0x80112900
80104aca:	e8 11 02 00 00       	call   80104ce0 <release>
    return -1;
80104acf:	83 c4 10             	add    $0x10,%esp
80104ad2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  m->state = MUNLOCKED;
  wakeup1(m); 

  release(&mtable.lock);
  return 0;
80104ad7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ada:	c9                   	leave  
80104adb:	c3                   	ret    
80104adc:	66 90                	xchg   %ax,%ax
80104ade:	66 90                	xchg   %ax,%ax

80104ae0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104ae6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104ae9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
80104aef:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
80104af2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104af9:	5d                   	pop    %ebp
80104afa:	c3                   	ret    
80104afb:	90                   	nop
80104afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b00 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	53                   	push   %ebx
80104b04:	83 ec 04             	sub    $0x4,%esp
80104b07:	9c                   	pushf  
80104b08:	5a                   	pop    %edx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104b09:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
80104b0a:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
80104b11:	8b 81 ac 00 00 00    	mov    0xac(%ecx),%eax
80104b17:	85 c0                	test   %eax,%eax
80104b19:	75 0c                	jne    80104b27 <acquire+0x27>
    cpu->intena = eflags & FL_IF;
80104b1b:	81 e2 00 02 00 00    	and    $0x200,%edx
80104b21:	89 91 b0 00 00 00    	mov    %edx,0xb0(%ecx)
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
80104b27:	8b 55 08             	mov    0x8(%ebp),%edx

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
    cpu->intena = eflags & FL_IF;
  cpu->ncli += 1;
80104b2a:	83 c0 01             	add    $0x1,%eax
80104b2d:	89 81 ac 00 00 00    	mov    %eax,0xac(%ecx)

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
80104b33:	8b 02                	mov    (%edx),%eax
80104b35:	85 c0                	test   %eax,%eax
80104b37:	74 05                	je     80104b3e <acquire+0x3e>
80104b39:	39 4a 08             	cmp    %ecx,0x8(%edx)
80104b3c:	74 7a                	je     80104bb8 <acquire+0xb8>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104b3e:	b9 01 00 00 00       	mov    $0x1,%ecx
80104b43:	90                   	nop
80104b44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b48:	89 c8                	mov    %ecx,%eax
80104b4a:	f0 87 02             	lock xchg %eax,(%edx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104b4d:	85 c0                	test   %eax,%eax
80104b4f:	75 f7                	jne    80104b48 <acquire+0x48>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
80104b51:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104b56:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b59:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104b5f:	89 ea                	mov    %ebp,%edx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104b61:	89 41 08             	mov    %eax,0x8(%ecx)
  getcallerpcs(&lk, lk->pcs);
80104b64:	83 c1 0c             	add    $0xc,%ecx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104b67:	31 c0                	xor    %eax,%eax
80104b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104b70:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104b76:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104b7c:	77 1a                	ja     80104b98 <acquire+0x98>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104b7e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104b81:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104b84:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104b87:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104b89:	83 f8 0a             	cmp    $0xa,%eax
80104b8c:	75 e2                	jne    80104b70 <acquire+0x70>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
  getcallerpcs(&lk, lk->pcs);
}
80104b8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b91:	c9                   	leave  
80104b92:	c3                   	ret    
80104b93:	90                   	nop
80104b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104b98:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104b9f:	83 c0 01             	add    $0x1,%eax
80104ba2:	83 f8 0a             	cmp    $0xa,%eax
80104ba5:	74 e7                	je     80104b8e <acquire+0x8e>
    pcs[i] = 0;
80104ba7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104bae:	83 c0 01             	add    $0x1,%eax
80104bb1:	83 f8 0a             	cmp    $0xa,%eax
80104bb4:	75 e2                	jne    80104b98 <acquire+0x98>
80104bb6:	eb d6                	jmp    80104b8e <acquire+0x8e>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104bb8:	83 ec 0c             	sub    $0xc,%esp
80104bbb:	68 c8 82 10 80       	push   $0x801082c8
80104bc0:	e8 8b b7 ff ff       	call   80100350 <panic>
80104bc5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bd0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104bd4:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104bd7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80104bda:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
80104bdd:	31 c0                	xor    %eax,%eax
80104bdf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104be0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104be6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104bec:	77 1a                	ja     80104c08 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104bee:	8b 5a 04             	mov    0x4(%edx),%ebx
80104bf1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104bf4:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104bf7:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104bf9:	83 f8 0a             	cmp    $0xa,%eax
80104bfc:	75 e2                	jne    80104be0 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104bfe:	5b                   	pop    %ebx
80104bff:	5d                   	pop    %ebp
80104c00:	c3                   	ret    
80104c01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104c08:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104c0f:	83 c0 01             	add    $0x1,%eax
80104c12:	83 f8 0a             	cmp    $0xa,%eax
80104c15:	74 e7                	je     80104bfe <getcallerpcs+0x2e>
    pcs[i] = 0;
80104c17:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104c1e:	83 c0 01             	add    $0x1,%eax
80104c21:	83 f8 0a             	cmp    $0xa,%eax
80104c24:	75 e2                	jne    80104c08 <getcallerpcs+0x38>
80104c26:	eb d6                	jmp    80104bfe <getcallerpcs+0x2e>
80104c28:	90                   	nop
80104c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104c30 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
80104c36:	8b 02                	mov    (%edx),%eax
80104c38:	85 c0                	test   %eax,%eax
80104c3a:	74 14                	je     80104c50 <holding+0x20>
80104c3c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104c42:	39 42 08             	cmp    %eax,0x8(%edx)
}
80104c45:	5d                   	pop    %ebp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
80104c46:	0f 94 c0             	sete   %al
80104c49:	0f b6 c0             	movzbl %al,%eax
}
80104c4c:	c3                   	ret    
80104c4d:	8d 76 00             	lea    0x0(%esi),%esi
80104c50:	31 c0                	xor    %eax,%eax
80104c52:	5d                   	pop    %ebp
80104c53:	c3                   	ret    
80104c54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104c60 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104c60:	55                   	push   %ebp
80104c61:	89 e5                	mov    %esp,%ebp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104c63:	9c                   	pushf  
80104c64:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104c65:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
80104c66:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104c6d:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80104c73:	85 c0                	test   %eax,%eax
80104c75:	75 0c                	jne    80104c83 <pushcli+0x23>
    cpu->intena = eflags & FL_IF;
80104c77:	81 e1 00 02 00 00    	and    $0x200,%ecx
80104c7d:	89 8a b0 00 00 00    	mov    %ecx,0xb0(%edx)
  cpu->ncli += 1;
80104c83:	83 c0 01             	add    $0x1,%eax
80104c86:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
}
80104c8c:	5d                   	pop    %ebp
80104c8d:	c3                   	ret    
80104c8e:	66 90                	xchg   %ax,%ax

80104c90 <popcli>:

void
popcli(void)
{
80104c90:	55                   	push   %ebp
80104c91:	89 e5                	mov    %esp,%ebp
80104c93:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104c96:	9c                   	pushf  
80104c97:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104c98:	f6 c4 02             	test   $0x2,%ah
80104c9b:	75 2c                	jne    80104cc9 <popcli+0x39>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
80104c9d:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104ca4:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
80104cab:	78 0f                	js     80104cbc <popcli+0x2c>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
80104cad:	75 0b                	jne    80104cba <popcli+0x2a>
80104caf:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
80104cb5:	85 c0                	test   %eax,%eax
80104cb7:	74 01                	je     80104cba <popcli+0x2a>
}

static inline void
sti(void)
{
  asm volatile("sti");
80104cb9:	fb                   	sti    
    sti();
}
80104cba:	c9                   	leave  
80104cbb:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
    panic("popcli");
80104cbc:	83 ec 0c             	sub    $0xc,%esp
80104cbf:	68 e7 82 10 80       	push   $0x801082e7
80104cc4:	e8 87 b6 ff ff       	call   80100350 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
80104cc9:	83 ec 0c             	sub    $0xc,%esp
80104ccc:	68 d0 82 10 80       	push   $0x801082d0
80104cd1:	e8 7a b6 ff ff       	call   80100350 <panic>
80104cd6:	8d 76 00             	lea    0x0(%esi),%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ce0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	83 ec 08             	sub    $0x8,%esp
80104ce6:	8b 45 08             	mov    0x8(%ebp),%eax

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
80104ce9:	8b 10                	mov    (%eax),%edx
80104ceb:	85 d2                	test   %edx,%edx
80104ced:	74 0c                	je     80104cfb <release+0x1b>
80104cef:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104cf6:	39 50 08             	cmp    %edx,0x8(%eax)
80104cf9:	74 15                	je     80104d10 <release+0x30>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
80104cfb:	83 ec 0c             	sub    $0xc,%esp
80104cfe:	68 ee 82 10 80       	push   $0x801082ee
80104d03:	e8 48 b6 ff ff       	call   80100350 <panic>
80104d08:	90                   	nop
80104d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  lk->pcs[0] = 0;
80104d10:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104d17:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both to not re-order.
  __sync_synchronize();
80104d1e:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock.
  lk->locked = 0;
80104d23:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
}
80104d29:	c9                   	leave  
  __sync_synchronize();

  // Release the lock.
  lk->locked = 0;

  popcli();
80104d2a:	e9 61 ff ff ff       	jmp    80104c90 <popcli>
80104d2f:	90                   	nop

80104d30 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	57                   	push   %edi
80104d34:	53                   	push   %ebx
80104d35:	8b 55 08             	mov    0x8(%ebp),%edx
80104d38:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104d3b:	f6 c2 03             	test   $0x3,%dl
80104d3e:	75 05                	jne    80104d45 <memset+0x15>
80104d40:	f6 c1 03             	test   $0x3,%cl
80104d43:	74 13                	je     80104d58 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104d45:	89 d7                	mov    %edx,%edi
80104d47:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d4a:	fc                   	cld    
80104d4b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104d4d:	5b                   	pop    %ebx
80104d4e:	89 d0                	mov    %edx,%eax
80104d50:	5f                   	pop    %edi
80104d51:	5d                   	pop    %ebp
80104d52:	c3                   	ret    
80104d53:	90                   	nop
80104d54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104d58:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
80104d5c:	c1 e9 02             	shr    $0x2,%ecx
80104d5f:	89 fb                	mov    %edi,%ebx
80104d61:	89 f8                	mov    %edi,%eax
80104d63:	c1 e3 18             	shl    $0x18,%ebx
80104d66:	c1 e0 10             	shl    $0x10,%eax
80104d69:	09 d8                	or     %ebx,%eax
80104d6b:	09 f8                	or     %edi,%eax
80104d6d:	c1 e7 08             	shl    $0x8,%edi
80104d70:	09 f8                	or     %edi,%eax
80104d72:	89 d7                	mov    %edx,%edi
80104d74:	fc                   	cld    
80104d75:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104d77:	5b                   	pop    %ebx
80104d78:	89 d0                	mov    %edx,%eax
80104d7a:	5f                   	pop    %edi
80104d7b:	5d                   	pop    %ebp
80104d7c:	c3                   	ret    
80104d7d:	8d 76 00             	lea    0x0(%esi),%esi

80104d80 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104d80:	55                   	push   %ebp
80104d81:	89 e5                	mov    %esp,%ebp
80104d83:	57                   	push   %edi
80104d84:	56                   	push   %esi
80104d85:	8b 45 10             	mov    0x10(%ebp),%eax
80104d88:	53                   	push   %ebx
80104d89:	8b 75 0c             	mov    0xc(%ebp),%esi
80104d8c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104d8f:	85 c0                	test   %eax,%eax
80104d91:	74 29                	je     80104dbc <memcmp+0x3c>
    if(*s1 != *s2)
80104d93:	0f b6 13             	movzbl (%ebx),%edx
80104d96:	0f b6 0e             	movzbl (%esi),%ecx
80104d99:	38 d1                	cmp    %dl,%cl
80104d9b:	75 2b                	jne    80104dc8 <memcmp+0x48>
80104d9d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104da0:	31 c0                	xor    %eax,%eax
80104da2:	eb 14                	jmp    80104db8 <memcmp+0x38>
80104da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104da8:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
80104dad:	83 c0 01             	add    $0x1,%eax
80104db0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104db4:	38 ca                	cmp    %cl,%dl
80104db6:	75 10                	jne    80104dc8 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104db8:	39 f8                	cmp    %edi,%eax
80104dba:	75 ec                	jne    80104da8 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104dbc:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80104dbd:	31 c0                	xor    %eax,%eax
}
80104dbf:	5e                   	pop    %esi
80104dc0:	5f                   	pop    %edi
80104dc1:	5d                   	pop    %ebp
80104dc2:	c3                   	ret    
80104dc3:	90                   	nop
80104dc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104dc8:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
80104dcb:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104dcc:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
80104dce:	5e                   	pop    %esi
80104dcf:	5f                   	pop    %edi
80104dd0:	5d                   	pop    %ebp
80104dd1:	c3                   	ret    
80104dd2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104de0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104de0:	55                   	push   %ebp
80104de1:	89 e5                	mov    %esp,%ebp
80104de3:	56                   	push   %esi
80104de4:	53                   	push   %ebx
80104de5:	8b 45 08             	mov    0x8(%ebp),%eax
80104de8:	8b 75 0c             	mov    0xc(%ebp),%esi
80104deb:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104dee:	39 c6                	cmp    %eax,%esi
80104df0:	73 2e                	jae    80104e20 <memmove+0x40>
80104df2:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104df5:	39 c8                	cmp    %ecx,%eax
80104df7:	73 27                	jae    80104e20 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
80104df9:	85 db                	test   %ebx,%ebx
80104dfb:	8d 53 ff             	lea    -0x1(%ebx),%edx
80104dfe:	74 17                	je     80104e17 <memmove+0x37>
      *--d = *--s;
80104e00:	29 d9                	sub    %ebx,%ecx
80104e02:	89 cb                	mov    %ecx,%ebx
80104e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e08:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104e0c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80104e0f:	83 ea 01             	sub    $0x1,%edx
80104e12:	83 fa ff             	cmp    $0xffffffff,%edx
80104e15:	75 f1                	jne    80104e08 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104e17:	5b                   	pop    %ebx
80104e18:	5e                   	pop    %esi
80104e19:	5d                   	pop    %ebp
80104e1a:	c3                   	ret    
80104e1b:	90                   	nop
80104e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104e20:	31 d2                	xor    %edx,%edx
80104e22:	85 db                	test   %ebx,%ebx
80104e24:	74 f1                	je     80104e17 <memmove+0x37>
80104e26:	8d 76 00             	lea    0x0(%esi),%esi
80104e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
80104e30:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104e34:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104e37:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104e3a:	39 d3                	cmp    %edx,%ebx
80104e3c:	75 f2                	jne    80104e30 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
80104e3e:	5b                   	pop    %ebx
80104e3f:	5e                   	pop    %esi
80104e40:	5d                   	pop    %ebp
80104e41:	c3                   	ret    
80104e42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e50 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104e53:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104e54:	eb 8a                	jmp    80104de0 <memmove>
80104e56:	8d 76 00             	lea    0x0(%esi),%esi
80104e59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e60 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	57                   	push   %edi
80104e64:	56                   	push   %esi
80104e65:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104e68:	53                   	push   %ebx
80104e69:	8b 7d 08             	mov    0x8(%ebp),%edi
80104e6c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104e6f:	85 c9                	test   %ecx,%ecx
80104e71:	74 37                	je     80104eaa <strncmp+0x4a>
80104e73:	0f b6 17             	movzbl (%edi),%edx
80104e76:	0f b6 1e             	movzbl (%esi),%ebx
80104e79:	84 d2                	test   %dl,%dl
80104e7b:	74 3f                	je     80104ebc <strncmp+0x5c>
80104e7d:	38 d3                	cmp    %dl,%bl
80104e7f:	75 3b                	jne    80104ebc <strncmp+0x5c>
80104e81:	8d 47 01             	lea    0x1(%edi),%eax
80104e84:	01 cf                	add    %ecx,%edi
80104e86:	eb 1b                	jmp    80104ea3 <strncmp+0x43>
80104e88:	90                   	nop
80104e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e90:	0f b6 10             	movzbl (%eax),%edx
80104e93:	84 d2                	test   %dl,%dl
80104e95:	74 21                	je     80104eb8 <strncmp+0x58>
80104e97:	0f b6 19             	movzbl (%ecx),%ebx
80104e9a:	83 c0 01             	add    $0x1,%eax
80104e9d:	89 ce                	mov    %ecx,%esi
80104e9f:	38 da                	cmp    %bl,%dl
80104ea1:	75 19                	jne    80104ebc <strncmp+0x5c>
80104ea3:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104ea5:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104ea8:	75 e6                	jne    80104e90 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104eaa:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
80104eab:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
80104ead:	5e                   	pop    %esi
80104eae:	5f                   	pop    %edi
80104eaf:	5d                   	pop    %ebp
80104eb0:	c3                   	ret    
80104eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104eb8:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104ebc:	0f b6 c2             	movzbl %dl,%eax
80104ebf:	29 d8                	sub    %ebx,%eax
}
80104ec1:	5b                   	pop    %ebx
80104ec2:	5e                   	pop    %esi
80104ec3:	5f                   	pop    %edi
80104ec4:	5d                   	pop    %ebp
80104ec5:	c3                   	ret    
80104ec6:	8d 76 00             	lea    0x0(%esi),%esi
80104ec9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ed0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	56                   	push   %esi
80104ed4:	53                   	push   %ebx
80104ed5:	8b 45 08             	mov    0x8(%ebp),%eax
80104ed8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104edb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104ede:	89 c2                	mov    %eax,%edx
80104ee0:	eb 19                	jmp    80104efb <strncpy+0x2b>
80104ee2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ee8:	83 c3 01             	add    $0x1,%ebx
80104eeb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104eef:	83 c2 01             	add    $0x1,%edx
80104ef2:	84 c9                	test   %cl,%cl
80104ef4:	88 4a ff             	mov    %cl,-0x1(%edx)
80104ef7:	74 09                	je     80104f02 <strncpy+0x32>
80104ef9:	89 f1                	mov    %esi,%ecx
80104efb:	85 c9                	test   %ecx,%ecx
80104efd:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104f00:	7f e6                	jg     80104ee8 <strncpy+0x18>
    ;
  while(n-- > 0)
80104f02:	31 c9                	xor    %ecx,%ecx
80104f04:	85 f6                	test   %esi,%esi
80104f06:	7e 17                	jle    80104f1f <strncpy+0x4f>
80104f08:	90                   	nop
80104f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104f10:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104f14:	89 f3                	mov    %esi,%ebx
80104f16:	83 c1 01             	add    $0x1,%ecx
80104f19:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
80104f1b:	85 db                	test   %ebx,%ebx
80104f1d:	7f f1                	jg     80104f10 <strncpy+0x40>
    *s++ = 0;
  return os;
}
80104f1f:	5b                   	pop    %ebx
80104f20:	5e                   	pop    %esi
80104f21:	5d                   	pop    %ebp
80104f22:	c3                   	ret    
80104f23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104f30 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	56                   	push   %esi
80104f34:	53                   	push   %ebx
80104f35:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104f38:	8b 45 08             	mov    0x8(%ebp),%eax
80104f3b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104f3e:	85 c9                	test   %ecx,%ecx
80104f40:	7e 26                	jle    80104f68 <safestrcpy+0x38>
80104f42:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104f46:	89 c1                	mov    %eax,%ecx
80104f48:	eb 17                	jmp    80104f61 <safestrcpy+0x31>
80104f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104f50:	83 c2 01             	add    $0x1,%edx
80104f53:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104f57:	83 c1 01             	add    $0x1,%ecx
80104f5a:	84 db                	test   %bl,%bl
80104f5c:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104f5f:	74 04                	je     80104f65 <safestrcpy+0x35>
80104f61:	39 f2                	cmp    %esi,%edx
80104f63:	75 eb                	jne    80104f50 <safestrcpy+0x20>
    ;
  *s = 0;
80104f65:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104f68:	5b                   	pop    %ebx
80104f69:	5e                   	pop    %esi
80104f6a:	5d                   	pop    %ebp
80104f6b:	c3                   	ret    
80104f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f70 <strlen>:

int
strlen(const char *s)
{
80104f70:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104f71:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104f73:	89 e5                	mov    %esp,%ebp
80104f75:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104f78:	80 3a 00             	cmpb   $0x0,(%edx)
80104f7b:	74 0c                	je     80104f89 <strlen+0x19>
80104f7d:	8d 76 00             	lea    0x0(%esi),%esi
80104f80:	83 c0 01             	add    $0x1,%eax
80104f83:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104f87:	75 f7                	jne    80104f80 <strlen+0x10>
    ;
  return n;
}
80104f89:	5d                   	pop    %ebp
80104f8a:	c3                   	ret    

80104f8b <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104f8b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104f8f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104f93:	55                   	push   %ebp
  pushl %ebx
80104f94:	53                   	push   %ebx
  pushl %esi
80104f95:	56                   	push   %esi
  pushl %edi
80104f96:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104f97:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104f99:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80104f9b:	5f                   	pop    %edi
  popl %esi
80104f9c:	5e                   	pop    %esi
  popl %ebx
80104f9d:	5b                   	pop    %ebx
  popl %ebp
80104f9e:	5d                   	pop    %ebp
  ret
80104f9f:	c3                   	ret    

80104fa0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104fa0:	55                   	push   %ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80104fa1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104fa8:	89 e5                	mov    %esp,%ebp
80104faa:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
80104fad:	8b 12                	mov    (%edx),%edx
80104faf:	39 c2                	cmp    %eax,%edx
80104fb1:	76 15                	jbe    80104fc8 <fetchint+0x28>
80104fb3:	8d 48 04             	lea    0x4(%eax),%ecx
80104fb6:	39 ca                	cmp    %ecx,%edx
80104fb8:	72 0e                	jb     80104fc8 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
80104fba:	8b 10                	mov    (%eax),%edx
80104fbc:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fbf:	89 10                	mov    %edx,(%eax)
  return 0;
80104fc1:	31 c0                	xor    %eax,%eax
}
80104fc3:	5d                   	pop    %ebp
80104fc4:	c3                   	ret    
80104fc5:	8d 76 00             	lea    0x0(%esi),%esi
// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
80104fc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  *ip = *(int*)(addr);
  return 0;
}
80104fcd:	5d                   	pop    %ebp
80104fce:	c3                   	ret    
80104fcf:	90                   	nop

80104fd0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104fd0:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= proc->sz)
80104fd1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104fd7:	89 e5                	mov    %esp,%ebp
80104fd9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  char *s, *ep;

  if(addr >= proc->sz)
80104fdc:	39 08                	cmp    %ecx,(%eax)
80104fde:	76 2c                	jbe    8010500c <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104fe0:	8b 55 0c             	mov    0xc(%ebp),%edx
80104fe3:	89 c8                	mov    %ecx,%eax
80104fe5:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
80104fe7:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104fee:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
80104ff0:	39 d1                	cmp    %edx,%ecx
80104ff2:	73 18                	jae    8010500c <fetchstr+0x3c>
    if(*s == 0)
80104ff4:	80 39 00             	cmpb   $0x0,(%ecx)
80104ff7:	75 0c                	jne    80105005 <fetchstr+0x35>
80104ff9:	eb 1d                	jmp    80105018 <fetchstr+0x48>
80104ffb:	90                   	nop
80104ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105000:	80 38 00             	cmpb   $0x0,(%eax)
80105003:	74 13                	je     80105018 <fetchstr+0x48>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80105005:	83 c0 01             	add    $0x1,%eax
80105008:	39 c2                	cmp    %eax,%edx
8010500a:	77 f4                	ja     80105000 <fetchstr+0x30>
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
    return -1;
8010500c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
  return -1;
}
80105011:	5d                   	pop    %ebp
80105012:	c3                   	ret    
80105013:	90                   	nop
80105014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
80105018:	29 c8                	sub    %ecx,%eax
  return -1;
}
8010501a:	5d                   	pop    %ebp
8010501b:	c3                   	ret    
8010501c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105020 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
80105020:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105026:	55                   	push   %ebp
80105027:	89 e5                	mov    %esp,%ebp
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
80105029:	8b 40 10             	mov    0x10(%eax),%eax
8010502c:	8b 55 08             	mov    0x8(%ebp),%edx
8010502f:	8b 40 44             	mov    0x44(%eax),%eax
80105032:	8d 04 90             	lea    (%eax,%edx,4),%eax

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80105035:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
8010503c:	8d 48 04             	lea    0x4(%eax),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010503f:	8b 12                	mov    (%edx),%edx
80105041:	39 d1                	cmp    %edx,%ecx
80105043:	73 1b                	jae    80105060 <argint+0x40>
80105045:	8d 48 08             	lea    0x8(%eax),%ecx
80105048:	39 ca                	cmp    %ecx,%edx
8010504a:	72 14                	jb     80105060 <argint+0x40>
    return -1;
  *ip = *(int*)(addr);
8010504c:	8b 50 04             	mov    0x4(%eax),%edx
8010504f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105052:	89 10                	mov    %edx,(%eax)
  return 0;
80105054:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
}
80105056:	5d                   	pop    %ebp
80105057:	c3                   	ret    
80105058:	90                   	nop
80105059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
80105060:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
}
80105065:	5d                   	pop    %ebp
80105066:	c3                   	ret    
80105067:	89 f6                	mov    %esi,%esi
80105069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105070 <argptr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
80105070:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105076:	55                   	push   %ebp
80105077:	89 e5                	mov    %esp,%ebp
80105079:	53                   	push   %ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
8010507a:	8b 40 10             	mov    0x10(%eax),%eax
8010507d:	8b 55 08             	mov    0x8(%ebp),%edx
80105080:	8b 40 44             	mov    0x44(%eax),%eax
80105083:	8d 0c 90             	lea    (%eax,%edx,4),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80105086:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
8010508c:	8d 59 04             	lea    0x4(%ecx),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010508f:	8b 10                	mov    (%eax),%edx
argptr(int n, char **pp, int size)
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
80105091:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80105096:	39 d3                	cmp    %edx,%ebx
80105098:	73 1e                	jae    801050b8 <argptr+0x48>
8010509a:	8d 59 08             	lea    0x8(%ecx),%ebx
8010509d:	39 da                	cmp    %ebx,%edx
8010509f:	72 17                	jb     801050b8 <argptr+0x48>
    return -1;
  *ip = *(int*)(addr);
801050a1:	8b 49 04             	mov    0x4(%ecx),%ecx
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
801050a4:	39 d1                	cmp    %edx,%ecx
801050a6:	73 10                	jae    801050b8 <argptr+0x48>
801050a8:	8b 5d 10             	mov    0x10(%ebp),%ebx
801050ab:	01 cb                	add    %ecx,%ebx
801050ad:	39 d3                	cmp    %edx,%ebx
801050af:	77 07                	ja     801050b8 <argptr+0x48>
    return -1;
  *pp = (char*)i;
801050b1:	8b 45 0c             	mov    0xc(%ebp),%eax
801050b4:	89 08                	mov    %ecx,(%eax)
  return 0;
801050b6:	31 c0                	xor    %eax,%eax
}
801050b8:	5b                   	pop    %ebx
801050b9:	5d                   	pop    %ebp
801050ba:	c3                   	ret    
801050bb:	90                   	nop
801050bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801050c0 <argstr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
801050c0:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801050c6:	55                   	push   %ebp
801050c7:	89 e5                	mov    %esp,%ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
801050c9:	8b 40 10             	mov    0x10(%eax),%eax
801050cc:	8b 55 08             	mov    0x8(%ebp),%edx
801050cf:	8b 40 44             	mov    0x44(%eax),%eax
801050d2:	8d 14 90             	lea    (%eax,%edx,4),%edx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801050d5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(thread->tf->esp + 4 + 4*n, ip);
801050db:	8d 4a 04             	lea    0x4(%edx),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801050de:	8b 00                	mov    (%eax),%eax
801050e0:	39 c1                	cmp    %eax,%ecx
801050e2:	73 07                	jae    801050eb <argstr+0x2b>
801050e4:	8d 4a 08             	lea    0x8(%edx),%ecx
801050e7:	39 c8                	cmp    %ecx,%eax
801050e9:	73 0d                	jae    801050f8 <argstr+0x38>
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
801050eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
801050f0:	5d                   	pop    %ebp
801050f1:	c3                   	ret    
801050f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
801050f8:	8b 4a 04             	mov    0x4(%edx),%ecx
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
801050fb:	39 c1                	cmp    %eax,%ecx
801050fd:	73 ec                	jae    801050eb <argstr+0x2b>
    return -1;
  *pp = (char*)addr;
801050ff:	8b 55 0c             	mov    0xc(%ebp),%edx
80105102:	89 c8                	mov    %ecx,%eax
80105104:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
80105106:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010510d:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
8010510f:	39 d1                	cmp    %edx,%ecx
80105111:	73 d8                	jae    801050eb <argstr+0x2b>
    if(*s == 0)
80105113:	80 39 00             	cmpb   $0x0,(%ecx)
80105116:	75 0d                	jne    80105125 <argstr+0x65>
80105118:	eb 16                	jmp    80105130 <argstr+0x70>
8010511a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105120:	80 38 00             	cmpb   $0x0,(%eax)
80105123:	74 0b                	je     80105130 <argstr+0x70>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
80105125:	83 c0 01             	add    $0x1,%eax
80105128:	39 c2                	cmp    %eax,%edx
8010512a:	77 f4                	ja     80105120 <argstr+0x60>
8010512c:	eb bd                	jmp    801050eb <argstr+0x2b>
8010512e:	66 90                	xchg   %ax,%ax
    if(*s == 0)
      return s - *pp;
80105130:	29 c8                	sub    %ecx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80105132:	5d                   	pop    %ebp
80105133:	c3                   	ret    
80105134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010513a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105140 <syscall>:
};


void
syscall(void)
{
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	53                   	push   %ebx
80105144:	83 ec 04             	sub    $0x4,%esp
  int num;

  num = thread->tf->eax;
80105147:	65 8b 15 08 00 00 00 	mov    %gs:0x8,%edx
8010514e:	8b 5a 10             	mov    0x10(%edx),%ebx
80105151:	8b 43 1c             	mov    0x1c(%ebx),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105154:	8d 48 ff             	lea    -0x1(%eax),%ecx
80105157:	83 f9 1d             	cmp    $0x1d,%ecx
8010515a:	77 1c                	ja     80105178 <syscall+0x38>
8010515c:	8b 0c 85 20 83 10 80 	mov    -0x7fef7ce0(,%eax,4),%ecx
80105163:	85 c9                	test   %ecx,%ecx
80105165:	74 11                	je     80105178 <syscall+0x38>
    thread->tf->eax = syscalls[num]();
80105167:	ff d1                	call   *%ecx
80105169:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            thread->tid, proc->name, num);
    thread->tf->eax = -1;
  }
}
8010516c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010516f:	c9                   	leave  
80105170:	c3                   	ret    
80105171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  num = thread->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    thread->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105178:	50                   	push   %eax
            thread->tid, proc->name, num);
80105179:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010517f:	83 c0 5c             	add    $0x5c,%eax

  num = thread->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    thread->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105182:	50                   	push   %eax
80105183:	ff 32                	pushl  (%edx)
80105185:	68 f6 82 10 80       	push   $0x801082f6
8010518a:	e8 b1 b4 ff ff       	call   80100640 <cprintf>
            thread->tid, proc->name, num);
    thread->tf->eax = -1;
8010518f:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80105195:	83 c4 10             	add    $0x10,%esp
80105198:	8b 40 10             	mov    0x10(%eax),%eax
8010519b:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801051a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801051a5:	c9                   	leave  
801051a6:	c3                   	ret    
801051a7:	66 90                	xchg   %ax,%ax
801051a9:	66 90                	xchg   %ax,%ax
801051ab:	66 90                	xchg   %ax,%ax
801051ad:	66 90                	xchg   %ax,%ax
801051af:	90                   	nop

801051b0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801051b0:	55                   	push   %ebp
801051b1:	89 e5                	mov    %esp,%ebp
801051b3:	57                   	push   %edi
801051b4:	56                   	push   %esi
801051b5:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801051b6:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801051b9:	83 ec 44             	sub    $0x44,%esp
801051bc:	89 4d c0             	mov    %ecx,-0x40(%ebp)
801051bf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801051c2:	56                   	push   %esi
801051c3:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801051c4:	89 55 c4             	mov    %edx,-0x3c(%ebp)
801051c7:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801051ca:	e8 61 cd ff ff       	call   80101f30 <nameiparent>
801051cf:	83 c4 10             	add    $0x10,%esp
801051d2:	85 c0                	test   %eax,%eax
801051d4:	0f 84 f6 00 00 00    	je     801052d0 <create+0x120>
    return 0;
  ilock(dp);
801051da:	83 ec 0c             	sub    $0xc,%esp
801051dd:	89 c7                	mov    %eax,%edi
801051df:	50                   	push   %eax
801051e0:	e8 9b c4 ff ff       	call   80101680 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
801051e5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801051e8:	83 c4 0c             	add    $0xc,%esp
801051eb:	50                   	push   %eax
801051ec:	56                   	push   %esi
801051ed:	57                   	push   %edi
801051ee:	e8 fd c9 ff ff       	call   80101bf0 <dirlookup>
801051f3:	83 c4 10             	add    $0x10,%esp
801051f6:	85 c0                	test   %eax,%eax
801051f8:	89 c3                	mov    %eax,%ebx
801051fa:	74 54                	je     80105250 <create+0xa0>
    iunlockput(dp);
801051fc:	83 ec 0c             	sub    $0xc,%esp
801051ff:	57                   	push   %edi
80105200:	e8 4b c7 ff ff       	call   80101950 <iunlockput>
    ilock(ip);
80105205:	89 1c 24             	mov    %ebx,(%esp)
80105208:	e8 73 c4 ff ff       	call   80101680 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010520d:	83 c4 10             	add    $0x10,%esp
80105210:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80105215:	75 19                	jne    80105230 <create+0x80>
80105217:	66 83 7b 10 02       	cmpw   $0x2,0x10(%ebx)
8010521c:	89 d8                	mov    %ebx,%eax
8010521e:	75 10                	jne    80105230 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105220:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105223:	5b                   	pop    %ebx
80105224:	5e                   	pop    %esi
80105225:	5f                   	pop    %edi
80105226:	5d                   	pop    %ebp
80105227:	c3                   	ret    
80105228:	90                   	nop
80105229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
80105230:	83 ec 0c             	sub    $0xc,%esp
80105233:	53                   	push   %ebx
80105234:	e8 17 c7 ff ff       	call   80101950 <iunlockput>
    return 0;
80105239:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010523c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
8010523f:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105241:	5b                   	pop    %ebx
80105242:	5e                   	pop    %esi
80105243:	5f                   	pop    %edi
80105244:	5d                   	pop    %ebp
80105245:	c3                   	ret    
80105246:	8d 76 00             	lea    0x0(%esi),%esi
80105249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105250:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80105254:	83 ec 08             	sub    $0x8,%esp
80105257:	50                   	push   %eax
80105258:	ff 37                	pushl  (%edi)
8010525a:	e8 b1 c2 ff ff       	call   80101510 <ialloc>
8010525f:	83 c4 10             	add    $0x10,%esp
80105262:	85 c0                	test   %eax,%eax
80105264:	89 c3                	mov    %eax,%ebx
80105266:	0f 84 cc 00 00 00    	je     80105338 <create+0x188>
    panic("create: ialloc");

  ilock(ip);
8010526c:	83 ec 0c             	sub    $0xc,%esp
8010526f:	50                   	push   %eax
80105270:	e8 0b c4 ff ff       	call   80101680 <ilock>
  ip->major = major;
80105275:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80105279:	66 89 43 12          	mov    %ax,0x12(%ebx)
  ip->minor = minor;
8010527d:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80105281:	66 89 43 14          	mov    %ax,0x14(%ebx)
  ip->nlink = 1;
80105285:	b8 01 00 00 00       	mov    $0x1,%eax
8010528a:	66 89 43 16          	mov    %ax,0x16(%ebx)
  iupdate(ip);
8010528e:	89 1c 24             	mov    %ebx,(%esp)
80105291:	e8 3a c3 ff ff       	call   801015d0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80105296:	83 c4 10             	add    $0x10,%esp
80105299:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
8010529e:	74 40                	je     801052e0 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
801052a0:	83 ec 04             	sub    $0x4,%esp
801052a3:	ff 73 04             	pushl  0x4(%ebx)
801052a6:	56                   	push   %esi
801052a7:	57                   	push   %edi
801052a8:	e8 a3 cb ff ff       	call   80101e50 <dirlink>
801052ad:	83 c4 10             	add    $0x10,%esp
801052b0:	85 c0                	test   %eax,%eax
801052b2:	78 77                	js     8010532b <create+0x17b>
    panic("create: dirlink");

  iunlockput(dp);
801052b4:	83 ec 0c             	sub    $0xc,%esp
801052b7:	57                   	push   %edi
801052b8:	e8 93 c6 ff ff       	call   80101950 <iunlockput>

  return ip;
801052bd:	83 c4 10             	add    $0x10,%esp
}
801052c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
801052c3:	89 d8                	mov    %ebx,%eax
}
801052c5:	5b                   	pop    %ebx
801052c6:	5e                   	pop    %esi
801052c7:	5f                   	pop    %edi
801052c8:	5d                   	pop    %ebp
801052c9:	c3                   	ret    
801052ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
801052d0:	31 c0                	xor    %eax,%eax
801052d2:	e9 49 ff ff ff       	jmp    80105220 <create+0x70>
801052d7:	89 f6                	mov    %esi,%esi
801052d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
801052e0:	66 83 47 16 01       	addw   $0x1,0x16(%edi)
    iupdate(dp);
801052e5:	83 ec 0c             	sub    $0xc,%esp
801052e8:	57                   	push   %edi
801052e9:	e8 e2 c2 ff ff       	call   801015d0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801052ee:	83 c4 0c             	add    $0xc,%esp
801052f1:	ff 73 04             	pushl  0x4(%ebx)
801052f4:	68 b8 83 10 80       	push   $0x801083b8
801052f9:	53                   	push   %ebx
801052fa:	e8 51 cb ff ff       	call   80101e50 <dirlink>
801052ff:	83 c4 10             	add    $0x10,%esp
80105302:	85 c0                	test   %eax,%eax
80105304:	78 18                	js     8010531e <create+0x16e>
80105306:	83 ec 04             	sub    $0x4,%esp
80105309:	ff 77 04             	pushl  0x4(%edi)
8010530c:	68 b7 83 10 80       	push   $0x801083b7
80105311:	53                   	push   %ebx
80105312:	e8 39 cb ff ff       	call   80101e50 <dirlink>
80105317:	83 c4 10             	add    $0x10,%esp
8010531a:	85 c0                	test   %eax,%eax
8010531c:	79 82                	jns    801052a0 <create+0xf0>
      panic("create dots");
8010531e:	83 ec 0c             	sub    $0xc,%esp
80105321:	68 ab 83 10 80       	push   $0x801083ab
80105326:	e8 25 b0 ff ff       	call   80100350 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
8010532b:	83 ec 0c             	sub    $0xc,%esp
8010532e:	68 ba 83 10 80       	push   $0x801083ba
80105333:	e8 18 b0 ff ff       	call   80100350 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80105338:	83 ec 0c             	sub    $0xc,%esp
8010533b:	68 9c 83 10 80       	push   $0x8010839c
80105340:	e8 0b b0 ff ff       	call   80100350 <panic>
80105345:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105350 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80105350:	55                   	push   %ebp
80105351:	89 e5                	mov    %esp,%ebp
80105353:	56                   	push   %esi
80105354:	53                   	push   %ebx
80105355:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80105357:	8d 45 f4             	lea    -0xc(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
8010535a:	89 d3                	mov    %edx,%ebx
8010535c:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010535f:	50                   	push   %eax
80105360:	6a 00                	push   $0x0
80105362:	e8 b9 fc ff ff       	call   80105020 <argint>
80105367:	83 c4 10             	add    $0x10,%esp
8010536a:	85 c0                	test   %eax,%eax
8010536c:	78 3a                	js     801053a8 <argfd.constprop.0+0x58>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
8010536e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105371:	83 f8 0f             	cmp    $0xf,%eax
80105374:	77 32                	ja     801053a8 <argfd.constprop.0+0x58>
80105376:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010537d:	8b 54 82 18          	mov    0x18(%edx,%eax,4),%edx
80105381:	85 d2                	test   %edx,%edx
80105383:	74 23                	je     801053a8 <argfd.constprop.0+0x58>
    return -1;
  if(pfd)
80105385:	85 f6                	test   %esi,%esi
80105387:	74 02                	je     8010538b <argfd.constprop.0+0x3b>
    *pfd = fd;
80105389:	89 06                	mov    %eax,(%esi)
  if(pf)
8010538b:	85 db                	test   %ebx,%ebx
8010538d:	74 11                	je     801053a0 <argfd.constprop.0+0x50>
    *pf = f;
8010538f:	89 13                	mov    %edx,(%ebx)
  return 0;
80105391:	31 c0                	xor    %eax,%eax
}
80105393:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105396:	5b                   	pop    %ebx
80105397:	5e                   	pop    %esi
80105398:	5d                   	pop    %ebp
80105399:	c3                   	ret    
8010539a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
801053a0:	31 c0                	xor    %eax,%eax
801053a2:	eb ef                	jmp    80105393 <argfd.constprop.0+0x43>
801053a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
801053a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053ad:	eb e4                	jmp    80105393 <argfd.constprop.0+0x43>
801053af:	90                   	nop

801053b0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
801053b0:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801053b1:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
801053b3:	89 e5                	mov    %esp,%ebp
801053b5:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801053b6:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
801053b9:	83 ec 14             	sub    $0x14,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801053bc:	e8 8f ff ff ff       	call   80105350 <argfd.constprop.0>
801053c1:	85 c0                	test   %eax,%eax
801053c3:	78 1b                	js     801053e0 <sys_dup+0x30>
    return -1;
  if((fd=fdalloc(f)) < 0)
801053c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801053c8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801053ce:	31 db                	xor    %ebx,%ebx
    if(proc->ofile[fd] == 0){
801053d0:	8b 4c 98 18          	mov    0x18(%eax,%ebx,4),%ecx
801053d4:	85 c9                	test   %ecx,%ecx
801053d6:	74 18                	je     801053f0 <sys_dup+0x40>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801053d8:	83 c3 01             	add    $0x1,%ebx
801053db:	83 fb 10             	cmp    $0x10,%ebx
801053de:	75 f0                	jne    801053d0 <sys_dup+0x20>
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
801053e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
801053e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801053e8:	c9                   	leave  
801053e9:	c3                   	ret    
801053ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
801053f0:	83 ec 0c             	sub    $0xc,%esp
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
801053f3:	89 54 98 18          	mov    %edx,0x18(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
801053f7:	52                   	push   %edx
801053f8:	e8 33 ba ff ff       	call   80100e30 <filedup>
  return fd;
801053fd:	89 d8                	mov    %ebx,%eax
801053ff:	83 c4 10             	add    $0x10,%esp
}
80105402:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105405:	c9                   	leave  
80105406:	c3                   	ret    
80105407:	89 f6                	mov    %esi,%esi
80105409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105410 <sys_read>:

int
sys_read(void)
{
80105410:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105411:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80105413:	89 e5                	mov    %esp,%ebp
80105415:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105418:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010541b:	e8 30 ff ff ff       	call   80105350 <argfd.constprop.0>
80105420:	85 c0                	test   %eax,%eax
80105422:	78 4c                	js     80105470 <sys_read+0x60>
80105424:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105427:	83 ec 08             	sub    $0x8,%esp
8010542a:	50                   	push   %eax
8010542b:	6a 02                	push   $0x2
8010542d:	e8 ee fb ff ff       	call   80105020 <argint>
80105432:	83 c4 10             	add    $0x10,%esp
80105435:	85 c0                	test   %eax,%eax
80105437:	78 37                	js     80105470 <sys_read+0x60>
80105439:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010543c:	83 ec 04             	sub    $0x4,%esp
8010543f:	ff 75 f0             	pushl  -0x10(%ebp)
80105442:	50                   	push   %eax
80105443:	6a 01                	push   $0x1
80105445:	e8 26 fc ff ff       	call   80105070 <argptr>
8010544a:	83 c4 10             	add    $0x10,%esp
8010544d:	85 c0                	test   %eax,%eax
8010544f:	78 1f                	js     80105470 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80105451:	83 ec 04             	sub    $0x4,%esp
80105454:	ff 75 f0             	pushl  -0x10(%ebp)
80105457:	ff 75 f4             	pushl  -0xc(%ebp)
8010545a:	ff 75 ec             	pushl  -0x14(%ebp)
8010545d:	e8 3e bb ff ff       	call   80100fa0 <fileread>
80105462:	83 c4 10             	add    $0x10,%esp
}
80105465:	c9                   	leave  
80105466:	c3                   	ret    
80105467:	89 f6                	mov    %esi,%esi
80105469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80105470:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80105475:	c9                   	leave  
80105476:	c3                   	ret    
80105477:	89 f6                	mov    %esi,%esi
80105479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105480 <sys_write>:

int
sys_write(void)
{
80105480:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105481:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80105483:	89 e5                	mov    %esp,%ebp
80105485:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105488:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010548b:	e8 c0 fe ff ff       	call   80105350 <argfd.constprop.0>
80105490:	85 c0                	test   %eax,%eax
80105492:	78 4c                	js     801054e0 <sys_write+0x60>
80105494:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105497:	83 ec 08             	sub    $0x8,%esp
8010549a:	50                   	push   %eax
8010549b:	6a 02                	push   $0x2
8010549d:	e8 7e fb ff ff       	call   80105020 <argint>
801054a2:	83 c4 10             	add    $0x10,%esp
801054a5:	85 c0                	test   %eax,%eax
801054a7:	78 37                	js     801054e0 <sys_write+0x60>
801054a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054ac:	83 ec 04             	sub    $0x4,%esp
801054af:	ff 75 f0             	pushl  -0x10(%ebp)
801054b2:	50                   	push   %eax
801054b3:	6a 01                	push   $0x1
801054b5:	e8 b6 fb ff ff       	call   80105070 <argptr>
801054ba:	83 c4 10             	add    $0x10,%esp
801054bd:	85 c0                	test   %eax,%eax
801054bf:	78 1f                	js     801054e0 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
801054c1:	83 ec 04             	sub    $0x4,%esp
801054c4:	ff 75 f0             	pushl  -0x10(%ebp)
801054c7:	ff 75 f4             	pushl  -0xc(%ebp)
801054ca:	ff 75 ec             	pushl  -0x14(%ebp)
801054cd:	e8 5e bb ff ff       	call   80101030 <filewrite>
801054d2:	83 c4 10             	add    $0x10,%esp
}
801054d5:	c9                   	leave  
801054d6:	c3                   	ret    
801054d7:	89 f6                	mov    %esi,%esi
801054d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
801054e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
801054e5:	c9                   	leave  
801054e6:	c3                   	ret    
801054e7:	89 f6                	mov    %esi,%esi
801054e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801054f0 <sys_close>:

int
sys_close(void)
{
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
801054f3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
801054f6:	8d 55 f4             	lea    -0xc(%ebp),%edx
801054f9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054fc:	e8 4f fe ff ff       	call   80105350 <argfd.constprop.0>
80105501:	85 c0                	test   %eax,%eax
80105503:	78 2b                	js     80105530 <sys_close+0x40>
    return -1;
  proc->ofile[fd] = 0;
80105505:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105508:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  fileclose(f);
8010550e:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  proc->ofile[fd] = 0;
80105511:	c7 44 90 18 00 00 00 	movl   $0x0,0x18(%eax,%edx,4)
80105518:	00 
  fileclose(f);
80105519:	ff 75 f4             	pushl  -0xc(%ebp)
8010551c:	e8 5f b9 ff ff       	call   80100e80 <fileclose>
  return 0;
80105521:	83 c4 10             	add    $0x10,%esp
80105524:	31 c0                	xor    %eax,%eax
}
80105526:	c9                   	leave  
80105527:	c3                   	ret    
80105528:	90                   	nop
80105529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80105530:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  proc->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80105535:	c9                   	leave  
80105536:	c3                   	ret    
80105537:	89 f6                	mov    %esi,%esi
80105539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105540 <sys_fstat>:

int
sys_fstat(void)
{
80105540:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105541:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80105543:	89 e5                	mov    %esp,%ebp
80105545:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105548:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010554b:	e8 00 fe ff ff       	call   80105350 <argfd.constprop.0>
80105550:	85 c0                	test   %eax,%eax
80105552:	78 2c                	js     80105580 <sys_fstat+0x40>
80105554:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105557:	83 ec 04             	sub    $0x4,%esp
8010555a:	6a 14                	push   $0x14
8010555c:	50                   	push   %eax
8010555d:	6a 01                	push   $0x1
8010555f:	e8 0c fb ff ff       	call   80105070 <argptr>
80105564:	83 c4 10             	add    $0x10,%esp
80105567:	85 c0                	test   %eax,%eax
80105569:	78 15                	js     80105580 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
8010556b:	83 ec 08             	sub    $0x8,%esp
8010556e:	ff 75 f4             	pushl  -0xc(%ebp)
80105571:	ff 75 f0             	pushl  -0x10(%ebp)
80105574:	e8 d7 b9 ff ff       	call   80100f50 <filestat>
80105579:	83 c4 10             	add    $0x10,%esp
}
8010557c:	c9                   	leave  
8010557d:	c3                   	ret    
8010557e:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80105580:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80105585:	c9                   	leave  
80105586:	c3                   	ret    
80105587:	89 f6                	mov    %esi,%esi
80105589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105590 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	57                   	push   %edi
80105594:	56                   	push   %esi
80105595:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105596:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105599:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010559c:	50                   	push   %eax
8010559d:	6a 00                	push   $0x0
8010559f:	e8 1c fb ff ff       	call   801050c0 <argstr>
801055a4:	83 c4 10             	add    $0x10,%esp
801055a7:	85 c0                	test   %eax,%eax
801055a9:	0f 88 fb 00 00 00    	js     801056aa <sys_link+0x11a>
801055af:	8d 45 d0             	lea    -0x30(%ebp),%eax
801055b2:	83 ec 08             	sub    $0x8,%esp
801055b5:	50                   	push   %eax
801055b6:	6a 01                	push   $0x1
801055b8:	e8 03 fb ff ff       	call   801050c0 <argstr>
801055bd:	83 c4 10             	add    $0x10,%esp
801055c0:	85 c0                	test   %eax,%eax
801055c2:	0f 88 e2 00 00 00    	js     801056aa <sys_link+0x11a>
    return -1;

  begin_op();
801055c8:	e8 63 d6 ff ff       	call   80102c30 <begin_op>
  if((ip = namei(old)) == 0){
801055cd:	83 ec 0c             	sub    $0xc,%esp
801055d0:	ff 75 d4             	pushl  -0x2c(%ebp)
801055d3:	e8 38 c9 ff ff       	call   80101f10 <namei>
801055d8:	83 c4 10             	add    $0x10,%esp
801055db:	85 c0                	test   %eax,%eax
801055dd:	89 c3                	mov    %eax,%ebx
801055df:	0f 84 f3 00 00 00    	je     801056d8 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
801055e5:	83 ec 0c             	sub    $0xc,%esp
801055e8:	50                   	push   %eax
801055e9:	e8 92 c0 ff ff       	call   80101680 <ilock>
  if(ip->type == T_DIR){
801055ee:	83 c4 10             	add    $0x10,%esp
801055f1:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
801055f6:	0f 84 c4 00 00 00    	je     801056c0 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
801055fc:	66 83 43 16 01       	addw   $0x1,0x16(%ebx)
  iupdate(ip);
80105601:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80105604:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80105607:	53                   	push   %ebx
80105608:	e8 c3 bf ff ff       	call   801015d0 <iupdate>
  iunlock(ip);
8010560d:	89 1c 24             	mov    %ebx,(%esp)
80105610:	e8 7b c1 ff ff       	call   80101790 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80105615:	58                   	pop    %eax
80105616:	5a                   	pop    %edx
80105617:	57                   	push   %edi
80105618:	ff 75 d0             	pushl  -0x30(%ebp)
8010561b:	e8 10 c9 ff ff       	call   80101f30 <nameiparent>
80105620:	83 c4 10             	add    $0x10,%esp
80105623:	85 c0                	test   %eax,%eax
80105625:	89 c6                	mov    %eax,%esi
80105627:	74 5b                	je     80105684 <sys_link+0xf4>
    goto bad;
  ilock(dp);
80105629:	83 ec 0c             	sub    $0xc,%esp
8010562c:	50                   	push   %eax
8010562d:	e8 4e c0 ff ff       	call   80101680 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105632:	83 c4 10             	add    $0x10,%esp
80105635:	8b 03                	mov    (%ebx),%eax
80105637:	39 06                	cmp    %eax,(%esi)
80105639:	75 3d                	jne    80105678 <sys_link+0xe8>
8010563b:	83 ec 04             	sub    $0x4,%esp
8010563e:	ff 73 04             	pushl  0x4(%ebx)
80105641:	57                   	push   %edi
80105642:	56                   	push   %esi
80105643:	e8 08 c8 ff ff       	call   80101e50 <dirlink>
80105648:	83 c4 10             	add    $0x10,%esp
8010564b:	85 c0                	test   %eax,%eax
8010564d:	78 29                	js     80105678 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
8010564f:	83 ec 0c             	sub    $0xc,%esp
80105652:	56                   	push   %esi
80105653:	e8 f8 c2 ff ff       	call   80101950 <iunlockput>
  iput(ip);
80105658:	89 1c 24             	mov    %ebx,(%esp)
8010565b:	e8 90 c1 ff ff       	call   801017f0 <iput>

  end_op();
80105660:	e8 3b d6 ff ff       	call   80102ca0 <end_op>

  return 0;
80105665:	83 c4 10             	add    $0x10,%esp
80105668:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
8010566a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010566d:	5b                   	pop    %ebx
8010566e:	5e                   	pop    %esi
8010566f:	5f                   	pop    %edi
80105670:	5d                   	pop    %ebp
80105671:	c3                   	ret    
80105672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80105678:	83 ec 0c             	sub    $0xc,%esp
8010567b:	56                   	push   %esi
8010567c:	e8 cf c2 ff ff       	call   80101950 <iunlockput>
    goto bad;
80105681:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80105684:	83 ec 0c             	sub    $0xc,%esp
80105687:	53                   	push   %ebx
80105688:	e8 f3 bf ff ff       	call   80101680 <ilock>
  ip->nlink--;
8010568d:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
80105692:	89 1c 24             	mov    %ebx,(%esp)
80105695:	e8 36 bf ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
8010569a:	89 1c 24             	mov    %ebx,(%esp)
8010569d:	e8 ae c2 ff ff       	call   80101950 <iunlockput>
  end_op();
801056a2:	e8 f9 d5 ff ff       	call   80102ca0 <end_op>
  return -1;
801056a7:	83 c4 10             	add    $0x10,%esp
}
801056aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
801056ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056b2:	5b                   	pop    %ebx
801056b3:	5e                   	pop    %esi
801056b4:	5f                   	pop    %edi
801056b5:	5d                   	pop    %ebp
801056b6:	c3                   	ret    
801056b7:	89 f6                	mov    %esi,%esi
801056b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
801056c0:	83 ec 0c             	sub    $0xc,%esp
801056c3:	53                   	push   %ebx
801056c4:	e8 87 c2 ff ff       	call   80101950 <iunlockput>
    end_op();
801056c9:	e8 d2 d5 ff ff       	call   80102ca0 <end_op>
    return -1;
801056ce:	83 c4 10             	add    $0x10,%esp
801056d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056d6:	eb 92                	jmp    8010566a <sys_link+0xda>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
801056d8:	e8 c3 d5 ff ff       	call   80102ca0 <end_op>
    return -1;
801056dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056e2:	eb 86                	jmp    8010566a <sys_link+0xda>
801056e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801056ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801056f0 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	57                   	push   %edi
801056f4:	56                   	push   %esi
801056f5:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801056f6:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
801056f9:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
801056fc:	50                   	push   %eax
801056fd:	6a 00                	push   $0x0
801056ff:	e8 bc f9 ff ff       	call   801050c0 <argstr>
80105704:	83 c4 10             	add    $0x10,%esp
80105707:	85 c0                	test   %eax,%eax
80105709:	0f 88 82 01 00 00    	js     80105891 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
8010570f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80105712:	e8 19 d5 ff ff       	call   80102c30 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105717:	83 ec 08             	sub    $0x8,%esp
8010571a:	53                   	push   %ebx
8010571b:	ff 75 c0             	pushl  -0x40(%ebp)
8010571e:	e8 0d c8 ff ff       	call   80101f30 <nameiparent>
80105723:	83 c4 10             	add    $0x10,%esp
80105726:	85 c0                	test   %eax,%eax
80105728:	89 45 b4             	mov    %eax,-0x4c(%ebp)
8010572b:	0f 84 6a 01 00 00    	je     8010589b <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80105731:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80105734:	83 ec 0c             	sub    $0xc,%esp
80105737:	56                   	push   %esi
80105738:	e8 43 bf ff ff       	call   80101680 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010573d:	58                   	pop    %eax
8010573e:	5a                   	pop    %edx
8010573f:	68 b8 83 10 80       	push   $0x801083b8
80105744:	53                   	push   %ebx
80105745:	e8 86 c4 ff ff       	call   80101bd0 <namecmp>
8010574a:	83 c4 10             	add    $0x10,%esp
8010574d:	85 c0                	test   %eax,%eax
8010574f:	0f 84 fc 00 00 00    	je     80105851 <sys_unlink+0x161>
80105755:	83 ec 08             	sub    $0x8,%esp
80105758:	68 b7 83 10 80       	push   $0x801083b7
8010575d:	53                   	push   %ebx
8010575e:	e8 6d c4 ff ff       	call   80101bd0 <namecmp>
80105763:	83 c4 10             	add    $0x10,%esp
80105766:	85 c0                	test   %eax,%eax
80105768:	0f 84 e3 00 00 00    	je     80105851 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
8010576e:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105771:	83 ec 04             	sub    $0x4,%esp
80105774:	50                   	push   %eax
80105775:	53                   	push   %ebx
80105776:	56                   	push   %esi
80105777:	e8 74 c4 ff ff       	call   80101bf0 <dirlookup>
8010577c:	83 c4 10             	add    $0x10,%esp
8010577f:	85 c0                	test   %eax,%eax
80105781:	89 c3                	mov    %eax,%ebx
80105783:	0f 84 c8 00 00 00    	je     80105851 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80105789:	83 ec 0c             	sub    $0xc,%esp
8010578c:	50                   	push   %eax
8010578d:	e8 ee be ff ff       	call   80101680 <ilock>

  if(ip->nlink < 1)
80105792:	83 c4 10             	add    $0x10,%esp
80105795:	66 83 7b 16 00       	cmpw   $0x0,0x16(%ebx)
8010579a:	0f 8e 24 01 00 00    	jle    801058c4 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
801057a0:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
801057a5:	8d 75 d8             	lea    -0x28(%ebp),%esi
801057a8:	74 66                	je     80105810 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
801057aa:	83 ec 04             	sub    $0x4,%esp
801057ad:	6a 10                	push   $0x10
801057af:	6a 00                	push   $0x0
801057b1:	56                   	push   %esi
801057b2:	e8 79 f5 ff ff       	call   80104d30 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801057b7:	6a 10                	push   $0x10
801057b9:	ff 75 c4             	pushl  -0x3c(%ebp)
801057bc:	56                   	push   %esi
801057bd:	ff 75 b4             	pushl  -0x4c(%ebp)
801057c0:	e8 db c2 ff ff       	call   80101aa0 <writei>
801057c5:	83 c4 20             	add    $0x20,%esp
801057c8:	83 f8 10             	cmp    $0x10,%eax
801057cb:	0f 85 e6 00 00 00    	jne    801058b7 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
801057d1:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
801057d6:	0f 84 9c 00 00 00    	je     80105878 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
801057dc:	83 ec 0c             	sub    $0xc,%esp
801057df:	ff 75 b4             	pushl  -0x4c(%ebp)
801057e2:	e8 69 c1 ff ff       	call   80101950 <iunlockput>

  ip->nlink--;
801057e7:	66 83 6b 16 01       	subw   $0x1,0x16(%ebx)
  iupdate(ip);
801057ec:	89 1c 24             	mov    %ebx,(%esp)
801057ef:	e8 dc bd ff ff       	call   801015d0 <iupdate>
  iunlockput(ip);
801057f4:	89 1c 24             	mov    %ebx,(%esp)
801057f7:	e8 54 c1 ff ff       	call   80101950 <iunlockput>

  end_op();
801057fc:	e8 9f d4 ff ff       	call   80102ca0 <end_op>

  return 0;
80105801:	83 c4 10             	add    $0x10,%esp
80105804:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105806:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105809:	5b                   	pop    %ebx
8010580a:	5e                   	pop    %esi
8010580b:	5f                   	pop    %edi
8010580c:	5d                   	pop    %ebp
8010580d:	c3                   	ret    
8010580e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105810:	83 7b 18 20          	cmpl   $0x20,0x18(%ebx)
80105814:	76 94                	jbe    801057aa <sys_unlink+0xba>
80105816:	bf 20 00 00 00       	mov    $0x20,%edi
8010581b:	eb 0f                	jmp    8010582c <sys_unlink+0x13c>
8010581d:	8d 76 00             	lea    0x0(%esi),%esi
80105820:	83 c7 10             	add    $0x10,%edi
80105823:	3b 7b 18             	cmp    0x18(%ebx),%edi
80105826:	0f 83 7e ff ff ff    	jae    801057aa <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010582c:	6a 10                	push   $0x10
8010582e:	57                   	push   %edi
8010582f:	56                   	push   %esi
80105830:	53                   	push   %ebx
80105831:	e8 6a c1 ff ff       	call   801019a0 <readi>
80105836:	83 c4 10             	add    $0x10,%esp
80105839:	83 f8 10             	cmp    $0x10,%eax
8010583c:	75 6c                	jne    801058aa <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
8010583e:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105843:	74 db                	je     80105820 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80105845:	83 ec 0c             	sub    $0xc,%esp
80105848:	53                   	push   %ebx
80105849:	e8 02 c1 ff ff       	call   80101950 <iunlockput>
    goto bad;
8010584e:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
80105851:	83 ec 0c             	sub    $0xc,%esp
80105854:	ff 75 b4             	pushl  -0x4c(%ebp)
80105857:	e8 f4 c0 ff ff       	call   80101950 <iunlockput>
  end_op();
8010585c:	e8 3f d4 ff ff       	call   80102ca0 <end_op>
  return -1;
80105861:	83 c4 10             	add    $0x10,%esp
}
80105864:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80105867:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010586c:	5b                   	pop    %ebx
8010586d:	5e                   	pop    %esi
8010586e:	5f                   	pop    %edi
8010586f:	5d                   	pop    %ebp
80105870:	c3                   	ret    
80105871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105878:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
8010587b:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
8010587e:	66 83 68 16 01       	subw   $0x1,0x16(%eax)
    iupdate(dp);
80105883:	50                   	push   %eax
80105884:	e8 47 bd ff ff       	call   801015d0 <iupdate>
80105889:	83 c4 10             	add    $0x10,%esp
8010588c:	e9 4b ff ff ff       	jmp    801057dc <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105891:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105896:	e9 6b ff ff ff       	jmp    80105806 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010589b:	e8 00 d4 ff ff       	call   80102ca0 <end_op>
    return -1;
801058a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058a5:	e9 5c ff ff ff       	jmp    80105806 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
801058aa:	83 ec 0c             	sub    $0xc,%esp
801058ad:	68 dc 83 10 80       	push   $0x801083dc
801058b2:	e8 99 aa ff ff       	call   80100350 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
801058b7:	83 ec 0c             	sub    $0xc,%esp
801058ba:	68 ee 83 10 80       	push   $0x801083ee
801058bf:	e8 8c aa ff ff       	call   80100350 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
801058c4:	83 ec 0c             	sub    $0xc,%esp
801058c7:	68 ca 83 10 80       	push   $0x801083ca
801058cc:	e8 7f aa ff ff       	call   80100350 <panic>
801058d1:	eb 0d                	jmp    801058e0 <sys_open>
801058d3:	90                   	nop
801058d4:	90                   	nop
801058d5:	90                   	nop
801058d6:	90                   	nop
801058d7:	90                   	nop
801058d8:	90                   	nop
801058d9:	90                   	nop
801058da:	90                   	nop
801058db:	90                   	nop
801058dc:	90                   	nop
801058dd:	90                   	nop
801058de:	90                   	nop
801058df:	90                   	nop

801058e0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	57                   	push   %edi
801058e4:	56                   	push   %esi
801058e5:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801058e6:	8d 45 e0             	lea    -0x20(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
801058e9:	83 ec 24             	sub    $0x24,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801058ec:	50                   	push   %eax
801058ed:	6a 00                	push   $0x0
801058ef:	e8 cc f7 ff ff       	call   801050c0 <argstr>
801058f4:	83 c4 10             	add    $0x10,%esp
801058f7:	85 c0                	test   %eax,%eax
801058f9:	0f 88 9e 00 00 00    	js     8010599d <sys_open+0xbd>
801058ff:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105902:	83 ec 08             	sub    $0x8,%esp
80105905:	50                   	push   %eax
80105906:	6a 01                	push   $0x1
80105908:	e8 13 f7 ff ff       	call   80105020 <argint>
8010590d:	83 c4 10             	add    $0x10,%esp
80105910:	85 c0                	test   %eax,%eax
80105912:	0f 88 85 00 00 00    	js     8010599d <sys_open+0xbd>
    return -1;

  begin_op();
80105918:	e8 13 d3 ff ff       	call   80102c30 <begin_op>

  if(omode & O_CREATE){
8010591d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105921:	0f 85 89 00 00 00    	jne    801059b0 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105927:	83 ec 0c             	sub    $0xc,%esp
8010592a:	ff 75 e0             	pushl  -0x20(%ebp)
8010592d:	e8 de c5 ff ff       	call   80101f10 <namei>
80105932:	83 c4 10             	add    $0x10,%esp
80105935:	85 c0                	test   %eax,%eax
80105937:	89 c7                	mov    %eax,%edi
80105939:	0f 84 8e 00 00 00    	je     801059cd <sys_open+0xed>
      end_op();
      return -1;
    }
    ilock(ip);
8010593f:	83 ec 0c             	sub    $0xc,%esp
80105942:	50                   	push   %eax
80105943:	e8 38 bd ff ff       	call   80101680 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105948:	83 c4 10             	add    $0x10,%esp
8010594b:	66 83 7f 10 01       	cmpw   $0x1,0x10(%edi)
80105950:	0f 84 d2 00 00 00    	je     80105a28 <sys_open+0x148>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105956:	e8 65 b4 ff ff       	call   80100dc0 <filealloc>
8010595b:	85 c0                	test   %eax,%eax
8010595d:	89 c6                	mov    %eax,%esi
8010595f:	74 2b                	je     8010598c <sys_open+0xac>
80105961:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105968:	31 db                	xor    %ebx,%ebx
8010596a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80105970:	8b 44 9a 18          	mov    0x18(%edx,%ebx,4),%eax
80105974:	85 c0                	test   %eax,%eax
80105976:	74 68                	je     801059e0 <sys_open+0x100>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105978:	83 c3 01             	add    $0x1,%ebx
8010597b:	83 fb 10             	cmp    $0x10,%ebx
8010597e:	75 f0                	jne    80105970 <sys_open+0x90>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105980:	83 ec 0c             	sub    $0xc,%esp
80105983:	56                   	push   %esi
80105984:	e8 f7 b4 ff ff       	call   80100e80 <fileclose>
80105989:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010598c:	83 ec 0c             	sub    $0xc,%esp
8010598f:	57                   	push   %edi
80105990:	e8 bb bf ff ff       	call   80101950 <iunlockput>
    end_op();
80105995:	e8 06 d3 ff ff       	call   80102ca0 <end_op>
    return -1;
8010599a:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010599d:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
801059a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
801059a5:	5b                   	pop    %ebx
801059a6:	5e                   	pop    %esi
801059a7:	5f                   	pop    %edi
801059a8:	5d                   	pop    %ebp
801059a9:	c3                   	ret    
801059aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801059b0:	83 ec 0c             	sub    $0xc,%esp
801059b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801059b6:	31 c9                	xor    %ecx,%ecx
801059b8:	6a 00                	push   $0x0
801059ba:	ba 02 00 00 00       	mov    $0x2,%edx
801059bf:	e8 ec f7 ff ff       	call   801051b0 <create>
    if(ip == 0){
801059c4:	83 c4 10             	add    $0x10,%esp
801059c7:	85 c0                	test   %eax,%eax
    return -1;

  begin_op();

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
801059c9:	89 c7                	mov    %eax,%edi
    if(ip == 0){
801059cb:	75 89                	jne    80105956 <sys_open+0x76>
      end_op();
801059cd:	e8 ce d2 ff ff       	call   80102ca0 <end_op>
      return -1;
801059d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059d7:	eb 43                	jmp    80105a1c <sys_open+0x13c>
801059d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801059e0:	83 ec 0c             	sub    $0xc,%esp
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
801059e3:	89 74 9a 18          	mov    %esi,0x18(%edx,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801059e7:	57                   	push   %edi
801059e8:	e8 a3 bd ff ff       	call   80101790 <iunlock>
  end_op();
801059ed:	e8 ae d2 ff ff       	call   80102ca0 <end_op>

  f->type = FD_INODE;
801059f2:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801059f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801059fb:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
801059fe:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
80105a01:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
80105a08:	89 d0                	mov    %edx,%eax
80105a0a:	83 e0 01             	and    $0x1,%eax
80105a0d:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105a10:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105a13:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105a16:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
80105a1a:	89 d8                	mov    %ebx,%eax
}
80105a1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a1f:	5b                   	pop    %ebx
80105a20:	5e                   	pop    %esi
80105a21:	5f                   	pop    %edi
80105a22:	5d                   	pop    %ebp
80105a23:	c3                   	ret    
80105a24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((ip = namei(path)) == 0){
      end_op();
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
80105a28:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105a2b:	85 d2                	test   %edx,%edx
80105a2d:	0f 84 23 ff ff ff    	je     80105956 <sys_open+0x76>
80105a33:	e9 54 ff ff ff       	jmp    8010598c <sys_open+0xac>
80105a38:	90                   	nop
80105a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a40 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105a40:	55                   	push   %ebp
80105a41:	89 e5                	mov    %esp,%ebp
80105a43:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105a46:	e8 e5 d1 ff ff       	call   80102c30 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105a4b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a4e:	83 ec 08             	sub    $0x8,%esp
80105a51:	50                   	push   %eax
80105a52:	6a 00                	push   $0x0
80105a54:	e8 67 f6 ff ff       	call   801050c0 <argstr>
80105a59:	83 c4 10             	add    $0x10,%esp
80105a5c:	85 c0                	test   %eax,%eax
80105a5e:	78 30                	js     80105a90 <sys_mkdir+0x50>
80105a60:	83 ec 0c             	sub    $0xc,%esp
80105a63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a66:	31 c9                	xor    %ecx,%ecx
80105a68:	6a 00                	push   $0x0
80105a6a:	ba 01 00 00 00       	mov    $0x1,%edx
80105a6f:	e8 3c f7 ff ff       	call   801051b0 <create>
80105a74:	83 c4 10             	add    $0x10,%esp
80105a77:	85 c0                	test   %eax,%eax
80105a79:	74 15                	je     80105a90 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105a7b:	83 ec 0c             	sub    $0xc,%esp
80105a7e:	50                   	push   %eax
80105a7f:	e8 cc be ff ff       	call   80101950 <iunlockput>
  end_op();
80105a84:	e8 17 d2 ff ff       	call   80102ca0 <end_op>
  return 0;
80105a89:	83 c4 10             	add    $0x10,%esp
80105a8c:	31 c0                	xor    %eax,%eax
}
80105a8e:	c9                   	leave  
80105a8f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80105a90:	e8 0b d2 ff ff       	call   80102ca0 <end_op>
    return -1;
80105a95:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
80105a9a:	c9                   	leave  
80105a9b:	c3                   	ret    
80105a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105aa0 <sys_mknod>:

int
sys_mknod(void)
{
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
80105aa3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105aa6:	e8 85 d1 ff ff       	call   80102c30 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105aab:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105aae:	83 ec 08             	sub    $0x8,%esp
80105ab1:	50                   	push   %eax
80105ab2:	6a 00                	push   $0x0
80105ab4:	e8 07 f6 ff ff       	call   801050c0 <argstr>
80105ab9:	83 c4 10             	add    $0x10,%esp
80105abc:	85 c0                	test   %eax,%eax
80105abe:	78 60                	js     80105b20 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105ac0:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ac3:	83 ec 08             	sub    $0x8,%esp
80105ac6:	50                   	push   %eax
80105ac7:	6a 01                	push   $0x1
80105ac9:	e8 52 f5 ff ff       	call   80105020 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
80105ace:	83 c4 10             	add    $0x10,%esp
80105ad1:	85 c0                	test   %eax,%eax
80105ad3:	78 4b                	js     80105b20 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105ad5:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ad8:	83 ec 08             	sub    $0x8,%esp
80105adb:	50                   	push   %eax
80105adc:	6a 02                	push   $0x2
80105ade:	e8 3d f5 ff ff       	call   80105020 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105ae3:	83 c4 10             	add    $0x10,%esp
80105ae6:	85 c0                	test   %eax,%eax
80105ae8:	78 36                	js     80105b20 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105aea:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105aee:	83 ec 0c             	sub    $0xc,%esp
80105af1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105af5:	ba 03 00 00 00       	mov    $0x3,%edx
80105afa:	50                   	push   %eax
80105afb:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105afe:	e8 ad f6 ff ff       	call   801051b0 <create>
80105b03:	83 c4 10             	add    $0x10,%esp
80105b06:	85 c0                	test   %eax,%eax
80105b08:	74 16                	je     80105b20 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
80105b0a:	83 ec 0c             	sub    $0xc,%esp
80105b0d:	50                   	push   %eax
80105b0e:	e8 3d be ff ff       	call   80101950 <iunlockput>
  end_op();
80105b13:	e8 88 d1 ff ff       	call   80102ca0 <end_op>
  return 0;
80105b18:	83 c4 10             	add    $0x10,%esp
80105b1b:	31 c0                	xor    %eax,%eax
}
80105b1d:	c9                   	leave  
80105b1e:	c3                   	ret    
80105b1f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105b20:	e8 7b d1 ff ff       	call   80102ca0 <end_op>
    return -1;
80105b25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
80105b2a:	c9                   	leave  
80105b2b:	c3                   	ret    
80105b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b30 <sys_chdir>:

int
sys_chdir(void)
{
80105b30:	55                   	push   %ebp
80105b31:	89 e5                	mov    %esp,%ebp
80105b33:	53                   	push   %ebx
80105b34:	83 ec 14             	sub    $0x14,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105b37:	e8 f4 d0 ff ff       	call   80102c30 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105b3c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b3f:	83 ec 08             	sub    $0x8,%esp
80105b42:	50                   	push   %eax
80105b43:	6a 00                	push   $0x0
80105b45:	e8 76 f5 ff ff       	call   801050c0 <argstr>
80105b4a:	83 c4 10             	add    $0x10,%esp
80105b4d:	85 c0                	test   %eax,%eax
80105b4f:	78 7f                	js     80105bd0 <sys_chdir+0xa0>
80105b51:	83 ec 0c             	sub    $0xc,%esp
80105b54:	ff 75 f4             	pushl  -0xc(%ebp)
80105b57:	e8 b4 c3 ff ff       	call   80101f10 <namei>
80105b5c:	83 c4 10             	add    $0x10,%esp
80105b5f:	85 c0                	test   %eax,%eax
80105b61:	89 c3                	mov    %eax,%ebx
80105b63:	74 6b                	je     80105bd0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105b65:	83 ec 0c             	sub    $0xc,%esp
80105b68:	50                   	push   %eax
80105b69:	e8 12 bb ff ff       	call   80101680 <ilock>
  if(ip->type != T_DIR){
80105b6e:	83 c4 10             	add    $0x10,%esp
80105b71:	66 83 7b 10 01       	cmpw   $0x1,0x10(%ebx)
80105b76:	75 38                	jne    80105bb0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105b78:	83 ec 0c             	sub    $0xc,%esp
80105b7b:	53                   	push   %ebx
80105b7c:	e8 0f bc ff ff       	call   80101790 <iunlock>
  iput(proc->cwd);
80105b81:	58                   	pop    %eax
80105b82:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b88:	ff 70 58             	pushl  0x58(%eax)
80105b8b:	e8 60 bc ff ff       	call   801017f0 <iput>
  end_op();
80105b90:	e8 0b d1 ff ff       	call   80102ca0 <end_op>
  proc->cwd = ip;
80105b95:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
80105b9b:	83 c4 10             	add    $0x10,%esp
    return -1;
  }
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
80105b9e:	89 58 58             	mov    %ebx,0x58(%eax)
  return 0;
80105ba1:	31 c0                	xor    %eax,%eax
}
80105ba3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ba6:	c9                   	leave  
80105ba7:	c3                   	ret    
80105ba8:	90                   	nop
80105ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105bb0:	83 ec 0c             	sub    $0xc,%esp
80105bb3:	53                   	push   %ebx
80105bb4:	e8 97 bd ff ff       	call   80101950 <iunlockput>
    end_op();
80105bb9:	e8 e2 d0 ff ff       	call   80102ca0 <end_op>
    return -1;
80105bbe:	83 c4 10             	add    $0x10,%esp
80105bc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bc6:	eb db                	jmp    80105ba3 <sys_chdir+0x73>
80105bc8:	90                   	nop
80105bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80105bd0:	e8 cb d0 ff ff       	call   80102ca0 <end_op>
    return -1;
80105bd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bda:	eb c7                	jmp    80105ba3 <sys_chdir+0x73>
80105bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105be0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105be0:	55                   	push   %ebp
80105be1:	89 e5                	mov    %esp,%ebp
80105be3:	57                   	push   %edi
80105be4:	56                   	push   %esi
80105be5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105be6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
80105bec:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105bf2:	50                   	push   %eax
80105bf3:	6a 00                	push   $0x0
80105bf5:	e8 c6 f4 ff ff       	call   801050c0 <argstr>
80105bfa:	83 c4 10             	add    $0x10,%esp
80105bfd:	85 c0                	test   %eax,%eax
80105bff:	78 7f                	js     80105c80 <sys_exec+0xa0>
80105c01:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105c07:	83 ec 08             	sub    $0x8,%esp
80105c0a:	50                   	push   %eax
80105c0b:	6a 01                	push   $0x1
80105c0d:	e8 0e f4 ff ff       	call   80105020 <argint>
80105c12:	83 c4 10             	add    $0x10,%esp
80105c15:	85 c0                	test   %eax,%eax
80105c17:	78 67                	js     80105c80 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105c19:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105c1f:	83 ec 04             	sub    $0x4,%esp
80105c22:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105c28:	68 80 00 00 00       	push   $0x80
80105c2d:	6a 00                	push   $0x0
80105c2f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105c35:	50                   	push   %eax
80105c36:	31 db                	xor    %ebx,%ebx
80105c38:	e8 f3 f0 ff ff       	call   80104d30 <memset>
80105c3d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105c40:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105c46:	83 ec 08             	sub    $0x8,%esp
80105c49:	57                   	push   %edi
80105c4a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
80105c4d:	50                   	push   %eax
80105c4e:	e8 4d f3 ff ff       	call   80104fa0 <fetchint>
80105c53:	83 c4 10             	add    $0x10,%esp
80105c56:	85 c0                	test   %eax,%eax
80105c58:	78 26                	js     80105c80 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
80105c5a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105c60:	85 c0                	test   %eax,%eax
80105c62:	74 2c                	je     80105c90 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105c64:	83 ec 08             	sub    $0x8,%esp
80105c67:	56                   	push   %esi
80105c68:	50                   	push   %eax
80105c69:	e8 62 f3 ff ff       	call   80104fd0 <fetchstr>
80105c6e:	83 c4 10             	add    $0x10,%esp
80105c71:	85 c0                	test   %eax,%eax
80105c73:	78 0b                	js     80105c80 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105c75:	83 c3 01             	add    $0x1,%ebx
80105c78:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
80105c7b:	83 fb 20             	cmp    $0x20,%ebx
80105c7e:	75 c0                	jne    80105c40 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105c80:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105c83:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105c88:	5b                   	pop    %ebx
80105c89:	5e                   	pop    %esi
80105c8a:	5f                   	pop    %edi
80105c8b:	5d                   	pop    %ebp
80105c8c:	c3                   	ret    
80105c8d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105c90:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105c96:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105c99:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105ca0:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105ca4:	50                   	push   %eax
80105ca5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105cab:	e8 90 ad ff ff       	call   80100a40 <exec>
80105cb0:	83 c4 10             	add    $0x10,%esp
}
80105cb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cb6:	5b                   	pop    %ebx
80105cb7:	5e                   	pop    %esi
80105cb8:	5f                   	pop    %edi
80105cb9:	5d                   	pop    %ebp
80105cba:	c3                   	ret    
80105cbb:	90                   	nop
80105cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105cc0 <sys_pipe>:

int
sys_pipe(void)
{
80105cc0:	55                   	push   %ebp
80105cc1:	89 e5                	mov    %esp,%ebp
80105cc3:	57                   	push   %edi
80105cc4:	56                   	push   %esi
80105cc5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105cc6:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105cc9:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105ccc:	6a 08                	push   $0x8
80105cce:	50                   	push   %eax
80105ccf:	6a 00                	push   $0x0
80105cd1:	e8 9a f3 ff ff       	call   80105070 <argptr>
80105cd6:	83 c4 10             	add    $0x10,%esp
80105cd9:	85 c0                	test   %eax,%eax
80105cdb:	78 48                	js     80105d25 <sys_pipe+0x65>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105cdd:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105ce0:	83 ec 08             	sub    $0x8,%esp
80105ce3:	50                   	push   %eax
80105ce4:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105ce7:	50                   	push   %eax
80105ce8:	e8 e3 d6 ff ff       	call   801033d0 <pipealloc>
80105ced:	83 c4 10             	add    $0x10,%esp
80105cf0:	85 c0                	test   %eax,%eax
80105cf2:	78 31                	js     80105d25 <sys_pipe+0x65>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105cf4:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80105cf7:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105cfe:	31 c0                	xor    %eax,%eax
    if(proc->ofile[fd] == 0){
80105d00:	8b 54 81 18          	mov    0x18(%ecx,%eax,4),%edx
80105d04:	85 d2                	test   %edx,%edx
80105d06:	74 28                	je     80105d30 <sys_pipe+0x70>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105d08:	83 c0 01             	add    $0x1,%eax
80105d0b:	83 f8 10             	cmp    $0x10,%eax
80105d0e:	75 f0                	jne    80105d00 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
80105d10:	83 ec 0c             	sub    $0xc,%esp
80105d13:	53                   	push   %ebx
80105d14:	e8 67 b1 ff ff       	call   80100e80 <fileclose>
    fileclose(wf);
80105d19:	58                   	pop    %eax
80105d1a:	ff 75 e4             	pushl  -0x1c(%ebp)
80105d1d:	e8 5e b1 ff ff       	call   80100e80 <fileclose>
    return -1;
80105d22:	83 c4 10             	add    $0x10,%esp
80105d25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d2a:	eb 45                	jmp    80105d71 <sys_pipe+0xb1>
80105d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d30:	8d 34 81             	lea    (%ecx,%eax,4),%esi
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105d33:	8b 7d e4             	mov    -0x1c(%ebp),%edi
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105d36:	31 d2                	xor    %edx,%edx
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80105d38:	89 5e 18             	mov    %ebx,0x18(%esi)
80105d3b:	90                   	nop
80105d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80105d40:	83 7c 91 18 00       	cmpl   $0x0,0x18(%ecx,%edx,4)
80105d45:	74 19                	je     80105d60 <sys_pipe+0xa0>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105d47:	83 c2 01             	add    $0x1,%edx
80105d4a:	83 fa 10             	cmp    $0x10,%edx
80105d4d:	75 f1                	jne    80105d40 <sys_pipe+0x80>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
80105d4f:	c7 46 18 00 00 00 00 	movl   $0x0,0x18(%esi)
80105d56:	eb b8                	jmp    80105d10 <sys_pipe+0x50>
80105d58:	90                   	nop
80105d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80105d60:	89 7c 91 18          	mov    %edi,0x18(%ecx,%edx,4)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105d64:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80105d67:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
80105d69:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105d6c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105d6f:	31 c0                	xor    %eax,%eax
}
80105d71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d74:	5b                   	pop    %ebx
80105d75:	5e                   	pop    %esi
80105d76:	5f                   	pop    %edi
80105d77:	5d                   	pop    %ebp
80105d78:	c3                   	ret    
80105d79:	66 90                	xchg   %ax,%ax
80105d7b:	66 90                	xchg   %ax,%ax
80105d7d:	66 90                	xchg   %ax,%ax
80105d7f:	90                   	nop

80105d80 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105d80:	55                   	push   %ebp
80105d81:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105d83:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105d84:	e9 f7 dd ff ff       	jmp    80103b80 <fork>
80105d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d90 <sys_exit>:
}

int
sys_exit(void)
{
80105d90:	55                   	push   %ebp
80105d91:	89 e5                	mov    %esp,%ebp
80105d93:	83 ec 08             	sub    $0x8,%esp
  exit();
80105d96:	e8 95 e1 ff ff       	call   80103f30 <exit>
  return 0;  // not reached
}
80105d9b:	31 c0                	xor    %eax,%eax
80105d9d:	c9                   	leave  
80105d9e:	c3                   	ret    
80105d9f:	90                   	nop

80105da0 <sys_wait>:

int
sys_wait(void)
{
80105da0:	55                   	push   %ebp
80105da1:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105da3:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105da4:	e9 97 e4 ff ff       	jmp    80104240 <wait>
80105da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105db0 <sys_kill>:
}

int
sys_kill(void)
{
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105db6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105db9:	50                   	push   %eax
80105dba:	6a 00                	push   $0x0
80105dbc:	e8 5f f2 ff ff       	call   80105020 <argint>
80105dc1:	83 c4 10             	add    $0x10,%esp
80105dc4:	85 c0                	test   %eax,%eax
80105dc6:	78 18                	js     80105de0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105dc8:	83 ec 0c             	sub    $0xc,%esp
80105dcb:	ff 75 f4             	pushl  -0xc(%ebp)
80105dce:	e8 1d e6 ff ff       	call   801043f0 <kill>
80105dd3:	83 c4 10             	add    $0x10,%esp
}
80105dd6:	c9                   	leave  
80105dd7:	c3                   	ret    
80105dd8:	90                   	nop
80105dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105de0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105de5:	c9                   	leave  
80105de6:	c3                   	ret    
80105de7:	89 f6                	mov    %esi,%esi
80105de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105df0 <sys_getpid>:

int
sys_getpid(void)
{
  return proc->pid;
80105df0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return kill(pid);
}

int
sys_getpid(void)
{
80105df6:	55                   	push   %ebp
80105df7:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80105df9:	8b 40 0c             	mov    0xc(%eax),%eax
}
80105dfc:	5d                   	pop    %ebp
80105dfd:	c3                   	ret    
80105dfe:	66 90                	xchg   %ax,%ax

80105e00 <sys_sbrk>:

int
sys_sbrk(void)
{
80105e00:	55                   	push   %ebp
80105e01:	89 e5                	mov    %esp,%ebp
80105e03:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105e04:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return proc->pid;
}

int
sys_sbrk(void)
{
80105e07:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105e0a:	50                   	push   %eax
80105e0b:	6a 00                	push   $0x0
80105e0d:	e8 0e f2 ff ff       	call   80105020 <argint>
80105e12:	83 c4 10             	add    $0x10,%esp
80105e15:	85 c0                	test   %eax,%eax
80105e17:	78 27                	js     80105e40 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
80105e19:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
80105e1f:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
80105e22:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105e24:	ff 75 f4             	pushl  -0xc(%ebp)
80105e27:	e8 b4 dc ff ff       	call   80103ae0 <growproc>
80105e2c:	83 c4 10             	add    $0x10,%esp
80105e2f:	85 c0                	test   %eax,%eax
80105e31:	78 0d                	js     80105e40 <sys_sbrk+0x40>
    return -1;
  return addr;
80105e33:	89 d8                	mov    %ebx,%eax
}
80105e35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e38:	c9                   	leave  
80105e39:	c3                   	ret    
80105e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105e40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e45:	eb ee                	jmp    80105e35 <sys_sbrk+0x35>
80105e47:	89 f6                	mov    %esi,%esi
80105e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105e50 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105e54:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105e57:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105e5a:	50                   	push   %eax
80105e5b:	6a 00                	push   $0x0
80105e5d:	e8 be f1 ff ff       	call   80105020 <argint>
80105e62:	83 c4 10             	add    $0x10,%esp
80105e65:	85 c0                	test   %eax,%eax
80105e67:	0f 88 8a 00 00 00    	js     80105ef7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105e6d:	83 ec 0c             	sub    $0xc,%esp
80105e70:	68 80 d3 11 80       	push   $0x8011d380
80105e75:	e8 86 ec ff ff       	call   80104b00 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105e7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105e7d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105e80:	8b 1d c0 db 11 80    	mov    0x8011dbc0,%ebx
  while(ticks - ticks0 < n){
80105e86:	85 d2                	test   %edx,%edx
80105e88:	75 27                	jne    80105eb1 <sys_sleep+0x61>
80105e8a:	eb 54                	jmp    80105ee0 <sys_sleep+0x90>
80105e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105e90:	83 ec 08             	sub    $0x8,%esp
80105e93:	68 80 d3 11 80       	push   $0x8011d380
80105e98:	68 c0 db 11 80       	push   $0x8011dbc0
80105e9d:	e8 6e e2 ff ff       	call   80104110 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105ea2:	a1 c0 db 11 80       	mov    0x8011dbc0,%eax
80105ea7:	83 c4 10             	add    $0x10,%esp
80105eaa:	29 d8                	sub    %ebx,%eax
80105eac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105eaf:	73 2f                	jae    80105ee0 <sys_sleep+0x90>
    if(proc->killed){
80105eb1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105eb7:	8b 40 14             	mov    0x14(%eax),%eax
80105eba:	85 c0                	test   %eax,%eax
80105ebc:	74 d2                	je     80105e90 <sys_sleep+0x40>
      release(&tickslock);
80105ebe:	83 ec 0c             	sub    $0xc,%esp
80105ec1:	68 80 d3 11 80       	push   $0x8011d380
80105ec6:	e8 15 ee ff ff       	call   80104ce0 <release>
      return -1;
80105ecb:	83 c4 10             	add    $0x10,%esp
80105ece:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105ed3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ed6:	c9                   	leave  
80105ed7:	c3                   	ret    
80105ed8:	90                   	nop
80105ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105ee0:	83 ec 0c             	sub    $0xc,%esp
80105ee3:	68 80 d3 11 80       	push   $0x8011d380
80105ee8:	e8 f3 ed ff ff       	call   80104ce0 <release>
  return 0;
80105eed:	83 c4 10             	add    $0x10,%esp
80105ef0:	31 c0                	xor    %eax,%eax
}
80105ef2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ef5:	c9                   	leave  
80105ef6:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80105ef7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105efc:	eb d5                	jmp    80105ed3 <sys_sleep+0x83>
80105efe:	66 90                	xchg   %ax,%ax

80105f00 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	53                   	push   %ebx
80105f04:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105f07:	68 80 d3 11 80       	push   $0x8011d380
80105f0c:	e8 ef eb ff ff       	call   80104b00 <acquire>
  xticks = ticks;
80105f11:	8b 1d c0 db 11 80    	mov    0x8011dbc0,%ebx
  release(&tickslock);
80105f17:	c7 04 24 80 d3 11 80 	movl   $0x8011d380,(%esp)
80105f1e:	e8 bd ed ff ff       	call   80104ce0 <release>
  return xticks;
}
80105f23:	89 d8                	mov    %ebx,%eax
80105f25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f28:	c9                   	leave  
80105f29:	c3                   	ret    
80105f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105f30 <sys_procdump>:

int 
sys_procdump(void)
{
80105f30:	55                   	push   %ebp
80105f31:	89 e5                	mov    %esp,%ebp
80105f33:	83 ec 08             	sub    $0x8,%esp
  procdump();
80105f36:	e8 d5 e5 ff ff       	call   80104510 <procdump>
  return 0;
}
80105f3b:	31 c0                	xor    %eax,%eax
80105f3d:	c9                   	leave  
80105f3e:	c3                   	ret    
80105f3f:	90                   	nop

80105f40 <sys_kthread_create>:

// kthread_create

int 
sys_kthread_create(void)
{
80105f40:	55                   	push   %ebp
80105f41:	89 e5                	mov    %esp,%ebp
80105f43:	83 ec 1c             	sub    $0x1c,%esp
  void* (*start_func)();
  void* stack;
  int stack_size;

  if(argptr(0, (char**) &start_func, sizeof(void*)) < 0
80105f46:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f49:	6a 04                	push   $0x4
80105f4b:	50                   	push   %eax
80105f4c:	6a 00                	push   $0x0
80105f4e:	e8 1d f1 ff ff       	call   80105070 <argptr>
80105f53:	83 c4 10             	add    $0x10,%esp
80105f56:	85 c0                	test   %eax,%eax
80105f58:	78 46                	js     80105fa0 <sys_kthread_create+0x60>
    || argptr(1, (char**) &stack, sizeof(void*)) < 0
80105f5a:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f5d:	83 ec 04             	sub    $0x4,%esp
80105f60:	6a 04                	push   $0x4
80105f62:	50                   	push   %eax
80105f63:	6a 01                	push   $0x1
80105f65:	e8 06 f1 ff ff       	call   80105070 <argptr>
80105f6a:	83 c4 10             	add    $0x10,%esp
80105f6d:	85 c0                	test   %eax,%eax
80105f6f:	78 2f                	js     80105fa0 <sys_kthread_create+0x60>
    || argint(2, &stack_size) < 0) {
80105f71:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f74:	83 ec 08             	sub    $0x8,%esp
80105f77:	50                   	push   %eax
80105f78:	6a 02                	push   $0x2
80105f7a:	e8 a1 f0 ff ff       	call   80105020 <argint>
80105f7f:	83 c4 10             	add    $0x10,%esp
80105f82:	85 c0                	test   %eax,%eax
80105f84:	78 1a                	js     80105fa0 <sys_kthread_create+0x60>
      // not enough arg
      return -1;
  }

  // deploy syscall
  int tid = kthread_create(start_func, stack, stack_size);
80105f86:	83 ec 04             	sub    $0x4,%esp
80105f89:	ff 75 f4             	pushl  -0xc(%ebp)
80105f8c:	ff 75 f0             	pushl  -0x10(%ebp)
80105f8f:	ff 75 ec             	pushl  -0x14(%ebp)
80105f92:	e8 69 e6 ff ff       	call   80104600 <kthread_create>

  return tid;
80105f97:	83 c4 10             	add    $0x10,%esp
}
80105f9a:	c9                   	leave  
80105f9b:	c3                   	ret    
80105f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if(argptr(0, (char**) &start_func, sizeof(void*)) < 0
    || argptr(1, (char**) &stack, sizeof(void*)) < 0
    || argint(2, &stack_size) < 0) {
      // not enough arg
      return -1;
80105fa0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

  // deploy syscall
  int tid = kthread_create(start_func, stack, stack_size);

  return tid;
}
80105fa5:	c9                   	leave  
80105fa6:	c3                   	ret    
80105fa7:	89 f6                	mov    %esi,%esi
80105fa9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105fb0 <sys_kthread_id>:

// kthread_id

int 
sys_kthread_id(void)
{
80105fb0:	55                   	push   %ebp
80105fb1:	89 e5                	mov    %esp,%ebp
  // deploy syscall
  return kthread_id();
}
80105fb3:	5d                   	pop    %ebp

int 
sys_kthread_id(void)
{
  // deploy syscall
  return kthread_id();
80105fb4:	e9 b7 e6 ff ff       	jmp    80104670 <kthread_id>
80105fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105fc0 <sys_kthread_exit>:

// kthread_exit

int 
sys_kthread_exit(void)
{
80105fc0:	55                   	push   %ebp
80105fc1:	89 e5                	mov    %esp,%ebp
80105fc3:	83 ec 08             	sub    $0x8,%esp
  // deploy syscall
  kthread_exit();
80105fc6:	e8 d5 e6 ff ff       	call   801046a0 <kthread_exit>
  return 0;
}
80105fcb:	31 c0                	xor    %eax,%eax
80105fcd:	c9                   	leave  
80105fce:	c3                   	ret    
80105fcf:	90                   	nop

80105fd0 <sys_kthread_join>:

// kthread_join

int 
sys_kthread_join(void)
{
80105fd0:	55                   	push   %ebp
80105fd1:	89 e5                	mov    %esp,%ebp
80105fd3:	83 ec 20             	sub    $0x20,%esp
  int thread_id;

  if(argint(0, &thread_id) < 0) {
80105fd6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fd9:	50                   	push   %eax
80105fda:	6a 00                	push   $0x0
80105fdc:	e8 3f f0 ff ff       	call   80105020 <argint>
80105fe1:	83 c4 10             	add    $0x10,%esp
80105fe4:	85 c0                	test   %eax,%eax
80105fe6:	78 18                	js     80106000 <sys_kthread_join+0x30>
    // no target thread_id passed
    return -1;
  }

  // deploy syscall
  return kthread_join(thread_id);
80105fe8:	83 ec 0c             	sub    $0xc,%esp
80105feb:	ff 75 f4             	pushl  -0xc(%ebp)
80105fee:	e8 8d e7 ff ff       	call   80104780 <kthread_join>
80105ff3:	83 c4 10             	add    $0x10,%esp
}
80105ff6:	c9                   	leave  
80105ff7:	c3                   	ret    
80105ff8:	90                   	nop
80105ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int thread_id;

  if(argint(0, &thread_id) < 0) {
    // no target thread_id passed
    return -1;
80106000:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }

  // deploy syscall
  return kthread_join(thread_id);
}
80106005:	c9                   	leave  
80106006:	c3                   	ret    
80106007:	89 f6                	mov    %esi,%esi
80106009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106010 <sys_kthread_mutex_alloc>:

// kthread_mutex_alloc

int 
sys_kthread_mutex_alloc(void)
{
80106010:	55                   	push   %ebp
80106011:	89 e5                	mov    %esp,%ebp
  // deploy syscall
  return kthread_mutex_alloc();
}
80106013:	5d                   	pop    %ebp

int 
sys_kthread_mutex_alloc(void)
{
  // deploy syscall
  return kthread_mutex_alloc();
80106014:	e9 47 e8 ff ff       	jmp    80104860 <kthread_mutex_alloc>
80106019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106020 <sys_kthread_mutex_dealloc>:

// kthread_mutex_dealloc

int 
sys_kthread_mutex_dealloc(void)
{
80106020:	55                   	push   %ebp
80106021:	89 e5                	mov    %esp,%ebp
80106023:	83 ec 20             	sub    $0x20,%esp
  int mutex_id;
  if(argint(0, &mutex_id) < 0) {
80106026:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106029:	50                   	push   %eax
8010602a:	6a 00                	push   $0x0
8010602c:	e8 ef ef ff ff       	call   80105020 <argint>
80106031:	83 c4 10             	add    $0x10,%esp
80106034:	85 c0                	test   %eax,%eax
80106036:	78 18                	js     80106050 <sys_kthread_mutex_dealloc+0x30>
    // no target mutex_id passed
    return -1;
  }

  // deploy syscall
  return kthread_mutex_dealloc(mutex_id);
80106038:	83 ec 0c             	sub    $0xc,%esp
8010603b:	ff 75 f4             	pushl  -0xc(%ebp)
8010603e:	e8 ad e8 ff ff       	call   801048f0 <kthread_mutex_dealloc>
80106043:	83 c4 10             	add    $0x10,%esp
}
80106046:	c9                   	leave  
80106047:	c3                   	ret    
80106048:	90                   	nop
80106049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kthread_mutex_dealloc(void)
{
  int mutex_id;
  if(argint(0, &mutex_id) < 0) {
    // no target mutex_id passed
    return -1;
80106050:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }

  // deploy syscall
  return kthread_mutex_dealloc(mutex_id);
}
80106055:	c9                   	leave  
80106056:	c3                   	ret    
80106057:	89 f6                	mov    %esi,%esi
80106059:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106060 <sys_kthread_mutex_lock>:

// kthread_mutex_lock

int 
sys_kthread_mutex_lock(void)
{
80106060:	55                   	push   %ebp
80106061:	89 e5                	mov    %esp,%ebp
80106063:	83 ec 20             	sub    $0x20,%esp
  int mutex_id;
  if(argint(0, &mutex_id) < 0) {
80106066:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106069:	50                   	push   %eax
8010606a:	6a 00                	push   $0x0
8010606c:	e8 af ef ff ff       	call   80105020 <argint>
80106071:	83 c4 10             	add    $0x10,%esp
80106074:	85 c0                	test   %eax,%eax
80106076:	78 18                	js     80106090 <sys_kthread_mutex_lock+0x30>
    // no target mutex_id passed
    return -1;
  }

  // deploy syscall
  return kthread_mutex_lock(mutex_id);
80106078:	83 ec 0c             	sub    $0xc,%esp
8010607b:	ff 75 f4             	pushl  -0xc(%ebp)
8010607e:	e8 ed e8 ff ff       	call   80104970 <kthread_mutex_lock>
80106083:	83 c4 10             	add    $0x10,%esp
}
80106086:	c9                   	leave  
80106087:	c3                   	ret    
80106088:	90                   	nop
80106089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kthread_mutex_lock(void)
{
  int mutex_id;
  if(argint(0, &mutex_id) < 0) {
    // no target mutex_id passed
    return -1;
80106090:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }

  // deploy syscall
  return kthread_mutex_lock(mutex_id);
}
80106095:	c9                   	leave  
80106096:	c3                   	ret    
80106097:	89 f6                	mov    %esi,%esi
80106099:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801060a0 <sys_kthread_mutex_unlock>:

// kthread_mutex_unlock

int 
sys_kthread_mutex_unlock(void)
{
801060a0:	55                   	push   %ebp
801060a1:	89 e5                	mov    %esp,%ebp
801060a3:	83 ec 20             	sub    $0x20,%esp
  int mutex_id;
  if(argint(0, &mutex_id) < 0) {
801060a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801060a9:	50                   	push   %eax
801060aa:	6a 00                	push   $0x0
801060ac:	e8 6f ef ff ff       	call   80105020 <argint>
801060b1:	83 c4 10             	add    $0x10,%esp
801060b4:	85 c0                	test   %eax,%eax
801060b6:	78 18                	js     801060d0 <sys_kthread_mutex_unlock+0x30>
    // no target mutex_id passed
    return -1;
  }

  // deploy syscall
  return kthread_mutex_unlock(mutex_id);
801060b8:	83 ec 0c             	sub    $0xc,%esp
801060bb:	ff 75 f4             	pushl  -0xc(%ebp)
801060be:	e8 5d e9 ff ff       	call   80104a20 <kthread_mutex_unlock>
801060c3:	83 c4 10             	add    $0x10,%esp
801060c6:	c9                   	leave  
801060c7:	c3                   	ret    
801060c8:	90                   	nop
801060c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kthread_mutex_unlock(void)
{
  int mutex_id;
  if(argint(0, &mutex_id) < 0) {
    // no target mutex_id passed
    return -1;
801060d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }

  // deploy syscall
  return kthread_mutex_unlock(mutex_id);
801060d5:	c9                   	leave  
801060d6:	c3                   	ret    
801060d7:	66 90                	xchg   %ax,%ax
801060d9:	66 90                	xchg   %ax,%ax
801060db:	66 90                	xchg   %ax,%ax
801060dd:	66 90                	xchg   %ax,%ax
801060df:	90                   	nop

801060e0 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
801060e0:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801060e1:	ba 43 00 00 00       	mov    $0x43,%edx
801060e6:	b8 34 00 00 00       	mov    $0x34,%eax
801060eb:	89 e5                	mov    %esp,%ebp
801060ed:	83 ec 14             	sub    $0x14,%esp
801060f0:	ee                   	out    %al,(%dx)
801060f1:	ba 40 00 00 00       	mov    $0x40,%edx
801060f6:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
801060fb:	ee                   	out    %al,(%dx)
801060fc:	b8 2e 00 00 00       	mov    $0x2e,%eax
80106101:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
80106102:	6a 00                	push   $0x0
80106104:	e8 f7 d1 ff ff       	call   80103300 <picenable>
}
80106109:	83 c4 10             	add    $0x10,%esp
8010610c:	c9                   	leave  
8010610d:	c3                   	ret    

8010610e <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010610e:	1e                   	push   %ds
  pushl %es
8010610f:	06                   	push   %es
  pushl %fs
80106110:	0f a0                	push   %fs
  pushl %gs
80106112:	0f a8                	push   %gs
  pushal
80106114:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80106115:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106119:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010611b:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
8010611d:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80106121:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80106123:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80106125:	54                   	push   %esp
  call trap
80106126:	e8 e5 00 00 00       	call   80106210 <trap>
  addl $4, %esp
8010612b:	83 c4 04             	add    $0x4,%esp

8010612e <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010612e:	61                   	popa   
  popl %gs
8010612f:	0f a9                	pop    %gs
  popl %fs
80106131:	0f a1                	pop    %fs
  popl %es
80106133:	07                   	pop    %es
  popl %ds
80106134:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106135:	83 c4 08             	add    $0x8,%esp
  iret
80106138:	cf                   	iret   
80106139:	66 90                	xchg   %ax,%ax
8010613b:	66 90                	xchg   %ax,%ax
8010613d:	66 90                	xchg   %ax,%ax
8010613f:	90                   	nop

80106140 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80106140:	31 c0                	xor    %eax,%eax
80106142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106148:	8b 14 85 14 b0 10 80 	mov    -0x7fef4fec(,%eax,4),%edx
8010614f:	b9 08 00 00 00       	mov    $0x8,%ecx
80106154:	c6 04 c5 c4 d3 11 80 	movb   $0x0,-0x7fee2c3c(,%eax,8)
8010615b:	00 
8010615c:	66 89 0c c5 c2 d3 11 	mov    %cx,-0x7fee2c3e(,%eax,8)
80106163:	80 
80106164:	c6 04 c5 c5 d3 11 80 	movb   $0x8e,-0x7fee2c3b(,%eax,8)
8010616b:	8e 
8010616c:	66 89 14 c5 c0 d3 11 	mov    %dx,-0x7fee2c40(,%eax,8)
80106173:	80 
80106174:	c1 ea 10             	shr    $0x10,%edx
80106177:	66 89 14 c5 c6 d3 11 	mov    %dx,-0x7fee2c3a(,%eax,8)
8010617e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
8010617f:	83 c0 01             	add    $0x1,%eax
80106182:	3d 00 01 00 00       	cmp    $0x100,%eax
80106187:	75 bf                	jne    80106148 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106189:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010618a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010618f:	89 e5                	mov    %esp,%ebp
80106191:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106194:	a1 14 b1 10 80       	mov    0x8010b114,%eax

  initlock(&tickslock, "time");
80106199:	68 fd 83 10 80       	push   $0x801083fd
8010619e:	68 80 d3 11 80       	push   $0x8011d380
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801061a3:	66 89 15 c2 d5 11 80 	mov    %dx,0x8011d5c2
801061aa:	c6 05 c4 d5 11 80 00 	movb   $0x0,0x8011d5c4
801061b1:	66 a3 c0 d5 11 80    	mov    %ax,0x8011d5c0
801061b7:	c1 e8 10             	shr    $0x10,%eax
801061ba:	c6 05 c5 d5 11 80 ef 	movb   $0xef,0x8011d5c5
801061c1:	66 a3 c6 d5 11 80    	mov    %ax,0x8011d5c6

  initlock(&tickslock, "time");
801061c7:	e8 14 e9 ff ff       	call   80104ae0 <initlock>
}
801061cc:	83 c4 10             	add    $0x10,%esp
801061cf:	c9                   	leave  
801061d0:	c3                   	ret    
801061d1:	eb 0d                	jmp    801061e0 <idtinit>
801061d3:	90                   	nop
801061d4:	90                   	nop
801061d5:	90                   	nop
801061d6:	90                   	nop
801061d7:	90                   	nop
801061d8:	90                   	nop
801061d9:	90                   	nop
801061da:	90                   	nop
801061db:	90                   	nop
801061dc:	90                   	nop
801061dd:	90                   	nop
801061de:	90                   	nop
801061df:	90                   	nop

801061e0 <idtinit>:

void
idtinit(void)
{
801061e0:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
801061e1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801061e6:	89 e5                	mov    %esp,%ebp
801061e8:	83 ec 10             	sub    $0x10,%esp
801061eb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801061ef:	b8 c0 d3 11 80       	mov    $0x8011d3c0,%eax
801061f4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801061f8:	c1 e8 10             	shr    $0x10,%eax
801061fb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801061ff:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106202:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106205:	c9                   	leave  
80106206:	c3                   	ret    
80106207:	89 f6                	mov    %esi,%esi
80106209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106210 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{	
80106210:	55                   	push   %ebp
80106211:	89 e5                	mov    %esp,%ebp
80106213:	57                   	push   %edi
80106214:	56                   	push   %esi
80106215:	53                   	push   %ebx
80106216:	83 ec 0c             	sub    $0xc,%esp
80106219:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010621c:	8b 43 30             	mov    0x30(%ebx),%eax
8010621f:	83 f8 40             	cmp    $0x40,%eax
80106222:	0f 84 20 01 00 00    	je     80106348 <trap+0x138>
    if(proc->killed)
      exit();
    return;
  }
  
  switch(tf->trapno){
80106228:	83 e8 20             	sub    $0x20,%eax
8010622b:	83 f8 1f             	cmp    $0x1f,%eax
8010622e:	77 10                	ja     80106240 <trap+0x30>
80106230:	ff 24 85 a4 84 10 80 	jmp    *-0x7fef7b5c(,%eax,4)
80106237:	89 f6                	mov    %esi,%esi
80106239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(thread == 0 || (tf->cs&3) == 0){
80106240:	65 8b 3d 08 00 00 00 	mov    %gs:0x8,%edi
80106247:	85 ff                	test   %edi,%edi
80106249:	0f 84 a5 02 00 00    	je     801064f4 <trap+0x2e4>
8010624f:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106253:	0f 84 9b 02 00 00    	je     801064f4 <trap+0x2e4>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106259:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010625c:	8b 73 38             	mov    0x38(%ebx),%esi
8010625f:	e8 ec c4 ff ff       	call   80102750 <cpunum>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80106264:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010626b:	57                   	push   %edi
8010626c:	56                   	push   %esi
8010626d:	50                   	push   %eax
8010626e:	ff 73 34             	pushl  0x34(%ebx)
80106271:	ff 73 30             	pushl  0x30(%ebx)
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80106274:	8d 42 5c             	lea    0x5c(%edx),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106277:	50                   	push   %eax
80106278:	ff 72 0c             	pushl  0xc(%edx)
8010627b:	68 60 84 10 80       	push   $0x80108460
80106280:	e8 bb a3 ff ff       	call   80100640 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
            rcr2());
    proc->killed = 1;
80106285:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010628b:	83 c4 20             	add    $0x20,%esp
8010628e:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
80106295:	8d 76 00             	lea    0x0(%esi),%esi
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(thread && thread->killed && (tf->cs&3) == DPL_USER)
80106298:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
8010629e:	85 c0                	test   %eax,%eax
801062a0:	0f 84 52 01 00 00    	je     801063f8 <trap+0x1e8>
801062a6:	8b 70 1c             	mov    0x1c(%eax),%esi
801062a9:	85 f6                	test   %esi,%esi
801062ab:	74 11                	je     801062be <trap+0xae>
801062ad:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
801062b1:	83 e2 03             	and    $0x3,%edx
801062b4:	66 83 fa 03          	cmp    $0x3,%dx
801062b8:	0f 84 f2 01 00 00    	je     801064b0 <trap+0x2a0>
    killSelf();
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
801062be:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801062c5:	85 d2                	test   %edx,%edx
801062c7:	74 11                	je     801062da <trap+0xca>
801062c9:	8b 4a 14             	mov    0x14(%edx),%ecx
801062cc:	85 c9                	test   %ecx,%ecx
801062ce:	75 60                	jne    80106330 <trap+0x120>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(thread && thread->state == TRUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
801062d0:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
801062d6:	85 c0                	test   %eax,%eax
801062d8:	74 11                	je     801062eb <trap+0xdb>
801062da:	83 78 04 04          	cmpl   $0x4,0x4(%eax)
801062de:	0f 84 cc 00 00 00    	je     801063b0 <trap+0x1a0>
    yield();

  // Check if the process has been killed since we yielded
  if(thread && thread->killed && (tf->cs&3) == DPL_USER)
801062e4:	8b 50 1c             	mov    0x1c(%eax),%edx
801062e7:	85 d2                	test   %edx,%edx
801062e9:	75 2d                	jne    80106318 <trap+0x108>
    killSelf();
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
801062eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801062f1:	85 c0                	test   %eax,%eax
801062f3:	74 18                	je     8010630d <trap+0xfd>
801062f5:	8b 40 14             	mov    0x14(%eax),%eax
801062f8:	85 c0                	test   %eax,%eax
801062fa:	74 11                	je     8010630d <trap+0xfd>
801062fc:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106300:	83 e0 03             	and    $0x3,%eax
80106303:	66 83 f8 03          	cmp    $0x3,%ax
80106307:	0f 84 8d 00 00 00    	je     8010639a <trap+0x18a>
    exit();
}
8010630d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106310:	5b                   	pop    %ebx
80106311:	5e                   	pop    %esi
80106312:	5f                   	pop    %edi
80106313:	5d                   	pop    %ebp
80106314:	c3                   	ret    
80106315:	8d 76 00             	lea    0x0(%esi),%esi
  // If interrupts were on while locks held, would need to check nlock.
  if(thread && thread->state == TRUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(thread && thread->killed && (tf->cs&3) == DPL_USER)
80106318:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010631c:	83 e0 03             	and    $0x3,%eax
8010631f:	66 83 f8 03          	cmp    $0x3,%ax
80106323:	75 c6                	jne    801062eb <trap+0xdb>
    killSelf();
80106325:	e8 66 e1 ff ff       	call   80104490 <killSelf>
8010632a:	eb bf                	jmp    801062eb <trap+0xdb>
8010632c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(thread && thread->killed && (tf->cs&3) == DPL_USER)
    killSelf();
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106330:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106334:	83 e0 03             	and    $0x3,%eax
80106337:	66 83 f8 03          	cmp    $0x3,%ax
8010633b:	75 93                	jne    801062d0 <trap+0xc0>
    exit();
8010633d:	e8 ee db ff ff       	call   80103f30 <exit>
80106342:	eb 8c                	jmp    801062d0 <trap+0xc0>
80106344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{	
  if(tf->trapno == T_SYSCALL){
    if(thread->killed)
80106348:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
8010634e:	8b 40 1c             	mov    0x1c(%eax),%eax
80106351:	85 c0                	test   %eax,%eax
80106353:	0f 85 47 01 00 00    	jne    801064a0 <trap+0x290>
      killSelf();
    if(proc->killed)
80106359:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010635f:	8b 40 14             	mov    0x14(%eax),%eax
80106362:	85 c0                	test   %eax,%eax
80106364:	0f 85 26 01 00 00    	jne    80106490 <trap+0x280>
      exit();
    thread->tf = tf;
8010636a:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
80106370:	89 58 10             	mov    %ebx,0x10(%eax)
    syscall();
80106373:	e8 c8 ed ff ff       	call   80105140 <syscall>
    if(thread->killed)
80106378:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
8010637e:	8b 40 1c             	mov    0x1c(%eax),%eax
80106381:	85 c0                	test   %eax,%eax
80106383:	0f 85 f7 00 00 00    	jne    80106480 <trap+0x270>
      killSelf();
    if(proc->killed)
80106389:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010638f:	8b 40 14             	mov    0x14(%eax),%eax
80106392:	85 c0                	test   %eax,%eax
80106394:	0f 84 73 ff ff ff    	je     8010630d <trap+0xfd>
  // Check if the process has been killed since we yielded
  if(thread && thread->killed && (tf->cs&3) == DPL_USER)
    killSelf();
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
8010639a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010639d:	5b                   	pop    %ebx
8010639e:	5e                   	pop    %esi
8010639f:	5f                   	pop    %edi
801063a0:	5d                   	pop    %ebp
    thread->tf = tf;
    syscall();
    if(thread->killed)
      killSelf();
    if(proc->killed)
      exit();
801063a1:	e9 8a db ff ff       	jmp    80103f30 <exit>
801063a6:	8d 76 00             	lea    0x0(%esi),%esi
801063a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(thread && thread->state == TRUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
801063b0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801063b4:	0f 85 2a ff ff ff    	jne    801062e4 <trap+0xd4>
    yield();
801063ba:	e8 11 dd ff ff       	call   801040d0 <yield>

  // Check if the process has been killed since we yielded
  if(thread && thread->killed && (tf->cs&3) == DPL_USER)
801063bf:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
801063c5:	85 c0                	test   %eax,%eax
801063c7:	0f 85 17 ff ff ff    	jne    801062e4 <trap+0xd4>
801063cd:	e9 19 ff ff ff       	jmp    801062eb <trap+0xdb>
801063d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return;
  }
  
  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
801063d8:	e8 73 c3 ff ff       	call   80102750 <cpunum>
801063dd:	85 c0                	test   %eax,%eax
801063df:	0f 84 db 00 00 00    	je     801064c0 <trap+0x2b0>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
801063e5:	e8 06 c4 ff ff       	call   801027f0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(thread && thread->killed && (tf->cs&3) == DPL_USER)
801063ea:	65 a1 08 00 00 00    	mov    %gs:0x8,%eax
801063f0:	85 c0                	test   %eax,%eax
801063f2:	0f 85 ae fe ff ff    	jne    801062a6 <trap+0x96>
    killSelf();
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
801063f8:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801063ff:	85 d2                	test   %edx,%edx
80106401:	0f 84 c9 fe ff ff    	je     801062d0 <trap+0xc0>
80106407:	8b 4a 14             	mov    0x14(%edx),%ecx
8010640a:	85 c9                	test   %ecx,%ecx
8010640c:	0f 84 be fe ff ff    	je     801062d0 <trap+0xc0>
80106412:	e9 19 ff ff ff       	jmp    80106330 <trap+0x120>
80106417:	89 f6                	mov    %esi,%esi
80106419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80106420:	e8 0b c2 ff ff       	call   80102630 <kbdintr>
    lapiceoi();
80106425:	e8 c6 c3 ff ff       	call   801027f0 <lapiceoi>
    break;
8010642a:	e9 69 fe ff ff       	jmp    80106298 <trap+0x88>
8010642f:	90                   	nop
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80106430:	e8 5b 02 00 00       	call   80106690 <uartintr>
    lapiceoi();
80106435:	e8 b6 c3 ff ff       	call   801027f0 <lapiceoi>
    break;
8010643a:	e9 59 fe ff ff       	jmp    80106298 <trap+0x88>
8010643f:	90                   	nop
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106440:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106444:	8b 7b 38             	mov    0x38(%ebx),%edi
80106447:	e8 04 c3 ff ff       	call   80102750 <cpunum>
8010644c:	57                   	push   %edi
8010644d:	56                   	push   %esi
8010644e:	50                   	push   %eax
8010644f:	68 08 84 10 80       	push   $0x80108408
80106454:	e8 e7 a1 ff ff       	call   80100640 <cprintf>
            cpunum(), tf->cs, tf->eip);
    lapiceoi();
80106459:	e8 92 c3 ff ff       	call   801027f0 <lapiceoi>
    break;
8010645e:	83 c4 10             	add    $0x10,%esp
80106461:	e9 32 fe ff ff       	jmp    80106298 <trap+0x88>
80106466:	8d 76 00             	lea    0x0(%esi),%esi
80106469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106470:	e8 3b bc ff ff       	call   801020b0 <ideintr>
80106475:	e9 6b ff ff ff       	jmp    801063e5 <trap+0x1d5>
8010647a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(proc->killed)
      exit();
    thread->tf = tf;
    syscall();
    if(thread->killed)
      killSelf();
80106480:	e8 0b e0 ff ff       	call   80104490 <killSelf>
80106485:	e9 ff fe ff ff       	jmp    80106389 <trap+0x179>
8010648a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{	
  if(tf->trapno == T_SYSCALL){
    if(thread->killed)
      killSelf();
    if(proc->killed)
      exit();
80106490:	e8 9b da ff ff       	call   80103f30 <exit>
80106495:	e9 d0 fe ff ff       	jmp    8010636a <trap+0x15a>
8010649a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{	
  if(tf->trapno == T_SYSCALL){
    if(thread->killed)
      killSelf();
801064a0:	e8 eb df ff ff       	call   80104490 <killSelf>
801064a5:	e9 af fe ff ff       	jmp    80106359 <trap+0x149>
801064aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(thread && thread->killed && (tf->cs&3) == DPL_USER)
    killSelf();
801064b0:	e8 db df ff ff       	call   80104490 <killSelf>
801064b5:	e9 3e ff ff ff       	jmp    801063f8 <trap+0x1e8>
801064ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  
  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
      acquire(&tickslock);
801064c0:	83 ec 0c             	sub    $0xc,%esp
801064c3:	68 80 d3 11 80       	push   $0x8011d380
801064c8:	e8 33 e6 ff ff       	call   80104b00 <acquire>
      ticks++;
      wakeup(&ticks);
801064cd:	c7 04 24 c0 db 11 80 	movl   $0x8011dbc0,(%esp)
  
  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
      acquire(&tickslock);
      ticks++;
801064d4:	83 05 c0 db 11 80 01 	addl   $0x1,0x8011dbc0
      wakeup(&ticks);
801064db:	e8 a0 de ff ff       	call   80104380 <wakeup>
      release(&tickslock);
801064e0:	c7 04 24 80 d3 11 80 	movl   $0x8011d380,(%esp)
801064e7:	e8 f4 e7 ff ff       	call   80104ce0 <release>
801064ec:	83 c4 10             	add    $0x10,%esp
801064ef:	e9 f1 fe ff ff       	jmp    801063e5 <trap+0x1d5>
801064f4:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(thread == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801064f7:	8b 73 38             	mov    0x38(%ebx),%esi
801064fa:	e8 51 c2 ff ff       	call   80102750 <cpunum>
801064ff:	83 ec 0c             	sub    $0xc,%esp
80106502:	57                   	push   %edi
80106503:	56                   	push   %esi
80106504:	50                   	push   %eax
80106505:	ff 73 30             	pushl  0x30(%ebx)
80106508:	68 2c 84 10 80       	push   $0x8010842c
8010650d:	e8 2e a1 ff ff       	call   80100640 <cprintf>
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
80106512:	83 c4 14             	add    $0x14,%esp
80106515:	68 02 84 10 80       	push   $0x80108402
8010651a:	e8 31 9e ff ff       	call   80100350 <panic>
8010651f:	90                   	nop

80106520 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106520:	a1 c0 b5 10 80       	mov    0x8010b5c0,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80106525:	55                   	push   %ebp
80106526:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106528:	85 c0                	test   %eax,%eax
8010652a:	74 1c                	je     80106548 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010652c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106531:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106532:	a8 01                	test   $0x1,%al
80106534:	74 12                	je     80106548 <uartgetc+0x28>
80106536:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010653b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010653c:	0f b6 c0             	movzbl %al,%eax
}
8010653f:	5d                   	pop    %ebp
80106540:	c3                   	ret    
80106541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80106548:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
8010654d:	5d                   	pop    %ebp
8010654e:	c3                   	ret    
8010654f:	90                   	nop

80106550 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80106550:	55                   	push   %ebp
80106551:	89 e5                	mov    %esp,%ebp
80106553:	57                   	push   %edi
80106554:	56                   	push   %esi
80106555:	53                   	push   %ebx
80106556:	89 c7                	mov    %eax,%edi
80106558:	bb 80 00 00 00       	mov    $0x80,%ebx
8010655d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106562:	83 ec 0c             	sub    $0xc,%esp
80106565:	eb 1b                	jmp    80106582 <uartputc.part.0+0x32>
80106567:	89 f6                	mov    %esi,%esi
80106569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80106570:	83 ec 0c             	sub    $0xc,%esp
80106573:	6a 0a                	push   $0xa
80106575:	e8 96 c2 ff ff       	call   80102810 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010657a:	83 c4 10             	add    $0x10,%esp
8010657d:	83 eb 01             	sub    $0x1,%ebx
80106580:	74 07                	je     80106589 <uartputc.part.0+0x39>
80106582:	89 f2                	mov    %esi,%edx
80106584:	ec                   	in     (%dx),%al
80106585:	a8 20                	test   $0x20,%al
80106587:	74 e7                	je     80106570 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106589:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010658e:	89 f8                	mov    %edi,%eax
80106590:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80106591:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106594:	5b                   	pop    %ebx
80106595:	5e                   	pop    %esi
80106596:	5f                   	pop    %edi
80106597:	5d                   	pop    %ebp
80106598:	c3                   	ret    
80106599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801065a0 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
801065a0:	55                   	push   %ebp
801065a1:	31 c9                	xor    %ecx,%ecx
801065a3:	89 c8                	mov    %ecx,%eax
801065a5:	89 e5                	mov    %esp,%ebp
801065a7:	57                   	push   %edi
801065a8:	56                   	push   %esi
801065a9:	53                   	push   %ebx
801065aa:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801065af:	89 da                	mov    %ebx,%edx
801065b1:	83 ec 0c             	sub    $0xc,%esp
801065b4:	ee                   	out    %al,(%dx)
801065b5:	bf fb 03 00 00       	mov    $0x3fb,%edi
801065ba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801065bf:	89 fa                	mov    %edi,%edx
801065c1:	ee                   	out    %al,(%dx)
801065c2:	b8 0c 00 00 00       	mov    $0xc,%eax
801065c7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801065cc:	ee                   	out    %al,(%dx)
801065cd:	be f9 03 00 00       	mov    $0x3f9,%esi
801065d2:	89 c8                	mov    %ecx,%eax
801065d4:	89 f2                	mov    %esi,%edx
801065d6:	ee                   	out    %al,(%dx)
801065d7:	b8 03 00 00 00       	mov    $0x3,%eax
801065dc:	89 fa                	mov    %edi,%edx
801065de:	ee                   	out    %al,(%dx)
801065df:	ba fc 03 00 00       	mov    $0x3fc,%edx
801065e4:	89 c8                	mov    %ecx,%eax
801065e6:	ee                   	out    %al,(%dx)
801065e7:	b8 01 00 00 00       	mov    $0x1,%eax
801065ec:	89 f2                	mov    %esi,%edx
801065ee:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801065ef:	ba fd 03 00 00       	mov    $0x3fd,%edx
801065f4:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
801065f5:	3c ff                	cmp    $0xff,%al
801065f7:	74 5a                	je     80106653 <uartinit+0xb3>
    return;
  uart = 1;
801065f9:	c7 05 c0 b5 10 80 01 	movl   $0x1,0x8010b5c0
80106600:	00 00 00 
80106603:	89 da                	mov    %ebx,%edx
80106605:	ec                   	in     (%dx),%al
80106606:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010660b:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
8010660c:	83 ec 0c             	sub    $0xc,%esp
8010660f:	6a 04                	push   $0x4
80106611:	e8 ea cc ff ff       	call   80103300 <picenable>
  ioapicenable(IRQ_COM1, 0);
80106616:	59                   	pop    %ecx
80106617:	5b                   	pop    %ebx
80106618:	6a 00                	push   $0x0
8010661a:	6a 04                	push   $0x4
8010661c:	bb 24 85 10 80       	mov    $0x80108524,%ebx
80106621:	e8 da bc ff ff       	call   80102300 <ioapicenable>
80106626:	83 c4 10             	add    $0x10,%esp
80106629:	b8 78 00 00 00       	mov    $0x78,%eax
8010662e:	eb 0a                	jmp    8010663a <uartinit+0x9a>

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106630:	83 c3 01             	add    $0x1,%ebx
80106633:	0f be 03             	movsbl (%ebx),%eax
80106636:	84 c0                	test   %al,%al
80106638:	74 19                	je     80106653 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
8010663a:	8b 15 c0 b5 10 80    	mov    0x8010b5c0,%edx
80106640:	85 d2                	test   %edx,%edx
80106642:	74 ec                	je     80106630 <uartinit+0x90>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106644:	83 c3 01             	add    $0x1,%ebx
80106647:	e8 04 ff ff ff       	call   80106550 <uartputc.part.0>
8010664c:	0f be 03             	movsbl (%ebx),%eax
8010664f:	84 c0                	test   %al,%al
80106651:	75 e7                	jne    8010663a <uartinit+0x9a>
    uartputc(*p);
}
80106653:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106656:	5b                   	pop    %ebx
80106657:	5e                   	pop    %esi
80106658:	5f                   	pop    %edi
80106659:	5d                   	pop    %ebp
8010665a:	c3                   	ret    
8010665b:	90                   	nop
8010665c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106660 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80106660:	8b 15 c0 b5 10 80    	mov    0x8010b5c0,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80106666:	55                   	push   %ebp
80106667:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80106669:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
8010666b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
8010666e:	74 10                	je     80106680 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106670:	5d                   	pop    %ebp
80106671:	e9 da fe ff ff       	jmp    80106550 <uartputc.part.0>
80106676:	8d 76 00             	lea    0x0(%esi),%esi
80106679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106680:	5d                   	pop    %ebp
80106681:	c3                   	ret    
80106682:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106690 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80106690:	55                   	push   %ebp
80106691:	89 e5                	mov    %esp,%ebp
80106693:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106696:	68 20 65 10 80       	push   $0x80106520
8010669b:	e8 30 a1 ff ff       	call   801007d0 <consoleintr>
}
801066a0:	83 c4 10             	add    $0x10,%esp
801066a3:	c9                   	leave  
801066a4:	c3                   	ret    

801066a5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801066a5:	6a 00                	push   $0x0
  pushl $0
801066a7:	6a 00                	push   $0x0
  jmp alltraps
801066a9:	e9 60 fa ff ff       	jmp    8010610e <alltraps>

801066ae <vector1>:
.globl vector1
vector1:
  pushl $0
801066ae:	6a 00                	push   $0x0
  pushl $1
801066b0:	6a 01                	push   $0x1
  jmp alltraps
801066b2:	e9 57 fa ff ff       	jmp    8010610e <alltraps>

801066b7 <vector2>:
.globl vector2
vector2:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $2
801066b9:	6a 02                	push   $0x2
  jmp alltraps
801066bb:	e9 4e fa ff ff       	jmp    8010610e <alltraps>

801066c0 <vector3>:
.globl vector3
vector3:
  pushl $0
801066c0:	6a 00                	push   $0x0
  pushl $3
801066c2:	6a 03                	push   $0x3
  jmp alltraps
801066c4:	e9 45 fa ff ff       	jmp    8010610e <alltraps>

801066c9 <vector4>:
.globl vector4
vector4:
  pushl $0
801066c9:	6a 00                	push   $0x0
  pushl $4
801066cb:	6a 04                	push   $0x4
  jmp alltraps
801066cd:	e9 3c fa ff ff       	jmp    8010610e <alltraps>

801066d2 <vector5>:
.globl vector5
vector5:
  pushl $0
801066d2:	6a 00                	push   $0x0
  pushl $5
801066d4:	6a 05                	push   $0x5
  jmp alltraps
801066d6:	e9 33 fa ff ff       	jmp    8010610e <alltraps>

801066db <vector6>:
.globl vector6
vector6:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $6
801066dd:	6a 06                	push   $0x6
  jmp alltraps
801066df:	e9 2a fa ff ff       	jmp    8010610e <alltraps>

801066e4 <vector7>:
.globl vector7
vector7:
  pushl $0
801066e4:	6a 00                	push   $0x0
  pushl $7
801066e6:	6a 07                	push   $0x7
  jmp alltraps
801066e8:	e9 21 fa ff ff       	jmp    8010610e <alltraps>

801066ed <vector8>:
.globl vector8
vector8:
  pushl $8
801066ed:	6a 08                	push   $0x8
  jmp alltraps
801066ef:	e9 1a fa ff ff       	jmp    8010610e <alltraps>

801066f4 <vector9>:
.globl vector9
vector9:
  pushl $0
801066f4:	6a 00                	push   $0x0
  pushl $9
801066f6:	6a 09                	push   $0x9
  jmp alltraps
801066f8:	e9 11 fa ff ff       	jmp    8010610e <alltraps>

801066fd <vector10>:
.globl vector10
vector10:
  pushl $10
801066fd:	6a 0a                	push   $0xa
  jmp alltraps
801066ff:	e9 0a fa ff ff       	jmp    8010610e <alltraps>

80106704 <vector11>:
.globl vector11
vector11:
  pushl $11
80106704:	6a 0b                	push   $0xb
  jmp alltraps
80106706:	e9 03 fa ff ff       	jmp    8010610e <alltraps>

8010670b <vector12>:
.globl vector12
vector12:
  pushl $12
8010670b:	6a 0c                	push   $0xc
  jmp alltraps
8010670d:	e9 fc f9 ff ff       	jmp    8010610e <alltraps>

80106712 <vector13>:
.globl vector13
vector13:
  pushl $13
80106712:	6a 0d                	push   $0xd
  jmp alltraps
80106714:	e9 f5 f9 ff ff       	jmp    8010610e <alltraps>

80106719 <vector14>:
.globl vector14
vector14:
  pushl $14
80106719:	6a 0e                	push   $0xe
  jmp alltraps
8010671b:	e9 ee f9 ff ff       	jmp    8010610e <alltraps>

80106720 <vector15>:
.globl vector15
vector15:
  pushl $0
80106720:	6a 00                	push   $0x0
  pushl $15
80106722:	6a 0f                	push   $0xf
  jmp alltraps
80106724:	e9 e5 f9 ff ff       	jmp    8010610e <alltraps>

80106729 <vector16>:
.globl vector16
vector16:
  pushl $0
80106729:	6a 00                	push   $0x0
  pushl $16
8010672b:	6a 10                	push   $0x10
  jmp alltraps
8010672d:	e9 dc f9 ff ff       	jmp    8010610e <alltraps>

80106732 <vector17>:
.globl vector17
vector17:
  pushl $17
80106732:	6a 11                	push   $0x11
  jmp alltraps
80106734:	e9 d5 f9 ff ff       	jmp    8010610e <alltraps>

80106739 <vector18>:
.globl vector18
vector18:
  pushl $0
80106739:	6a 00                	push   $0x0
  pushl $18
8010673b:	6a 12                	push   $0x12
  jmp alltraps
8010673d:	e9 cc f9 ff ff       	jmp    8010610e <alltraps>

80106742 <vector19>:
.globl vector19
vector19:
  pushl $0
80106742:	6a 00                	push   $0x0
  pushl $19
80106744:	6a 13                	push   $0x13
  jmp alltraps
80106746:	e9 c3 f9 ff ff       	jmp    8010610e <alltraps>

8010674b <vector20>:
.globl vector20
vector20:
  pushl $0
8010674b:	6a 00                	push   $0x0
  pushl $20
8010674d:	6a 14                	push   $0x14
  jmp alltraps
8010674f:	e9 ba f9 ff ff       	jmp    8010610e <alltraps>

80106754 <vector21>:
.globl vector21
vector21:
  pushl $0
80106754:	6a 00                	push   $0x0
  pushl $21
80106756:	6a 15                	push   $0x15
  jmp alltraps
80106758:	e9 b1 f9 ff ff       	jmp    8010610e <alltraps>

8010675d <vector22>:
.globl vector22
vector22:
  pushl $0
8010675d:	6a 00                	push   $0x0
  pushl $22
8010675f:	6a 16                	push   $0x16
  jmp alltraps
80106761:	e9 a8 f9 ff ff       	jmp    8010610e <alltraps>

80106766 <vector23>:
.globl vector23
vector23:
  pushl $0
80106766:	6a 00                	push   $0x0
  pushl $23
80106768:	6a 17                	push   $0x17
  jmp alltraps
8010676a:	e9 9f f9 ff ff       	jmp    8010610e <alltraps>

8010676f <vector24>:
.globl vector24
vector24:
  pushl $0
8010676f:	6a 00                	push   $0x0
  pushl $24
80106771:	6a 18                	push   $0x18
  jmp alltraps
80106773:	e9 96 f9 ff ff       	jmp    8010610e <alltraps>

80106778 <vector25>:
.globl vector25
vector25:
  pushl $0
80106778:	6a 00                	push   $0x0
  pushl $25
8010677a:	6a 19                	push   $0x19
  jmp alltraps
8010677c:	e9 8d f9 ff ff       	jmp    8010610e <alltraps>

80106781 <vector26>:
.globl vector26
vector26:
  pushl $0
80106781:	6a 00                	push   $0x0
  pushl $26
80106783:	6a 1a                	push   $0x1a
  jmp alltraps
80106785:	e9 84 f9 ff ff       	jmp    8010610e <alltraps>

8010678a <vector27>:
.globl vector27
vector27:
  pushl $0
8010678a:	6a 00                	push   $0x0
  pushl $27
8010678c:	6a 1b                	push   $0x1b
  jmp alltraps
8010678e:	e9 7b f9 ff ff       	jmp    8010610e <alltraps>

80106793 <vector28>:
.globl vector28
vector28:
  pushl $0
80106793:	6a 00                	push   $0x0
  pushl $28
80106795:	6a 1c                	push   $0x1c
  jmp alltraps
80106797:	e9 72 f9 ff ff       	jmp    8010610e <alltraps>

8010679c <vector29>:
.globl vector29
vector29:
  pushl $0
8010679c:	6a 00                	push   $0x0
  pushl $29
8010679e:	6a 1d                	push   $0x1d
  jmp alltraps
801067a0:	e9 69 f9 ff ff       	jmp    8010610e <alltraps>

801067a5 <vector30>:
.globl vector30
vector30:
  pushl $0
801067a5:	6a 00                	push   $0x0
  pushl $30
801067a7:	6a 1e                	push   $0x1e
  jmp alltraps
801067a9:	e9 60 f9 ff ff       	jmp    8010610e <alltraps>

801067ae <vector31>:
.globl vector31
vector31:
  pushl $0
801067ae:	6a 00                	push   $0x0
  pushl $31
801067b0:	6a 1f                	push   $0x1f
  jmp alltraps
801067b2:	e9 57 f9 ff ff       	jmp    8010610e <alltraps>

801067b7 <vector32>:
.globl vector32
vector32:
  pushl $0
801067b7:	6a 00                	push   $0x0
  pushl $32
801067b9:	6a 20                	push   $0x20
  jmp alltraps
801067bb:	e9 4e f9 ff ff       	jmp    8010610e <alltraps>

801067c0 <vector33>:
.globl vector33
vector33:
  pushl $0
801067c0:	6a 00                	push   $0x0
  pushl $33
801067c2:	6a 21                	push   $0x21
  jmp alltraps
801067c4:	e9 45 f9 ff ff       	jmp    8010610e <alltraps>

801067c9 <vector34>:
.globl vector34
vector34:
  pushl $0
801067c9:	6a 00                	push   $0x0
  pushl $34
801067cb:	6a 22                	push   $0x22
  jmp alltraps
801067cd:	e9 3c f9 ff ff       	jmp    8010610e <alltraps>

801067d2 <vector35>:
.globl vector35
vector35:
  pushl $0
801067d2:	6a 00                	push   $0x0
  pushl $35
801067d4:	6a 23                	push   $0x23
  jmp alltraps
801067d6:	e9 33 f9 ff ff       	jmp    8010610e <alltraps>

801067db <vector36>:
.globl vector36
vector36:
  pushl $0
801067db:	6a 00                	push   $0x0
  pushl $36
801067dd:	6a 24                	push   $0x24
  jmp alltraps
801067df:	e9 2a f9 ff ff       	jmp    8010610e <alltraps>

801067e4 <vector37>:
.globl vector37
vector37:
  pushl $0
801067e4:	6a 00                	push   $0x0
  pushl $37
801067e6:	6a 25                	push   $0x25
  jmp alltraps
801067e8:	e9 21 f9 ff ff       	jmp    8010610e <alltraps>

801067ed <vector38>:
.globl vector38
vector38:
  pushl $0
801067ed:	6a 00                	push   $0x0
  pushl $38
801067ef:	6a 26                	push   $0x26
  jmp alltraps
801067f1:	e9 18 f9 ff ff       	jmp    8010610e <alltraps>

801067f6 <vector39>:
.globl vector39
vector39:
  pushl $0
801067f6:	6a 00                	push   $0x0
  pushl $39
801067f8:	6a 27                	push   $0x27
  jmp alltraps
801067fa:	e9 0f f9 ff ff       	jmp    8010610e <alltraps>

801067ff <vector40>:
.globl vector40
vector40:
  pushl $0
801067ff:	6a 00                	push   $0x0
  pushl $40
80106801:	6a 28                	push   $0x28
  jmp alltraps
80106803:	e9 06 f9 ff ff       	jmp    8010610e <alltraps>

80106808 <vector41>:
.globl vector41
vector41:
  pushl $0
80106808:	6a 00                	push   $0x0
  pushl $41
8010680a:	6a 29                	push   $0x29
  jmp alltraps
8010680c:	e9 fd f8 ff ff       	jmp    8010610e <alltraps>

80106811 <vector42>:
.globl vector42
vector42:
  pushl $0
80106811:	6a 00                	push   $0x0
  pushl $42
80106813:	6a 2a                	push   $0x2a
  jmp alltraps
80106815:	e9 f4 f8 ff ff       	jmp    8010610e <alltraps>

8010681a <vector43>:
.globl vector43
vector43:
  pushl $0
8010681a:	6a 00                	push   $0x0
  pushl $43
8010681c:	6a 2b                	push   $0x2b
  jmp alltraps
8010681e:	e9 eb f8 ff ff       	jmp    8010610e <alltraps>

80106823 <vector44>:
.globl vector44
vector44:
  pushl $0
80106823:	6a 00                	push   $0x0
  pushl $44
80106825:	6a 2c                	push   $0x2c
  jmp alltraps
80106827:	e9 e2 f8 ff ff       	jmp    8010610e <alltraps>

8010682c <vector45>:
.globl vector45
vector45:
  pushl $0
8010682c:	6a 00                	push   $0x0
  pushl $45
8010682e:	6a 2d                	push   $0x2d
  jmp alltraps
80106830:	e9 d9 f8 ff ff       	jmp    8010610e <alltraps>

80106835 <vector46>:
.globl vector46
vector46:
  pushl $0
80106835:	6a 00                	push   $0x0
  pushl $46
80106837:	6a 2e                	push   $0x2e
  jmp alltraps
80106839:	e9 d0 f8 ff ff       	jmp    8010610e <alltraps>

8010683e <vector47>:
.globl vector47
vector47:
  pushl $0
8010683e:	6a 00                	push   $0x0
  pushl $47
80106840:	6a 2f                	push   $0x2f
  jmp alltraps
80106842:	e9 c7 f8 ff ff       	jmp    8010610e <alltraps>

80106847 <vector48>:
.globl vector48
vector48:
  pushl $0
80106847:	6a 00                	push   $0x0
  pushl $48
80106849:	6a 30                	push   $0x30
  jmp alltraps
8010684b:	e9 be f8 ff ff       	jmp    8010610e <alltraps>

80106850 <vector49>:
.globl vector49
vector49:
  pushl $0
80106850:	6a 00                	push   $0x0
  pushl $49
80106852:	6a 31                	push   $0x31
  jmp alltraps
80106854:	e9 b5 f8 ff ff       	jmp    8010610e <alltraps>

80106859 <vector50>:
.globl vector50
vector50:
  pushl $0
80106859:	6a 00                	push   $0x0
  pushl $50
8010685b:	6a 32                	push   $0x32
  jmp alltraps
8010685d:	e9 ac f8 ff ff       	jmp    8010610e <alltraps>

80106862 <vector51>:
.globl vector51
vector51:
  pushl $0
80106862:	6a 00                	push   $0x0
  pushl $51
80106864:	6a 33                	push   $0x33
  jmp alltraps
80106866:	e9 a3 f8 ff ff       	jmp    8010610e <alltraps>

8010686b <vector52>:
.globl vector52
vector52:
  pushl $0
8010686b:	6a 00                	push   $0x0
  pushl $52
8010686d:	6a 34                	push   $0x34
  jmp alltraps
8010686f:	e9 9a f8 ff ff       	jmp    8010610e <alltraps>

80106874 <vector53>:
.globl vector53
vector53:
  pushl $0
80106874:	6a 00                	push   $0x0
  pushl $53
80106876:	6a 35                	push   $0x35
  jmp alltraps
80106878:	e9 91 f8 ff ff       	jmp    8010610e <alltraps>

8010687d <vector54>:
.globl vector54
vector54:
  pushl $0
8010687d:	6a 00                	push   $0x0
  pushl $54
8010687f:	6a 36                	push   $0x36
  jmp alltraps
80106881:	e9 88 f8 ff ff       	jmp    8010610e <alltraps>

80106886 <vector55>:
.globl vector55
vector55:
  pushl $0
80106886:	6a 00                	push   $0x0
  pushl $55
80106888:	6a 37                	push   $0x37
  jmp alltraps
8010688a:	e9 7f f8 ff ff       	jmp    8010610e <alltraps>

8010688f <vector56>:
.globl vector56
vector56:
  pushl $0
8010688f:	6a 00                	push   $0x0
  pushl $56
80106891:	6a 38                	push   $0x38
  jmp alltraps
80106893:	e9 76 f8 ff ff       	jmp    8010610e <alltraps>

80106898 <vector57>:
.globl vector57
vector57:
  pushl $0
80106898:	6a 00                	push   $0x0
  pushl $57
8010689a:	6a 39                	push   $0x39
  jmp alltraps
8010689c:	e9 6d f8 ff ff       	jmp    8010610e <alltraps>

801068a1 <vector58>:
.globl vector58
vector58:
  pushl $0
801068a1:	6a 00                	push   $0x0
  pushl $58
801068a3:	6a 3a                	push   $0x3a
  jmp alltraps
801068a5:	e9 64 f8 ff ff       	jmp    8010610e <alltraps>

801068aa <vector59>:
.globl vector59
vector59:
  pushl $0
801068aa:	6a 00                	push   $0x0
  pushl $59
801068ac:	6a 3b                	push   $0x3b
  jmp alltraps
801068ae:	e9 5b f8 ff ff       	jmp    8010610e <alltraps>

801068b3 <vector60>:
.globl vector60
vector60:
  pushl $0
801068b3:	6a 00                	push   $0x0
  pushl $60
801068b5:	6a 3c                	push   $0x3c
  jmp alltraps
801068b7:	e9 52 f8 ff ff       	jmp    8010610e <alltraps>

801068bc <vector61>:
.globl vector61
vector61:
  pushl $0
801068bc:	6a 00                	push   $0x0
  pushl $61
801068be:	6a 3d                	push   $0x3d
  jmp alltraps
801068c0:	e9 49 f8 ff ff       	jmp    8010610e <alltraps>

801068c5 <vector62>:
.globl vector62
vector62:
  pushl $0
801068c5:	6a 00                	push   $0x0
  pushl $62
801068c7:	6a 3e                	push   $0x3e
  jmp alltraps
801068c9:	e9 40 f8 ff ff       	jmp    8010610e <alltraps>

801068ce <vector63>:
.globl vector63
vector63:
  pushl $0
801068ce:	6a 00                	push   $0x0
  pushl $63
801068d0:	6a 3f                	push   $0x3f
  jmp alltraps
801068d2:	e9 37 f8 ff ff       	jmp    8010610e <alltraps>

801068d7 <vector64>:
.globl vector64
vector64:
  pushl $0
801068d7:	6a 00                	push   $0x0
  pushl $64
801068d9:	6a 40                	push   $0x40
  jmp alltraps
801068db:	e9 2e f8 ff ff       	jmp    8010610e <alltraps>

801068e0 <vector65>:
.globl vector65
vector65:
  pushl $0
801068e0:	6a 00                	push   $0x0
  pushl $65
801068e2:	6a 41                	push   $0x41
  jmp alltraps
801068e4:	e9 25 f8 ff ff       	jmp    8010610e <alltraps>

801068e9 <vector66>:
.globl vector66
vector66:
  pushl $0
801068e9:	6a 00                	push   $0x0
  pushl $66
801068eb:	6a 42                	push   $0x42
  jmp alltraps
801068ed:	e9 1c f8 ff ff       	jmp    8010610e <alltraps>

801068f2 <vector67>:
.globl vector67
vector67:
  pushl $0
801068f2:	6a 00                	push   $0x0
  pushl $67
801068f4:	6a 43                	push   $0x43
  jmp alltraps
801068f6:	e9 13 f8 ff ff       	jmp    8010610e <alltraps>

801068fb <vector68>:
.globl vector68
vector68:
  pushl $0
801068fb:	6a 00                	push   $0x0
  pushl $68
801068fd:	6a 44                	push   $0x44
  jmp alltraps
801068ff:	e9 0a f8 ff ff       	jmp    8010610e <alltraps>

80106904 <vector69>:
.globl vector69
vector69:
  pushl $0
80106904:	6a 00                	push   $0x0
  pushl $69
80106906:	6a 45                	push   $0x45
  jmp alltraps
80106908:	e9 01 f8 ff ff       	jmp    8010610e <alltraps>

8010690d <vector70>:
.globl vector70
vector70:
  pushl $0
8010690d:	6a 00                	push   $0x0
  pushl $70
8010690f:	6a 46                	push   $0x46
  jmp alltraps
80106911:	e9 f8 f7 ff ff       	jmp    8010610e <alltraps>

80106916 <vector71>:
.globl vector71
vector71:
  pushl $0
80106916:	6a 00                	push   $0x0
  pushl $71
80106918:	6a 47                	push   $0x47
  jmp alltraps
8010691a:	e9 ef f7 ff ff       	jmp    8010610e <alltraps>

8010691f <vector72>:
.globl vector72
vector72:
  pushl $0
8010691f:	6a 00                	push   $0x0
  pushl $72
80106921:	6a 48                	push   $0x48
  jmp alltraps
80106923:	e9 e6 f7 ff ff       	jmp    8010610e <alltraps>

80106928 <vector73>:
.globl vector73
vector73:
  pushl $0
80106928:	6a 00                	push   $0x0
  pushl $73
8010692a:	6a 49                	push   $0x49
  jmp alltraps
8010692c:	e9 dd f7 ff ff       	jmp    8010610e <alltraps>

80106931 <vector74>:
.globl vector74
vector74:
  pushl $0
80106931:	6a 00                	push   $0x0
  pushl $74
80106933:	6a 4a                	push   $0x4a
  jmp alltraps
80106935:	e9 d4 f7 ff ff       	jmp    8010610e <alltraps>

8010693a <vector75>:
.globl vector75
vector75:
  pushl $0
8010693a:	6a 00                	push   $0x0
  pushl $75
8010693c:	6a 4b                	push   $0x4b
  jmp alltraps
8010693e:	e9 cb f7 ff ff       	jmp    8010610e <alltraps>

80106943 <vector76>:
.globl vector76
vector76:
  pushl $0
80106943:	6a 00                	push   $0x0
  pushl $76
80106945:	6a 4c                	push   $0x4c
  jmp alltraps
80106947:	e9 c2 f7 ff ff       	jmp    8010610e <alltraps>

8010694c <vector77>:
.globl vector77
vector77:
  pushl $0
8010694c:	6a 00                	push   $0x0
  pushl $77
8010694e:	6a 4d                	push   $0x4d
  jmp alltraps
80106950:	e9 b9 f7 ff ff       	jmp    8010610e <alltraps>

80106955 <vector78>:
.globl vector78
vector78:
  pushl $0
80106955:	6a 00                	push   $0x0
  pushl $78
80106957:	6a 4e                	push   $0x4e
  jmp alltraps
80106959:	e9 b0 f7 ff ff       	jmp    8010610e <alltraps>

8010695e <vector79>:
.globl vector79
vector79:
  pushl $0
8010695e:	6a 00                	push   $0x0
  pushl $79
80106960:	6a 4f                	push   $0x4f
  jmp alltraps
80106962:	e9 a7 f7 ff ff       	jmp    8010610e <alltraps>

80106967 <vector80>:
.globl vector80
vector80:
  pushl $0
80106967:	6a 00                	push   $0x0
  pushl $80
80106969:	6a 50                	push   $0x50
  jmp alltraps
8010696b:	e9 9e f7 ff ff       	jmp    8010610e <alltraps>

80106970 <vector81>:
.globl vector81
vector81:
  pushl $0
80106970:	6a 00                	push   $0x0
  pushl $81
80106972:	6a 51                	push   $0x51
  jmp alltraps
80106974:	e9 95 f7 ff ff       	jmp    8010610e <alltraps>

80106979 <vector82>:
.globl vector82
vector82:
  pushl $0
80106979:	6a 00                	push   $0x0
  pushl $82
8010697b:	6a 52                	push   $0x52
  jmp alltraps
8010697d:	e9 8c f7 ff ff       	jmp    8010610e <alltraps>

80106982 <vector83>:
.globl vector83
vector83:
  pushl $0
80106982:	6a 00                	push   $0x0
  pushl $83
80106984:	6a 53                	push   $0x53
  jmp alltraps
80106986:	e9 83 f7 ff ff       	jmp    8010610e <alltraps>

8010698b <vector84>:
.globl vector84
vector84:
  pushl $0
8010698b:	6a 00                	push   $0x0
  pushl $84
8010698d:	6a 54                	push   $0x54
  jmp alltraps
8010698f:	e9 7a f7 ff ff       	jmp    8010610e <alltraps>

80106994 <vector85>:
.globl vector85
vector85:
  pushl $0
80106994:	6a 00                	push   $0x0
  pushl $85
80106996:	6a 55                	push   $0x55
  jmp alltraps
80106998:	e9 71 f7 ff ff       	jmp    8010610e <alltraps>

8010699d <vector86>:
.globl vector86
vector86:
  pushl $0
8010699d:	6a 00                	push   $0x0
  pushl $86
8010699f:	6a 56                	push   $0x56
  jmp alltraps
801069a1:	e9 68 f7 ff ff       	jmp    8010610e <alltraps>

801069a6 <vector87>:
.globl vector87
vector87:
  pushl $0
801069a6:	6a 00                	push   $0x0
  pushl $87
801069a8:	6a 57                	push   $0x57
  jmp alltraps
801069aa:	e9 5f f7 ff ff       	jmp    8010610e <alltraps>

801069af <vector88>:
.globl vector88
vector88:
  pushl $0
801069af:	6a 00                	push   $0x0
  pushl $88
801069b1:	6a 58                	push   $0x58
  jmp alltraps
801069b3:	e9 56 f7 ff ff       	jmp    8010610e <alltraps>

801069b8 <vector89>:
.globl vector89
vector89:
  pushl $0
801069b8:	6a 00                	push   $0x0
  pushl $89
801069ba:	6a 59                	push   $0x59
  jmp alltraps
801069bc:	e9 4d f7 ff ff       	jmp    8010610e <alltraps>

801069c1 <vector90>:
.globl vector90
vector90:
  pushl $0
801069c1:	6a 00                	push   $0x0
  pushl $90
801069c3:	6a 5a                	push   $0x5a
  jmp alltraps
801069c5:	e9 44 f7 ff ff       	jmp    8010610e <alltraps>

801069ca <vector91>:
.globl vector91
vector91:
  pushl $0
801069ca:	6a 00                	push   $0x0
  pushl $91
801069cc:	6a 5b                	push   $0x5b
  jmp alltraps
801069ce:	e9 3b f7 ff ff       	jmp    8010610e <alltraps>

801069d3 <vector92>:
.globl vector92
vector92:
  pushl $0
801069d3:	6a 00                	push   $0x0
  pushl $92
801069d5:	6a 5c                	push   $0x5c
  jmp alltraps
801069d7:	e9 32 f7 ff ff       	jmp    8010610e <alltraps>

801069dc <vector93>:
.globl vector93
vector93:
  pushl $0
801069dc:	6a 00                	push   $0x0
  pushl $93
801069de:	6a 5d                	push   $0x5d
  jmp alltraps
801069e0:	e9 29 f7 ff ff       	jmp    8010610e <alltraps>

801069e5 <vector94>:
.globl vector94
vector94:
  pushl $0
801069e5:	6a 00                	push   $0x0
  pushl $94
801069e7:	6a 5e                	push   $0x5e
  jmp alltraps
801069e9:	e9 20 f7 ff ff       	jmp    8010610e <alltraps>

801069ee <vector95>:
.globl vector95
vector95:
  pushl $0
801069ee:	6a 00                	push   $0x0
  pushl $95
801069f0:	6a 5f                	push   $0x5f
  jmp alltraps
801069f2:	e9 17 f7 ff ff       	jmp    8010610e <alltraps>

801069f7 <vector96>:
.globl vector96
vector96:
  pushl $0
801069f7:	6a 00                	push   $0x0
  pushl $96
801069f9:	6a 60                	push   $0x60
  jmp alltraps
801069fb:	e9 0e f7 ff ff       	jmp    8010610e <alltraps>

80106a00 <vector97>:
.globl vector97
vector97:
  pushl $0
80106a00:	6a 00                	push   $0x0
  pushl $97
80106a02:	6a 61                	push   $0x61
  jmp alltraps
80106a04:	e9 05 f7 ff ff       	jmp    8010610e <alltraps>

80106a09 <vector98>:
.globl vector98
vector98:
  pushl $0
80106a09:	6a 00                	push   $0x0
  pushl $98
80106a0b:	6a 62                	push   $0x62
  jmp alltraps
80106a0d:	e9 fc f6 ff ff       	jmp    8010610e <alltraps>

80106a12 <vector99>:
.globl vector99
vector99:
  pushl $0
80106a12:	6a 00                	push   $0x0
  pushl $99
80106a14:	6a 63                	push   $0x63
  jmp alltraps
80106a16:	e9 f3 f6 ff ff       	jmp    8010610e <alltraps>

80106a1b <vector100>:
.globl vector100
vector100:
  pushl $0
80106a1b:	6a 00                	push   $0x0
  pushl $100
80106a1d:	6a 64                	push   $0x64
  jmp alltraps
80106a1f:	e9 ea f6 ff ff       	jmp    8010610e <alltraps>

80106a24 <vector101>:
.globl vector101
vector101:
  pushl $0
80106a24:	6a 00                	push   $0x0
  pushl $101
80106a26:	6a 65                	push   $0x65
  jmp alltraps
80106a28:	e9 e1 f6 ff ff       	jmp    8010610e <alltraps>

80106a2d <vector102>:
.globl vector102
vector102:
  pushl $0
80106a2d:	6a 00                	push   $0x0
  pushl $102
80106a2f:	6a 66                	push   $0x66
  jmp alltraps
80106a31:	e9 d8 f6 ff ff       	jmp    8010610e <alltraps>

80106a36 <vector103>:
.globl vector103
vector103:
  pushl $0
80106a36:	6a 00                	push   $0x0
  pushl $103
80106a38:	6a 67                	push   $0x67
  jmp alltraps
80106a3a:	e9 cf f6 ff ff       	jmp    8010610e <alltraps>

80106a3f <vector104>:
.globl vector104
vector104:
  pushl $0
80106a3f:	6a 00                	push   $0x0
  pushl $104
80106a41:	6a 68                	push   $0x68
  jmp alltraps
80106a43:	e9 c6 f6 ff ff       	jmp    8010610e <alltraps>

80106a48 <vector105>:
.globl vector105
vector105:
  pushl $0
80106a48:	6a 00                	push   $0x0
  pushl $105
80106a4a:	6a 69                	push   $0x69
  jmp alltraps
80106a4c:	e9 bd f6 ff ff       	jmp    8010610e <alltraps>

80106a51 <vector106>:
.globl vector106
vector106:
  pushl $0
80106a51:	6a 00                	push   $0x0
  pushl $106
80106a53:	6a 6a                	push   $0x6a
  jmp alltraps
80106a55:	e9 b4 f6 ff ff       	jmp    8010610e <alltraps>

80106a5a <vector107>:
.globl vector107
vector107:
  pushl $0
80106a5a:	6a 00                	push   $0x0
  pushl $107
80106a5c:	6a 6b                	push   $0x6b
  jmp alltraps
80106a5e:	e9 ab f6 ff ff       	jmp    8010610e <alltraps>

80106a63 <vector108>:
.globl vector108
vector108:
  pushl $0
80106a63:	6a 00                	push   $0x0
  pushl $108
80106a65:	6a 6c                	push   $0x6c
  jmp alltraps
80106a67:	e9 a2 f6 ff ff       	jmp    8010610e <alltraps>

80106a6c <vector109>:
.globl vector109
vector109:
  pushl $0
80106a6c:	6a 00                	push   $0x0
  pushl $109
80106a6e:	6a 6d                	push   $0x6d
  jmp alltraps
80106a70:	e9 99 f6 ff ff       	jmp    8010610e <alltraps>

80106a75 <vector110>:
.globl vector110
vector110:
  pushl $0
80106a75:	6a 00                	push   $0x0
  pushl $110
80106a77:	6a 6e                	push   $0x6e
  jmp alltraps
80106a79:	e9 90 f6 ff ff       	jmp    8010610e <alltraps>

80106a7e <vector111>:
.globl vector111
vector111:
  pushl $0
80106a7e:	6a 00                	push   $0x0
  pushl $111
80106a80:	6a 6f                	push   $0x6f
  jmp alltraps
80106a82:	e9 87 f6 ff ff       	jmp    8010610e <alltraps>

80106a87 <vector112>:
.globl vector112
vector112:
  pushl $0
80106a87:	6a 00                	push   $0x0
  pushl $112
80106a89:	6a 70                	push   $0x70
  jmp alltraps
80106a8b:	e9 7e f6 ff ff       	jmp    8010610e <alltraps>

80106a90 <vector113>:
.globl vector113
vector113:
  pushl $0
80106a90:	6a 00                	push   $0x0
  pushl $113
80106a92:	6a 71                	push   $0x71
  jmp alltraps
80106a94:	e9 75 f6 ff ff       	jmp    8010610e <alltraps>

80106a99 <vector114>:
.globl vector114
vector114:
  pushl $0
80106a99:	6a 00                	push   $0x0
  pushl $114
80106a9b:	6a 72                	push   $0x72
  jmp alltraps
80106a9d:	e9 6c f6 ff ff       	jmp    8010610e <alltraps>

80106aa2 <vector115>:
.globl vector115
vector115:
  pushl $0
80106aa2:	6a 00                	push   $0x0
  pushl $115
80106aa4:	6a 73                	push   $0x73
  jmp alltraps
80106aa6:	e9 63 f6 ff ff       	jmp    8010610e <alltraps>

80106aab <vector116>:
.globl vector116
vector116:
  pushl $0
80106aab:	6a 00                	push   $0x0
  pushl $116
80106aad:	6a 74                	push   $0x74
  jmp alltraps
80106aaf:	e9 5a f6 ff ff       	jmp    8010610e <alltraps>

80106ab4 <vector117>:
.globl vector117
vector117:
  pushl $0
80106ab4:	6a 00                	push   $0x0
  pushl $117
80106ab6:	6a 75                	push   $0x75
  jmp alltraps
80106ab8:	e9 51 f6 ff ff       	jmp    8010610e <alltraps>

80106abd <vector118>:
.globl vector118
vector118:
  pushl $0
80106abd:	6a 00                	push   $0x0
  pushl $118
80106abf:	6a 76                	push   $0x76
  jmp alltraps
80106ac1:	e9 48 f6 ff ff       	jmp    8010610e <alltraps>

80106ac6 <vector119>:
.globl vector119
vector119:
  pushl $0
80106ac6:	6a 00                	push   $0x0
  pushl $119
80106ac8:	6a 77                	push   $0x77
  jmp alltraps
80106aca:	e9 3f f6 ff ff       	jmp    8010610e <alltraps>

80106acf <vector120>:
.globl vector120
vector120:
  pushl $0
80106acf:	6a 00                	push   $0x0
  pushl $120
80106ad1:	6a 78                	push   $0x78
  jmp alltraps
80106ad3:	e9 36 f6 ff ff       	jmp    8010610e <alltraps>

80106ad8 <vector121>:
.globl vector121
vector121:
  pushl $0
80106ad8:	6a 00                	push   $0x0
  pushl $121
80106ada:	6a 79                	push   $0x79
  jmp alltraps
80106adc:	e9 2d f6 ff ff       	jmp    8010610e <alltraps>

80106ae1 <vector122>:
.globl vector122
vector122:
  pushl $0
80106ae1:	6a 00                	push   $0x0
  pushl $122
80106ae3:	6a 7a                	push   $0x7a
  jmp alltraps
80106ae5:	e9 24 f6 ff ff       	jmp    8010610e <alltraps>

80106aea <vector123>:
.globl vector123
vector123:
  pushl $0
80106aea:	6a 00                	push   $0x0
  pushl $123
80106aec:	6a 7b                	push   $0x7b
  jmp alltraps
80106aee:	e9 1b f6 ff ff       	jmp    8010610e <alltraps>

80106af3 <vector124>:
.globl vector124
vector124:
  pushl $0
80106af3:	6a 00                	push   $0x0
  pushl $124
80106af5:	6a 7c                	push   $0x7c
  jmp alltraps
80106af7:	e9 12 f6 ff ff       	jmp    8010610e <alltraps>

80106afc <vector125>:
.globl vector125
vector125:
  pushl $0
80106afc:	6a 00                	push   $0x0
  pushl $125
80106afe:	6a 7d                	push   $0x7d
  jmp alltraps
80106b00:	e9 09 f6 ff ff       	jmp    8010610e <alltraps>

80106b05 <vector126>:
.globl vector126
vector126:
  pushl $0
80106b05:	6a 00                	push   $0x0
  pushl $126
80106b07:	6a 7e                	push   $0x7e
  jmp alltraps
80106b09:	e9 00 f6 ff ff       	jmp    8010610e <alltraps>

80106b0e <vector127>:
.globl vector127
vector127:
  pushl $0
80106b0e:	6a 00                	push   $0x0
  pushl $127
80106b10:	6a 7f                	push   $0x7f
  jmp alltraps
80106b12:	e9 f7 f5 ff ff       	jmp    8010610e <alltraps>

80106b17 <vector128>:
.globl vector128
vector128:
  pushl $0
80106b17:	6a 00                	push   $0x0
  pushl $128
80106b19:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106b1e:	e9 eb f5 ff ff       	jmp    8010610e <alltraps>

80106b23 <vector129>:
.globl vector129
vector129:
  pushl $0
80106b23:	6a 00                	push   $0x0
  pushl $129
80106b25:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106b2a:	e9 df f5 ff ff       	jmp    8010610e <alltraps>

80106b2f <vector130>:
.globl vector130
vector130:
  pushl $0
80106b2f:	6a 00                	push   $0x0
  pushl $130
80106b31:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106b36:	e9 d3 f5 ff ff       	jmp    8010610e <alltraps>

80106b3b <vector131>:
.globl vector131
vector131:
  pushl $0
80106b3b:	6a 00                	push   $0x0
  pushl $131
80106b3d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106b42:	e9 c7 f5 ff ff       	jmp    8010610e <alltraps>

80106b47 <vector132>:
.globl vector132
vector132:
  pushl $0
80106b47:	6a 00                	push   $0x0
  pushl $132
80106b49:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106b4e:	e9 bb f5 ff ff       	jmp    8010610e <alltraps>

80106b53 <vector133>:
.globl vector133
vector133:
  pushl $0
80106b53:	6a 00                	push   $0x0
  pushl $133
80106b55:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106b5a:	e9 af f5 ff ff       	jmp    8010610e <alltraps>

80106b5f <vector134>:
.globl vector134
vector134:
  pushl $0
80106b5f:	6a 00                	push   $0x0
  pushl $134
80106b61:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106b66:	e9 a3 f5 ff ff       	jmp    8010610e <alltraps>

80106b6b <vector135>:
.globl vector135
vector135:
  pushl $0
80106b6b:	6a 00                	push   $0x0
  pushl $135
80106b6d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106b72:	e9 97 f5 ff ff       	jmp    8010610e <alltraps>

80106b77 <vector136>:
.globl vector136
vector136:
  pushl $0
80106b77:	6a 00                	push   $0x0
  pushl $136
80106b79:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106b7e:	e9 8b f5 ff ff       	jmp    8010610e <alltraps>

80106b83 <vector137>:
.globl vector137
vector137:
  pushl $0
80106b83:	6a 00                	push   $0x0
  pushl $137
80106b85:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106b8a:	e9 7f f5 ff ff       	jmp    8010610e <alltraps>

80106b8f <vector138>:
.globl vector138
vector138:
  pushl $0
80106b8f:	6a 00                	push   $0x0
  pushl $138
80106b91:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106b96:	e9 73 f5 ff ff       	jmp    8010610e <alltraps>

80106b9b <vector139>:
.globl vector139
vector139:
  pushl $0
80106b9b:	6a 00                	push   $0x0
  pushl $139
80106b9d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106ba2:	e9 67 f5 ff ff       	jmp    8010610e <alltraps>

80106ba7 <vector140>:
.globl vector140
vector140:
  pushl $0
80106ba7:	6a 00                	push   $0x0
  pushl $140
80106ba9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106bae:	e9 5b f5 ff ff       	jmp    8010610e <alltraps>

80106bb3 <vector141>:
.globl vector141
vector141:
  pushl $0
80106bb3:	6a 00                	push   $0x0
  pushl $141
80106bb5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106bba:	e9 4f f5 ff ff       	jmp    8010610e <alltraps>

80106bbf <vector142>:
.globl vector142
vector142:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $142
80106bc1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106bc6:	e9 43 f5 ff ff       	jmp    8010610e <alltraps>

80106bcb <vector143>:
.globl vector143
vector143:
  pushl $0
80106bcb:	6a 00                	push   $0x0
  pushl $143
80106bcd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106bd2:	e9 37 f5 ff ff       	jmp    8010610e <alltraps>

80106bd7 <vector144>:
.globl vector144
vector144:
  pushl $0
80106bd7:	6a 00                	push   $0x0
  pushl $144
80106bd9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106bde:	e9 2b f5 ff ff       	jmp    8010610e <alltraps>

80106be3 <vector145>:
.globl vector145
vector145:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $145
80106be5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106bea:	e9 1f f5 ff ff       	jmp    8010610e <alltraps>

80106bef <vector146>:
.globl vector146
vector146:
  pushl $0
80106bef:	6a 00                	push   $0x0
  pushl $146
80106bf1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106bf6:	e9 13 f5 ff ff       	jmp    8010610e <alltraps>

80106bfb <vector147>:
.globl vector147
vector147:
  pushl $0
80106bfb:	6a 00                	push   $0x0
  pushl $147
80106bfd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106c02:	e9 07 f5 ff ff       	jmp    8010610e <alltraps>

80106c07 <vector148>:
.globl vector148
vector148:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $148
80106c09:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106c0e:	e9 fb f4 ff ff       	jmp    8010610e <alltraps>

80106c13 <vector149>:
.globl vector149
vector149:
  pushl $0
80106c13:	6a 00                	push   $0x0
  pushl $149
80106c15:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106c1a:	e9 ef f4 ff ff       	jmp    8010610e <alltraps>

80106c1f <vector150>:
.globl vector150
vector150:
  pushl $0
80106c1f:	6a 00                	push   $0x0
  pushl $150
80106c21:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106c26:	e9 e3 f4 ff ff       	jmp    8010610e <alltraps>

80106c2b <vector151>:
.globl vector151
vector151:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $151
80106c2d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106c32:	e9 d7 f4 ff ff       	jmp    8010610e <alltraps>

80106c37 <vector152>:
.globl vector152
vector152:
  pushl $0
80106c37:	6a 00                	push   $0x0
  pushl $152
80106c39:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106c3e:	e9 cb f4 ff ff       	jmp    8010610e <alltraps>

80106c43 <vector153>:
.globl vector153
vector153:
  pushl $0
80106c43:	6a 00                	push   $0x0
  pushl $153
80106c45:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106c4a:	e9 bf f4 ff ff       	jmp    8010610e <alltraps>

80106c4f <vector154>:
.globl vector154
vector154:
  pushl $0
80106c4f:	6a 00                	push   $0x0
  pushl $154
80106c51:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106c56:	e9 b3 f4 ff ff       	jmp    8010610e <alltraps>

80106c5b <vector155>:
.globl vector155
vector155:
  pushl $0
80106c5b:	6a 00                	push   $0x0
  pushl $155
80106c5d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106c62:	e9 a7 f4 ff ff       	jmp    8010610e <alltraps>

80106c67 <vector156>:
.globl vector156
vector156:
  pushl $0
80106c67:	6a 00                	push   $0x0
  pushl $156
80106c69:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106c6e:	e9 9b f4 ff ff       	jmp    8010610e <alltraps>

80106c73 <vector157>:
.globl vector157
vector157:
  pushl $0
80106c73:	6a 00                	push   $0x0
  pushl $157
80106c75:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106c7a:	e9 8f f4 ff ff       	jmp    8010610e <alltraps>

80106c7f <vector158>:
.globl vector158
vector158:
  pushl $0
80106c7f:	6a 00                	push   $0x0
  pushl $158
80106c81:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106c86:	e9 83 f4 ff ff       	jmp    8010610e <alltraps>

80106c8b <vector159>:
.globl vector159
vector159:
  pushl $0
80106c8b:	6a 00                	push   $0x0
  pushl $159
80106c8d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106c92:	e9 77 f4 ff ff       	jmp    8010610e <alltraps>

80106c97 <vector160>:
.globl vector160
vector160:
  pushl $0
80106c97:	6a 00                	push   $0x0
  pushl $160
80106c99:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106c9e:	e9 6b f4 ff ff       	jmp    8010610e <alltraps>

80106ca3 <vector161>:
.globl vector161
vector161:
  pushl $0
80106ca3:	6a 00                	push   $0x0
  pushl $161
80106ca5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106caa:	e9 5f f4 ff ff       	jmp    8010610e <alltraps>

80106caf <vector162>:
.globl vector162
vector162:
  pushl $0
80106caf:	6a 00                	push   $0x0
  pushl $162
80106cb1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106cb6:	e9 53 f4 ff ff       	jmp    8010610e <alltraps>

80106cbb <vector163>:
.globl vector163
vector163:
  pushl $0
80106cbb:	6a 00                	push   $0x0
  pushl $163
80106cbd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106cc2:	e9 47 f4 ff ff       	jmp    8010610e <alltraps>

80106cc7 <vector164>:
.globl vector164
vector164:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $164
80106cc9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106cce:	e9 3b f4 ff ff       	jmp    8010610e <alltraps>

80106cd3 <vector165>:
.globl vector165
vector165:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $165
80106cd5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106cda:	e9 2f f4 ff ff       	jmp    8010610e <alltraps>

80106cdf <vector166>:
.globl vector166
vector166:
  pushl $0
80106cdf:	6a 00                	push   $0x0
  pushl $166
80106ce1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106ce6:	e9 23 f4 ff ff       	jmp    8010610e <alltraps>

80106ceb <vector167>:
.globl vector167
vector167:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $167
80106ced:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106cf2:	e9 17 f4 ff ff       	jmp    8010610e <alltraps>

80106cf7 <vector168>:
.globl vector168
vector168:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $168
80106cf9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106cfe:	e9 0b f4 ff ff       	jmp    8010610e <alltraps>

80106d03 <vector169>:
.globl vector169
vector169:
  pushl $0
80106d03:	6a 00                	push   $0x0
  pushl $169
80106d05:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106d0a:	e9 ff f3 ff ff       	jmp    8010610e <alltraps>

80106d0f <vector170>:
.globl vector170
vector170:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $170
80106d11:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106d16:	e9 f3 f3 ff ff       	jmp    8010610e <alltraps>

80106d1b <vector171>:
.globl vector171
vector171:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $171
80106d1d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106d22:	e9 e7 f3 ff ff       	jmp    8010610e <alltraps>

80106d27 <vector172>:
.globl vector172
vector172:
  pushl $0
80106d27:	6a 00                	push   $0x0
  pushl $172
80106d29:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106d2e:	e9 db f3 ff ff       	jmp    8010610e <alltraps>

80106d33 <vector173>:
.globl vector173
vector173:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $173
80106d35:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106d3a:	e9 cf f3 ff ff       	jmp    8010610e <alltraps>

80106d3f <vector174>:
.globl vector174
vector174:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $174
80106d41:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106d46:	e9 c3 f3 ff ff       	jmp    8010610e <alltraps>

80106d4b <vector175>:
.globl vector175
vector175:
  pushl $0
80106d4b:	6a 00                	push   $0x0
  pushl $175
80106d4d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106d52:	e9 b7 f3 ff ff       	jmp    8010610e <alltraps>

80106d57 <vector176>:
.globl vector176
vector176:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $176
80106d59:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106d5e:	e9 ab f3 ff ff       	jmp    8010610e <alltraps>

80106d63 <vector177>:
.globl vector177
vector177:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $177
80106d65:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106d6a:	e9 9f f3 ff ff       	jmp    8010610e <alltraps>

80106d6f <vector178>:
.globl vector178
vector178:
  pushl $0
80106d6f:	6a 00                	push   $0x0
  pushl $178
80106d71:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106d76:	e9 93 f3 ff ff       	jmp    8010610e <alltraps>

80106d7b <vector179>:
.globl vector179
vector179:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $179
80106d7d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106d82:	e9 87 f3 ff ff       	jmp    8010610e <alltraps>

80106d87 <vector180>:
.globl vector180
vector180:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $180
80106d89:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106d8e:	e9 7b f3 ff ff       	jmp    8010610e <alltraps>

80106d93 <vector181>:
.globl vector181
vector181:
  pushl $0
80106d93:	6a 00                	push   $0x0
  pushl $181
80106d95:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106d9a:	e9 6f f3 ff ff       	jmp    8010610e <alltraps>

80106d9f <vector182>:
.globl vector182
vector182:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $182
80106da1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106da6:	e9 63 f3 ff ff       	jmp    8010610e <alltraps>

80106dab <vector183>:
.globl vector183
vector183:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $183
80106dad:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106db2:	e9 57 f3 ff ff       	jmp    8010610e <alltraps>

80106db7 <vector184>:
.globl vector184
vector184:
  pushl $0
80106db7:	6a 00                	push   $0x0
  pushl $184
80106db9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106dbe:	e9 4b f3 ff ff       	jmp    8010610e <alltraps>

80106dc3 <vector185>:
.globl vector185
vector185:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $185
80106dc5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106dca:	e9 3f f3 ff ff       	jmp    8010610e <alltraps>

80106dcf <vector186>:
.globl vector186
vector186:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $186
80106dd1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106dd6:	e9 33 f3 ff ff       	jmp    8010610e <alltraps>

80106ddb <vector187>:
.globl vector187
vector187:
  pushl $0
80106ddb:	6a 00                	push   $0x0
  pushl $187
80106ddd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106de2:	e9 27 f3 ff ff       	jmp    8010610e <alltraps>

80106de7 <vector188>:
.globl vector188
vector188:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $188
80106de9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106dee:	e9 1b f3 ff ff       	jmp    8010610e <alltraps>

80106df3 <vector189>:
.globl vector189
vector189:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $189
80106df5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106dfa:	e9 0f f3 ff ff       	jmp    8010610e <alltraps>

80106dff <vector190>:
.globl vector190
vector190:
  pushl $0
80106dff:	6a 00                	push   $0x0
  pushl $190
80106e01:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106e06:	e9 03 f3 ff ff       	jmp    8010610e <alltraps>

80106e0b <vector191>:
.globl vector191
vector191:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $191
80106e0d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106e12:	e9 f7 f2 ff ff       	jmp    8010610e <alltraps>

80106e17 <vector192>:
.globl vector192
vector192:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $192
80106e19:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106e1e:	e9 eb f2 ff ff       	jmp    8010610e <alltraps>

80106e23 <vector193>:
.globl vector193
vector193:
  pushl $0
80106e23:	6a 00                	push   $0x0
  pushl $193
80106e25:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106e2a:	e9 df f2 ff ff       	jmp    8010610e <alltraps>

80106e2f <vector194>:
.globl vector194
vector194:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $194
80106e31:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106e36:	e9 d3 f2 ff ff       	jmp    8010610e <alltraps>

80106e3b <vector195>:
.globl vector195
vector195:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $195
80106e3d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106e42:	e9 c7 f2 ff ff       	jmp    8010610e <alltraps>

80106e47 <vector196>:
.globl vector196
vector196:
  pushl $0
80106e47:	6a 00                	push   $0x0
  pushl $196
80106e49:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106e4e:	e9 bb f2 ff ff       	jmp    8010610e <alltraps>

80106e53 <vector197>:
.globl vector197
vector197:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $197
80106e55:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106e5a:	e9 af f2 ff ff       	jmp    8010610e <alltraps>

80106e5f <vector198>:
.globl vector198
vector198:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $198
80106e61:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106e66:	e9 a3 f2 ff ff       	jmp    8010610e <alltraps>

80106e6b <vector199>:
.globl vector199
vector199:
  pushl $0
80106e6b:	6a 00                	push   $0x0
  pushl $199
80106e6d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106e72:	e9 97 f2 ff ff       	jmp    8010610e <alltraps>

80106e77 <vector200>:
.globl vector200
vector200:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $200
80106e79:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106e7e:	e9 8b f2 ff ff       	jmp    8010610e <alltraps>

80106e83 <vector201>:
.globl vector201
vector201:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $201
80106e85:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106e8a:	e9 7f f2 ff ff       	jmp    8010610e <alltraps>

80106e8f <vector202>:
.globl vector202
vector202:
  pushl $0
80106e8f:	6a 00                	push   $0x0
  pushl $202
80106e91:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106e96:	e9 73 f2 ff ff       	jmp    8010610e <alltraps>

80106e9b <vector203>:
.globl vector203
vector203:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $203
80106e9d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106ea2:	e9 67 f2 ff ff       	jmp    8010610e <alltraps>

80106ea7 <vector204>:
.globl vector204
vector204:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $204
80106ea9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106eae:	e9 5b f2 ff ff       	jmp    8010610e <alltraps>

80106eb3 <vector205>:
.globl vector205
vector205:
  pushl $0
80106eb3:	6a 00                	push   $0x0
  pushl $205
80106eb5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106eba:	e9 4f f2 ff ff       	jmp    8010610e <alltraps>

80106ebf <vector206>:
.globl vector206
vector206:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $206
80106ec1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106ec6:	e9 43 f2 ff ff       	jmp    8010610e <alltraps>

80106ecb <vector207>:
.globl vector207
vector207:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $207
80106ecd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106ed2:	e9 37 f2 ff ff       	jmp    8010610e <alltraps>

80106ed7 <vector208>:
.globl vector208
vector208:
  pushl $0
80106ed7:	6a 00                	push   $0x0
  pushl $208
80106ed9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106ede:	e9 2b f2 ff ff       	jmp    8010610e <alltraps>

80106ee3 <vector209>:
.globl vector209
vector209:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $209
80106ee5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106eea:	e9 1f f2 ff ff       	jmp    8010610e <alltraps>

80106eef <vector210>:
.globl vector210
vector210:
  pushl $0
80106eef:	6a 00                	push   $0x0
  pushl $210
80106ef1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106ef6:	e9 13 f2 ff ff       	jmp    8010610e <alltraps>

80106efb <vector211>:
.globl vector211
vector211:
  pushl $0
80106efb:	6a 00                	push   $0x0
  pushl $211
80106efd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106f02:	e9 07 f2 ff ff       	jmp    8010610e <alltraps>

80106f07 <vector212>:
.globl vector212
vector212:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $212
80106f09:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106f0e:	e9 fb f1 ff ff       	jmp    8010610e <alltraps>

80106f13 <vector213>:
.globl vector213
vector213:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $213
80106f15:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106f1a:	e9 ef f1 ff ff       	jmp    8010610e <alltraps>

80106f1f <vector214>:
.globl vector214
vector214:
  pushl $0
80106f1f:	6a 00                	push   $0x0
  pushl $214
80106f21:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106f26:	e9 e3 f1 ff ff       	jmp    8010610e <alltraps>

80106f2b <vector215>:
.globl vector215
vector215:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $215
80106f2d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106f32:	e9 d7 f1 ff ff       	jmp    8010610e <alltraps>

80106f37 <vector216>:
.globl vector216
vector216:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $216
80106f39:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106f3e:	e9 cb f1 ff ff       	jmp    8010610e <alltraps>

80106f43 <vector217>:
.globl vector217
vector217:
  pushl $0
80106f43:	6a 00                	push   $0x0
  pushl $217
80106f45:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106f4a:	e9 bf f1 ff ff       	jmp    8010610e <alltraps>

80106f4f <vector218>:
.globl vector218
vector218:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $218
80106f51:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106f56:	e9 b3 f1 ff ff       	jmp    8010610e <alltraps>

80106f5b <vector219>:
.globl vector219
vector219:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $219
80106f5d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106f62:	e9 a7 f1 ff ff       	jmp    8010610e <alltraps>

80106f67 <vector220>:
.globl vector220
vector220:
  pushl $0
80106f67:	6a 00                	push   $0x0
  pushl $220
80106f69:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106f6e:	e9 9b f1 ff ff       	jmp    8010610e <alltraps>

80106f73 <vector221>:
.globl vector221
vector221:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $221
80106f75:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106f7a:	e9 8f f1 ff ff       	jmp    8010610e <alltraps>

80106f7f <vector222>:
.globl vector222
vector222:
  pushl $0
80106f7f:	6a 00                	push   $0x0
  pushl $222
80106f81:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106f86:	e9 83 f1 ff ff       	jmp    8010610e <alltraps>

80106f8b <vector223>:
.globl vector223
vector223:
  pushl $0
80106f8b:	6a 00                	push   $0x0
  pushl $223
80106f8d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106f92:	e9 77 f1 ff ff       	jmp    8010610e <alltraps>

80106f97 <vector224>:
.globl vector224
vector224:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $224
80106f99:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106f9e:	e9 6b f1 ff ff       	jmp    8010610e <alltraps>

80106fa3 <vector225>:
.globl vector225
vector225:
  pushl $0
80106fa3:	6a 00                	push   $0x0
  pushl $225
80106fa5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106faa:	e9 5f f1 ff ff       	jmp    8010610e <alltraps>

80106faf <vector226>:
.globl vector226
vector226:
  pushl $0
80106faf:	6a 00                	push   $0x0
  pushl $226
80106fb1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106fb6:	e9 53 f1 ff ff       	jmp    8010610e <alltraps>

80106fbb <vector227>:
.globl vector227
vector227:
  pushl $0
80106fbb:	6a 00                	push   $0x0
  pushl $227
80106fbd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106fc2:	e9 47 f1 ff ff       	jmp    8010610e <alltraps>

80106fc7 <vector228>:
.globl vector228
vector228:
  pushl $0
80106fc7:	6a 00                	push   $0x0
  pushl $228
80106fc9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106fce:	e9 3b f1 ff ff       	jmp    8010610e <alltraps>

80106fd3 <vector229>:
.globl vector229
vector229:
  pushl $0
80106fd3:	6a 00                	push   $0x0
  pushl $229
80106fd5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106fda:	e9 2f f1 ff ff       	jmp    8010610e <alltraps>

80106fdf <vector230>:
.globl vector230
vector230:
  pushl $0
80106fdf:	6a 00                	push   $0x0
  pushl $230
80106fe1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106fe6:	e9 23 f1 ff ff       	jmp    8010610e <alltraps>

80106feb <vector231>:
.globl vector231
vector231:
  pushl $0
80106feb:	6a 00                	push   $0x0
  pushl $231
80106fed:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106ff2:	e9 17 f1 ff ff       	jmp    8010610e <alltraps>

80106ff7 <vector232>:
.globl vector232
vector232:
  pushl $0
80106ff7:	6a 00                	push   $0x0
  pushl $232
80106ff9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106ffe:	e9 0b f1 ff ff       	jmp    8010610e <alltraps>

80107003 <vector233>:
.globl vector233
vector233:
  pushl $0
80107003:	6a 00                	push   $0x0
  pushl $233
80107005:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010700a:	e9 ff f0 ff ff       	jmp    8010610e <alltraps>

8010700f <vector234>:
.globl vector234
vector234:
  pushl $0
8010700f:	6a 00                	push   $0x0
  pushl $234
80107011:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107016:	e9 f3 f0 ff ff       	jmp    8010610e <alltraps>

8010701b <vector235>:
.globl vector235
vector235:
  pushl $0
8010701b:	6a 00                	push   $0x0
  pushl $235
8010701d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107022:	e9 e7 f0 ff ff       	jmp    8010610e <alltraps>

80107027 <vector236>:
.globl vector236
vector236:
  pushl $0
80107027:	6a 00                	push   $0x0
  pushl $236
80107029:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010702e:	e9 db f0 ff ff       	jmp    8010610e <alltraps>

80107033 <vector237>:
.globl vector237
vector237:
  pushl $0
80107033:	6a 00                	push   $0x0
  pushl $237
80107035:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010703a:	e9 cf f0 ff ff       	jmp    8010610e <alltraps>

8010703f <vector238>:
.globl vector238
vector238:
  pushl $0
8010703f:	6a 00                	push   $0x0
  pushl $238
80107041:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107046:	e9 c3 f0 ff ff       	jmp    8010610e <alltraps>

8010704b <vector239>:
.globl vector239
vector239:
  pushl $0
8010704b:	6a 00                	push   $0x0
  pushl $239
8010704d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107052:	e9 b7 f0 ff ff       	jmp    8010610e <alltraps>

80107057 <vector240>:
.globl vector240
vector240:
  pushl $0
80107057:	6a 00                	push   $0x0
  pushl $240
80107059:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010705e:	e9 ab f0 ff ff       	jmp    8010610e <alltraps>

80107063 <vector241>:
.globl vector241
vector241:
  pushl $0
80107063:	6a 00                	push   $0x0
  pushl $241
80107065:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010706a:	e9 9f f0 ff ff       	jmp    8010610e <alltraps>

8010706f <vector242>:
.globl vector242
vector242:
  pushl $0
8010706f:	6a 00                	push   $0x0
  pushl $242
80107071:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107076:	e9 93 f0 ff ff       	jmp    8010610e <alltraps>

8010707b <vector243>:
.globl vector243
vector243:
  pushl $0
8010707b:	6a 00                	push   $0x0
  pushl $243
8010707d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107082:	e9 87 f0 ff ff       	jmp    8010610e <alltraps>

80107087 <vector244>:
.globl vector244
vector244:
  pushl $0
80107087:	6a 00                	push   $0x0
  pushl $244
80107089:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010708e:	e9 7b f0 ff ff       	jmp    8010610e <alltraps>

80107093 <vector245>:
.globl vector245
vector245:
  pushl $0
80107093:	6a 00                	push   $0x0
  pushl $245
80107095:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010709a:	e9 6f f0 ff ff       	jmp    8010610e <alltraps>

8010709f <vector246>:
.globl vector246
vector246:
  pushl $0
8010709f:	6a 00                	push   $0x0
  pushl $246
801070a1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801070a6:	e9 63 f0 ff ff       	jmp    8010610e <alltraps>

801070ab <vector247>:
.globl vector247
vector247:
  pushl $0
801070ab:	6a 00                	push   $0x0
  pushl $247
801070ad:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801070b2:	e9 57 f0 ff ff       	jmp    8010610e <alltraps>

801070b7 <vector248>:
.globl vector248
vector248:
  pushl $0
801070b7:	6a 00                	push   $0x0
  pushl $248
801070b9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801070be:	e9 4b f0 ff ff       	jmp    8010610e <alltraps>

801070c3 <vector249>:
.globl vector249
vector249:
  pushl $0
801070c3:	6a 00                	push   $0x0
  pushl $249
801070c5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801070ca:	e9 3f f0 ff ff       	jmp    8010610e <alltraps>

801070cf <vector250>:
.globl vector250
vector250:
  pushl $0
801070cf:	6a 00                	push   $0x0
  pushl $250
801070d1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801070d6:	e9 33 f0 ff ff       	jmp    8010610e <alltraps>

801070db <vector251>:
.globl vector251
vector251:
  pushl $0
801070db:	6a 00                	push   $0x0
  pushl $251
801070dd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801070e2:	e9 27 f0 ff ff       	jmp    8010610e <alltraps>

801070e7 <vector252>:
.globl vector252
vector252:
  pushl $0
801070e7:	6a 00                	push   $0x0
  pushl $252
801070e9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801070ee:	e9 1b f0 ff ff       	jmp    8010610e <alltraps>

801070f3 <vector253>:
.globl vector253
vector253:
  pushl $0
801070f3:	6a 00                	push   $0x0
  pushl $253
801070f5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801070fa:	e9 0f f0 ff ff       	jmp    8010610e <alltraps>

801070ff <vector254>:
.globl vector254
vector254:
  pushl $0
801070ff:	6a 00                	push   $0x0
  pushl $254
80107101:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107106:	e9 03 f0 ff ff       	jmp    8010610e <alltraps>

8010710b <vector255>:
.globl vector255
vector255:
  pushl $0
8010710b:	6a 00                	push   $0x0
  pushl $255
8010710d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107112:	e9 f7 ef ff ff       	jmp    8010610e <alltraps>
80107117:	66 90                	xchg   %ax,%ax
80107119:	66 90                	xchg   %ax,%ax
8010711b:	66 90                	xchg   %ax,%ax
8010711d:	66 90                	xchg   %ax,%ax
8010711f:	90                   	nop

80107120 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107120:	55                   	push   %ebp
80107121:	89 e5                	mov    %esp,%ebp
80107123:	57                   	push   %edi
80107124:	56                   	push   %esi
80107125:	53                   	push   %ebx
80107126:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107128:	c1 ea 16             	shr    $0x16,%edx
8010712b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010712e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80107131:	8b 07                	mov    (%edi),%eax
80107133:	a8 01                	test   $0x1,%al
80107135:	74 29                	je     80107160 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107137:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010713c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = (V2P(pgtab) | PTE_P | PTE_W | PTE_U) & ~PTE_WS;
  }
  return &pgtab[PTX(va)];
}
80107142:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = (V2P(pgtab) | PTE_P | PTE_W | PTE_U) & ~PTE_WS;
  }
  return &pgtab[PTX(va)];
80107145:	c1 eb 0a             	shr    $0xa,%ebx
80107148:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
8010714e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80107151:	5b                   	pop    %ebx
80107152:	5e                   	pop    %esi
80107153:	5f                   	pop    %edi
80107154:	5d                   	pop    %ebp
80107155:	c3                   	ret    
80107156:	8d 76 00             	lea    0x0(%esi),%esi
80107159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else { // not presented
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107160:	85 c9                	test   %ecx,%ecx
80107162:	74 34                	je     80107198 <walkpgdir+0x78>
80107164:	e8 87 b3 ff ff       	call   801024f0 <kalloc>
80107169:	85 c0                	test   %eax,%eax
8010716b:	89 c6                	mov    %eax,%esi
8010716d:	74 29                	je     80107198 <walkpgdir+0x78>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010716f:	83 ec 04             	sub    $0x4,%esp
80107172:	68 00 10 00 00       	push   $0x1000
80107177:	6a 00                	push   $0x0
80107179:	50                   	push   %eax
8010717a:	e8 b1 db ff ff       	call   80104d30 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = (V2P(pgtab) | PTE_P | PTE_W | PTE_U) & ~PTE_WS;
8010717f:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107185:	83 c4 10             	add    $0x10,%esp
80107188:	25 f8 fe ff ff       	and    $0xfffffef8,%eax
8010718d:	83 c8 07             	or     $0x7,%eax
80107190:	89 07                	mov    %eax,(%edi)
80107192:	eb ae                	jmp    80107142 <walkpgdir+0x22>
80107194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  return &pgtab[PTX(va)];
}
80107198:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else { // not presented
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
8010719b:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = (V2P(pgtab) | PTE_P | PTE_W | PTE_U) & ~PTE_WS;
  }
  return &pgtab[PTX(va)];
}
8010719d:	5b                   	pop    %ebx
8010719e:	5e                   	pop    %esi
8010719f:	5f                   	pop    %edi
801071a0:	5d                   	pop    %ebp
801071a1:	c3                   	ret    
801071a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801071b0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801071b0:	55                   	push   %ebp
801071b1:	89 e5                	mov    %esp,%ebp
801071b3:	57                   	push   %edi
801071b4:	56                   	push   %esi
801071b5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801071b6:	89 d3                	mov    %edx,%ebx
801071b8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801071be:	83 ec 1c             	sub    $0x1c,%esp
801071c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801071c4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801071c8:	8b 7d 08             	mov    0x8(%ebp),%edi
801071cb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801071d0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801071d3:	8b 45 0c             	mov    0xc(%ebp),%eax
801071d6:	29 df                	sub    %ebx,%edi
801071d8:	83 c8 01             	or     $0x1,%eax
801071db:	89 45 dc             	mov    %eax,-0x24(%ebp)
801071de:	eb 15                	jmp    801071f5 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
801071e0:	f6 00 01             	testb  $0x1,(%eax)
801071e3:	75 45                	jne    8010722a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
801071e5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
801071e8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801071eb:	89 30                	mov    %esi,(%eax)
    if(a == last)
801071ed:	74 31                	je     80107220 <mappages+0x70>
      break;
    a += PGSIZE;
801071ef:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801071f5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801071f8:	b9 01 00 00 00       	mov    $0x1,%ecx
801071fd:	89 da                	mov    %ebx,%edx
801071ff:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80107202:	e8 19 ff ff ff       	call   80107120 <walkpgdir>
80107207:	85 c0                	test   %eax,%eax
80107209:	75 d5                	jne    801071e0 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
8010720b:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
8010720e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80107213:	5b                   	pop    %ebx
80107214:	5e                   	pop    %esi
80107215:	5f                   	pop    %edi
80107216:	5d                   	pop    %ebp
80107217:	c3                   	ret    
80107218:	90                   	nop
80107219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107220:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107223:	31 c0                	xor    %eax,%eax
}
80107225:	5b                   	pop    %ebx
80107226:	5e                   	pop    %esi
80107227:	5f                   	pop    %edi
80107228:	5d                   	pop    %ebp
80107229:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
8010722a:	83 ec 0c             	sub    $0xc,%esp
8010722d:	68 2c 85 10 80       	push   $0x8010852c
80107232:	e8 19 91 ff ff       	call   80100350 <panic>
80107237:	89 f6                	mov    %esi,%esi
80107239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107240 <getSharedCounter>:
// counter for all proccesses pages possible
char sharedCounter[60 * 1024]; // 

char
getSharedCounter(int index)
{
80107240:	55                   	push   %ebp
80107241:	89 e5                	mov    %esp,%ebp
  return sharedCounter[index];  
80107243:	8b 45 08             	mov    0x8(%ebp),%eax
}
80107246:	5d                   	pop    %ebp
char sharedCounter[60 * 1024]; // 

char
getSharedCounter(int index)
{
  return sharedCounter[index];  
80107247:	0f b6 80 40 dc 11 80 	movzbl -0x7fee23c0(%eax),%eax
}
8010724e:	c3                   	ret    
8010724f:	90                   	nop

80107250 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107250:	55                   	push   %ebp
80107251:	89 e5                	mov    %esp,%ebp
80107253:	53                   	push   %ebx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107254:	31 db                	xor    %ebx,%ebx

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80107256:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80107259:	e8 f2 b4 ff ff       	call   80102750 <cpunum>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010725e:	8d 14 40             	lea    (%eax,%eax,2),%edx
80107261:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80107266:	c1 e2 06             	shl    $0x6,%edx
80107269:	8d 82 e0 22 11 80    	lea    -0x7feedd20(%edx),%eax
8010726f:	c6 82 5d 23 11 80 9a 	movb   $0x9a,-0x7feedca3(%edx)
80107276:	c6 82 5e 23 11 80 cf 	movb   $0xcf,-0x7feedca2(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010727d:	c6 82 65 23 11 80 92 	movb   $0x92,-0x7feedc9b(%edx)
80107284:	c6 82 66 23 11 80 cf 	movb   $0xcf,-0x7feedc9a(%edx)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010728b:	66 89 48 78          	mov    %cx,0x78(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010728f:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107294:	66 89 58 7a          	mov    %bx,0x7a(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107298:	66 89 88 80 00 00 00 	mov    %cx,0x80(%eax)
8010729f:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801072a1:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801072a6:	66 89 98 82 00 00 00 	mov    %bx,0x82(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801072ad:	66 89 88 90 00 00 00 	mov    %cx,0x90(%eax)
801072b4:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801072b6:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801072bb:	66 89 98 92 00 00 00 	mov    %bx,0x92(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801072c2:	31 db                	xor    %ebx,%ebx
801072c4:	66 89 88 98 00 00 00 	mov    %cx,0x98(%eax)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 12, 0);
801072cb:	8d 8a 94 23 11 80    	lea    -0x7feedc6c(%edx),%ecx
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801072d1:	66 89 98 9a 00 00 00 	mov    %bx,0x9a(%eax)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 12, 0);
801072d8:	31 db                	xor    %ebx,%ebx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801072da:	c6 82 75 23 11 80 fa 	movb   $0xfa,-0x7feedc8b(%edx)
801072e1:	c6 82 76 23 11 80 cf 	movb   $0xcf,-0x7feedc8a(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 12, 0);
801072e8:	66 89 98 88 00 00 00 	mov    %bx,0x88(%eax)
801072ef:	66 89 88 8a 00 00 00 	mov    %cx,0x8a(%eax)
801072f6:	89 cb                	mov    %ecx,%ebx
801072f8:	c1 e9 18             	shr    $0x18,%ecx
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801072fb:	c6 82 7d 23 11 80 f2 	movb   $0xf2,-0x7feedc83(%edx)
80107302:	c6 82 7e 23 11 80 cf 	movb   $0xcf,-0x7feedc82(%edx)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 12, 0);
80107309:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)
8010730f:	c6 82 6d 23 11 80 92 	movb   $0x92,-0x7feedc93(%edx)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80107316:	b9 37 00 00 00       	mov    $0x37,%ecx
8010731b:	c6 82 6e 23 11 80 c0 	movb   $0xc0,-0x7feedc92(%edx)

  lgdt(c->gdt, sizeof(c->gdt));
80107322:	81 c2 50 23 11 80    	add    $0x80112350,%edx
80107328:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 12, 0);
8010732c:	c1 eb 10             	shr    $0x10,%ebx
  pd[1] = (uint)p;
8010732f:	66 89 55 f4          	mov    %dx,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107333:	c1 ea 10             	shr    $0x10,%edx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107336:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
8010733a:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010733e:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
80107345:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010734c:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107353:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010735a:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107361:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 12, 0);
80107368:	88 98 8c 00 00 00    	mov    %bl,0x8c(%eax)
8010736e:	66 89 55 f6          	mov    %dx,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107372:	8d 55 f2             	lea    -0xe(%ebp),%edx
80107375:	0f 01 12             	lgdtl  (%edx)
}

static inline void
loadgs(ushort v)
{
  asm volatile("movw %0, %%gs" : : "r" (v));
80107378:	ba 18 00 00 00       	mov    $0x18,%edx
8010737d:	8e ea                	mov    %edx,%gs
  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
8010737f:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107386:	00 00 00 00 

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
8010738a:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
}
80107390:	83 c4 14             	add    $0x14,%esp
80107393:	5b                   	pop    %ebx
80107394:	5d                   	pop    %ebp
80107395:	c3                   	ret    
80107396:	8d 76 00             	lea    0x0(%esi),%esi
80107399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801073a0 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
801073a0:	55                   	push   %ebp
801073a1:	89 e5                	mov    %esp,%ebp
801073a3:	56                   	push   %esi
801073a4:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
801073a5:	e8 46 b1 ff ff       	call   801024f0 <kalloc>
801073aa:	85 c0                	test   %eax,%eax
801073ac:	74 52                	je     80107400 <setupkvm+0x60>
    return 0;
  memset(pgdir, 0, PGSIZE);
801073ae:	83 ec 04             	sub    $0x4,%esp
801073b1:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801073b3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
801073b8:	68 00 10 00 00       	push   $0x1000
801073bd:	6a 00                	push   $0x0
801073bf:	50                   	push   %eax
801073c0:	e8 6b d9 ff ff       	call   80104d30 <memset>
801073c5:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801073c8:	8b 43 04             	mov    0x4(%ebx),%eax
801073cb:	8b 4b 08             	mov    0x8(%ebx),%ecx
801073ce:	83 ec 08             	sub    $0x8,%esp
801073d1:	8b 13                	mov    (%ebx),%edx
801073d3:	ff 73 0c             	pushl  0xc(%ebx)
801073d6:	50                   	push   %eax
801073d7:	29 c1                	sub    %eax,%ecx
801073d9:	89 f0                	mov    %esi,%eax
801073db:	e8 d0 fd ff ff       	call   801071b0 <mappages>
801073e0:	83 c4 10             	add    $0x10,%esp
801073e3:	85 c0                	test   %eax,%eax
801073e5:	78 19                	js     80107400 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801073e7:	83 c3 10             	add    $0x10,%ebx
801073ea:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801073f0:	75 d6                	jne    801073c8 <setupkvm+0x28>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
801073f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801073f5:	89 f0                	mov    %esi,%eax
801073f7:	5b                   	pop    %ebx
801073f8:	5e                   	pop    %esi
801073f9:	5d                   	pop    %ebp
801073fa:	c3                   	ret    
801073fb:	90                   	nop
801073fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107400:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80107403:	31 c0                	xor    %eax,%eax
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80107405:	5b                   	pop    %ebx
80107406:	5e                   	pop    %esi
80107407:	5d                   	pop    %ebp
80107408:	c3                   	ret    
80107409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107410 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107410:	55                   	push   %ebp
80107411:	89 e5                	mov    %esp,%ebp
80107413:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107416:	e8 85 ff ff ff       	call   801073a0 <setupkvm>
8010741b:	a3 e0 db 11 80       	mov    %eax,0x8011dbe0
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107420:	05 00 00 00 80       	add    $0x80000000,%eax
80107425:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80107428:	c9                   	leave  
80107429:	c3                   	ret    
8010742a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107430 <switchkvm>:
80107430:	a1 e0 db 11 80       	mov    0x8011dbe0,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107435:	55                   	push   %ebp
80107436:	89 e5                	mov    %esp,%ebp
80107438:	05 00 00 00 80       	add    $0x80000000,%eax
8010743d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80107440:	5d                   	pop    %ebp
80107441:	c3                   	ret    
80107442:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107450 <switchuvm>:

// Switch TSS (task state segment) and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107450:	55                   	push   %ebp
80107451:	89 e5                	mov    %esp,%ebp
80107453:	53                   	push   %ebx
80107454:	83 ec 04             	sub    $0x4,%esp
80107457:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010745a:	e8 01 d8 ff ff       	call   80104c60 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
8010745f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107465:	b9 67 00 00 00       	mov    $0x67,%ecx
8010746a:	8d 50 08             	lea    0x8(%eax),%edx
8010746d:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
80107474:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
  cpu->gdt[SEG_TSS].s = 0;
8010747b:	c6 80 a5 00 00 00 89 	movb   $0x89,0xa5(%eax)
// Switch TSS (task state segment) and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107482:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
80107489:	89 d1                	mov    %edx,%ecx
8010748b:	c1 ea 18             	shr    $0x18,%edx
8010748e:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
80107494:	ba 10 00 00 00       	mov    $0x10,%edx
// Switch TSS (task state segment) and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107499:	c1 e9 10             	shr    $0x10,%ecx
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
8010749c:	66 89 50 10          	mov    %dx,0x10(%eax)
  cpu->ts.esp0 = (uint)thread->kstack + KSTACKSIZE;
801074a0:	65 8b 15 08 00 00 00 	mov    %gs:0x8,%edx
// Switch TSS (task state segment) and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
801074a7:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)thread->kstack + KSTACKSIZE;
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
801074ad:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)thread->kstack + KSTACKSIZE;
801074b2:	8b 52 08             	mov    0x8(%edx),%edx
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
801074b5:	66 89 48 6e          	mov    %cx,0x6e(%eax)
{
  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)thread->kstack + KSTACKSIZE;
801074b9:	81 c2 00 10 00 00    	add    $0x1000,%edx
801074bf:	89 50 0c             	mov    %edx,0xc(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
801074c2:	b8 30 00 00 00       	mov    $0x30,%eax
801074c7:	0f 00 d8             	ltr    %ax
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  if(p->pgdir == 0)
801074ca:	8b 43 04             	mov    0x4(%ebx),%eax
801074cd:	85 c0                	test   %eax,%eax
801074cf:	74 11                	je     801074e2 <switchuvm+0x92>
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801074d1:	05 00 00 00 80       	add    $0x80000000,%eax
801074d6:	0f 22 d8             	mov    %eax,%cr3
    panic("switchuvm: no pgdir");
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
801074d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801074dc:	c9                   	leave  
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
801074dd:	e9 ae d7 ff ff       	jmp    80104c90 <popcli>
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
801074e2:	83 ec 0c             	sub    $0xc,%esp
801074e5:	68 32 85 10 80       	push   $0x80108532
801074ea:	e8 61 8e ff ff       	call   80100350 <panic>
801074ef:	90                   	nop

801074f0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
801074f0:	55                   	push   %ebp
801074f1:	89 e5                	mov    %esp,%ebp
801074f3:	57                   	push   %edi
801074f4:	56                   	push   %esi
801074f5:	53                   	push   %ebx
801074f6:	83 ec 1c             	sub    $0x1c,%esp
801074f9:	8b 75 10             	mov    0x10(%ebp),%esi
801074fc:	8b 45 08             	mov    0x8(%ebp),%eax
801074ff:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80107502:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107508:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
8010750b:	77 49                	ja     80107556 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
8010750d:	e8 de af ff ff       	call   801024f0 <kalloc>
  memset(mem, 0, PGSIZE);
80107512:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80107515:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107517:	68 00 10 00 00       	push   $0x1000
8010751c:	6a 00                	push   $0x0
8010751e:	50                   	push   %eax
8010751f:	e8 0c d8 ff ff       	call   80104d30 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107524:	58                   	pop    %eax
80107525:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010752b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107530:	5a                   	pop    %edx
80107531:	6a 06                	push   $0x6
80107533:	50                   	push   %eax
80107534:	31 d2                	xor    %edx,%edx
80107536:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107539:	e8 72 fc ff ff       	call   801071b0 <mappages>
  memmove(mem, init, sz);
8010753e:	89 75 10             	mov    %esi,0x10(%ebp)
80107541:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107544:	83 c4 10             	add    $0x10,%esp
80107547:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010754a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010754d:	5b                   	pop    %ebx
8010754e:	5e                   	pop    %esi
8010754f:	5f                   	pop    %edi
80107550:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80107551:	e9 8a d8 ff ff       	jmp    80104de0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80107556:	83 ec 0c             	sub    $0xc,%esp
80107559:	68 46 85 10 80       	push   $0x80108546
8010755e:	e8 ed 8d ff ff       	call   80100350 <panic>
80107563:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107570 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107570:	55                   	push   %ebp
80107571:	89 e5                	mov    %esp,%ebp
80107573:	57                   	push   %edi
80107574:	56                   	push   %esi
80107575:	53                   	push   %ebx
80107576:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107579:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107580:	0f 85 91 00 00 00    	jne    80107617 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107586:	8b 75 18             	mov    0x18(%ebp),%esi
80107589:	31 db                	xor    %ebx,%ebx
8010758b:	85 f6                	test   %esi,%esi
8010758d:	75 1a                	jne    801075a9 <loaduvm+0x39>
8010758f:	eb 6f                	jmp    80107600 <loaduvm+0x90>
80107591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107598:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010759e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
801075a4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
801075a7:	76 57                	jbe    80107600 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801075a9:	8b 55 0c             	mov    0xc(%ebp),%edx
801075ac:	8b 45 08             	mov    0x8(%ebp),%eax
801075af:	31 c9                	xor    %ecx,%ecx
801075b1:	01 da                	add    %ebx,%edx
801075b3:	e8 68 fb ff ff       	call   80107120 <walkpgdir>
801075b8:	85 c0                	test   %eax,%eax
801075ba:	74 4e                	je     8010760a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801075bc:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801075be:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
801075c1:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
801075c6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801075cb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801075d1:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
801075d4:	01 d9                	add    %ebx,%ecx
801075d6:	05 00 00 00 80       	add    $0x80000000,%eax
801075db:	57                   	push   %edi
801075dc:	51                   	push   %ecx
801075dd:	50                   	push   %eax
801075de:	ff 75 10             	pushl  0x10(%ebp)
801075e1:	e8 ba a3 ff ff       	call   801019a0 <readi>
801075e6:	83 c4 10             	add    $0x10,%esp
801075e9:	39 c7                	cmp    %eax,%edi
801075eb:	74 ab                	je     80107598 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
801075ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
801075f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
801075f5:	5b                   	pop    %ebx
801075f6:	5e                   	pop    %esi
801075f7:	5f                   	pop    %edi
801075f8:	5d                   	pop    %ebp
801075f9:	c3                   	ret    
801075fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107600:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80107603:	31 c0                	xor    %eax,%eax
}
80107605:	5b                   	pop    %ebx
80107606:	5e                   	pop    %esi
80107607:	5f                   	pop    %edi
80107608:	5d                   	pop    %ebp
80107609:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
8010760a:	83 ec 0c             	sub    $0xc,%esp
8010760d:	68 60 85 10 80       	push   $0x80108560
80107612:	e8 39 8d ff ff       	call   80100350 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80107617:	83 ec 0c             	sub    $0xc,%esp
8010761a:	68 54 86 10 80       	push   $0x80108654
8010761f:	e8 2c 8d ff ff       	call   80100350 <panic>
80107624:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010762a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107630 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107630:	55                   	push   %ebp
80107631:	89 e5                	mov    %esp,%ebp
80107633:	57                   	push   %edi
80107634:	56                   	push   %esi
80107635:	53                   	push   %ebx
80107636:	83 ec 1c             	sub    $0x1c,%esp
80107639:	8b 75 0c             	mov    0xc(%ebp),%esi
  pte_t *pte;
  uint a, pa, ppn;

  if(newsz >= oldsz)
8010763c:	39 75 10             	cmp    %esi,0x10(%ebp)
    return oldsz;
8010763f:	89 f0                	mov    %esi,%eax
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa, ppn;

  if(newsz >= oldsz)
80107641:	72 0d                	jb     80107650 <deallocuvm+0x20>
      *pte = 0;
    }
  }
  release(&tablelock);
  return newsz;
}
80107643:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107646:	5b                   	pop    %ebx
80107647:	5e                   	pop    %esi
80107648:	5f                   	pop    %edi
80107649:	5d                   	pop    %ebp
8010764a:	c3                   	ret    
8010764b:	90                   	nop
8010764c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint a, pa, ppn;

  if(newsz >= oldsz)
    return oldsz;

  acquire(&tablelock);
80107650:	83 ec 0c             	sub    $0xc,%esp
80107653:	68 00 dc 11 80       	push   $0x8011dc00
80107658:	e8 a3 d4 ff ff       	call   80104b00 <acquire>
  a = PGROUNDUP(newsz);
8010765d:	8b 45 10             	mov    0x10(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80107660:	83 c4 10             	add    $0x10,%esp

  if(newsz >= oldsz)
    return oldsz;

  acquire(&tablelock);
  a = PGROUNDUP(newsz);
80107663:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107669:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
8010766f:	39 de                	cmp    %ebx,%esi
80107671:	77 41                	ja     801076b4 <deallocuvm+0x84>
80107673:	eb 5f                	jmp    801076d4 <deallocuvm+0xa4>
80107675:	8d 76 00             	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
80107678:	8b 10                	mov    (%eax),%edx
8010767a:	f6 c2 01             	test   $0x1,%dl
8010767d:	74 2b                	je     801076aa <deallocuvm+0x7a>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010767f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107685:	0f 84 7f 00 00 00    	je     8010770a <deallocuvm+0xda>
      {
        release(&tablelock);
        panic("kfree");
      }

      ppn = (pa >> PTXSHIFT) & 0xFFFFF;
8010768b:	89 d7                	mov    %edx,%edi
8010768d:	c1 ef 0c             	shr    $0xc,%edi
      // means it was the last page assigned to it
      if(sharedCounter[ppn] == 0)
80107690:	0f b6 8f 40 dc 11 80 	movzbl -0x7fee23c0(%edi),%ecx
80107697:	84 c9                	test   %cl,%cl
80107699:	74 55                	je     801076f0 <deallocuvm+0xc0>
      {
        char *v = P2V(pa);
        kfree(v);
      }
      else
        sharedCounter[ppn]--;
8010769b:	83 e9 01             	sub    $0x1,%ecx
8010769e:	88 8f 40 dc 11 80    	mov    %cl,-0x7fee23c0(%edi)
      *pte = 0;
801076a4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  if(newsz >= oldsz)
    return oldsz;

  acquire(&tablelock);
  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801076aa:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801076b0:	39 de                	cmp    %ebx,%esi
801076b2:	76 20                	jbe    801076d4 <deallocuvm+0xa4>
    pte = walkpgdir(pgdir, (char*)a, 0);
801076b4:	8b 45 08             	mov    0x8(%ebp),%eax
801076b7:	31 c9                	xor    %ecx,%ecx
801076b9:	89 da                	mov    %ebx,%edx
801076bb:	e8 60 fa ff ff       	call   80107120 <walkpgdir>
    if(!pte)
801076c0:	85 c0                	test   %eax,%eax
801076c2:	75 b4                	jne    80107678 <deallocuvm+0x48>
      a += (NPTENTRIES - 1) * PGSIZE;
801076c4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  if(newsz >= oldsz)
    return oldsz;

  acquire(&tablelock);
  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801076ca:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801076d0:	39 de                	cmp    %ebx,%esi
801076d2:	77 e0                	ja     801076b4 <deallocuvm+0x84>
      else
        sharedCounter[ppn]--;
      *pte = 0;
    }
  }
  release(&tablelock);
801076d4:	83 ec 0c             	sub    $0xc,%esp
801076d7:	68 00 dc 11 80       	push   $0x8011dc00
801076dc:	e8 ff d5 ff ff       	call   80104ce0 <release>
  return newsz;
801076e1:	8b 45 10             	mov    0x10(%ebp),%eax
801076e4:	83 c4 10             	add    $0x10,%esp
}
801076e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076ea:	5b                   	pop    %ebx
801076eb:	5e                   	pop    %esi
801076ec:	5f                   	pop    %edi
801076ed:	5d                   	pop    %ebp
801076ee:	c3                   	ret    
801076ef:	90                   	nop
      ppn = (pa >> PTXSHIFT) & 0xFFFFF;
      // means it was the last page assigned to it
      if(sharedCounter[ppn] == 0)
      {
        char *v = P2V(pa);
        kfree(v);
801076f0:	83 ec 0c             	sub    $0xc,%esp
801076f3:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801076f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801076fc:	52                   	push   %edx
801076fd:	e8 3e ac ff ff       	call   80102340 <kfree>
80107702:	83 c4 10             	add    $0x10,%esp
80107705:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107708:	eb 9a                	jmp    801076a4 <deallocuvm+0x74>
      a += (NPTENTRIES - 1) * PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
      {
        release(&tablelock);
8010770a:	83 ec 0c             	sub    $0xc,%esp
8010770d:	68 00 dc 11 80       	push   $0x8011dc00
80107712:	e8 c9 d5 ff ff       	call   80104ce0 <release>
        panic("kfree");
80107717:	c7 04 24 da 7e 10 80 	movl   $0x80107eda,(%esp)
8010771e:	e8 2d 8c ff ff       	call   80100350 <panic>
80107723:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107730 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107730:	55                   	push   %ebp
80107731:	89 e5                	mov    %esp,%ebp
80107733:	57                   	push   %edi
80107734:	56                   	push   %esi
80107735:	53                   	push   %ebx
80107736:	83 ec 0c             	sub    $0xc,%esp
80107739:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010773c:	85 ff                	test   %edi,%edi
8010773e:	0f 88 9c 00 00 00    	js     801077e0 <allocuvm+0xb0>
    return 0;
  if(newsz < oldsz)
80107744:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80107747:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
8010774a:	0f 82 7f 00 00 00    	jb     801077cf <allocuvm+0x9f>
    return oldsz;

  a = PGROUNDUP(oldsz);
80107750:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80107756:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
8010775c:	39 df                	cmp    %ebx,%edi
8010775e:	77 43                	ja     801077a3 <allocuvm+0x73>
80107760:	e9 8b 00 00 00       	jmp    801077f0 <allocuvm+0xc0>
80107765:	8d 76 00             	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80107768:	83 ec 04             	sub    $0x4,%esp
8010776b:	68 00 10 00 00       	push   $0x1000
80107770:	6a 00                	push   $0x0
80107772:	50                   	push   %eax
80107773:	e8 b8 d5 ff ff       	call   80104d30 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107778:	58                   	pop    %eax
80107779:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010777f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107784:	5a                   	pop    %edx
80107785:	6a 06                	push   $0x6
80107787:	50                   	push   %eax
80107788:	89 da                	mov    %ebx,%edx
8010778a:	8b 45 08             	mov    0x8(%ebp),%eax
8010778d:	e8 1e fa ff ff       	call   801071b0 <mappages>
80107792:	83 c4 10             	add    $0x10,%esp
80107795:	85 c0                	test   %eax,%eax
80107797:	78 67                	js     80107800 <allocuvm+0xd0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107799:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010779f:	39 df                	cmp    %ebx,%edi
801077a1:	76 4d                	jbe    801077f0 <allocuvm+0xc0>
    mem = kalloc();
801077a3:	e8 48 ad ff ff       	call   801024f0 <kalloc>
    if(mem == 0){
801077a8:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
801077aa:	89 c6                	mov    %eax,%esi
    if(mem == 0){
801077ac:	75 ba                	jne    80107768 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
801077ae:	83 ec 0c             	sub    $0xc,%esp
801077b1:	68 7e 85 10 80       	push   $0x8010857e
801077b6:	e8 85 8e ff ff       	call   80100640 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
801077bb:	83 c4 0c             	add    $0xc,%esp
801077be:	ff 75 0c             	pushl  0xc(%ebp)
801077c1:	57                   	push   %edi
801077c2:	ff 75 08             	pushl  0x8(%ebp)
801077c5:	e8 66 fe ff ff       	call   80107630 <deallocuvm>
      return 0;
801077ca:	83 c4 10             	add    $0x10,%esp
801077cd:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
801077cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077d2:	5b                   	pop    %ebx
801077d3:	5e                   	pop    %esi
801077d4:	5f                   	pop    %edi
801077d5:	5d                   	pop    %ebp
801077d6:	c3                   	ret    
801077d7:	89 f6                	mov    %esi,%esi
801077d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801077e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
{
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
801077e3:	31 c0                	xor    %eax,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
801077e5:	5b                   	pop    %ebx
801077e6:	5e                   	pop    %esi
801077e7:	5f                   	pop    %edi
801077e8:	5d                   	pop    %ebp
801077e9:	c3                   	ret    
801077ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801077f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
801077f3:	89 f8                	mov    %edi,%eax
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
801077f5:	5b                   	pop    %ebx
801077f6:	5e                   	pop    %esi
801077f7:	5f                   	pop    %edi
801077f8:	5d                   	pop    %ebp
801077f9:	c3                   	ret    
801077fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80107800:	83 ec 0c             	sub    $0xc,%esp
80107803:	68 96 85 10 80       	push   $0x80108596
80107808:	e8 33 8e ff ff       	call   80100640 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
8010780d:	83 c4 0c             	add    $0xc,%esp
80107810:	ff 75 0c             	pushl  0xc(%ebp)
80107813:	57                   	push   %edi
80107814:	ff 75 08             	pushl  0x8(%ebp)
80107817:	e8 14 fe ff ff       	call   80107630 <deallocuvm>
      kfree(mem);
8010781c:	89 34 24             	mov    %esi,(%esp)
8010781f:	e8 1c ab ff ff       	call   80102340 <kfree>
      return 0;
80107824:	83 c4 10             	add    $0x10,%esp
    }
  }
  return newsz;
}
80107827:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
8010782a:	31 c0                	xor    %eax,%eax
    }
  }
  return newsz;
}
8010782c:	5b                   	pop    %ebx
8010782d:	5e                   	pop    %esi
8010782e:	5f                   	pop    %edi
8010782f:	5d                   	pop    %ebp
80107830:	c3                   	ret    
80107831:	eb 0d                	jmp    80107840 <freevm>
80107833:	90                   	nop
80107834:	90                   	nop
80107835:	90                   	nop
80107836:	90                   	nop
80107837:	90                   	nop
80107838:	90                   	nop
80107839:	90                   	nop
8010783a:	90                   	nop
8010783b:	90                   	nop
8010783c:	90                   	nop
8010783d:	90                   	nop
8010783e:	90                   	nop
8010783f:	90                   	nop

80107840 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107840:	55                   	push   %ebp
80107841:	89 e5                	mov    %esp,%ebp
80107843:	57                   	push   %edi
80107844:	56                   	push   %esi
80107845:	53                   	push   %ebx
80107846:	83 ec 0c             	sub    $0xc,%esp
80107849:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010784c:	85 f6                	test   %esi,%esi
8010784e:	74 79                	je     801078c9 <freevm+0x89>
    panic("freevm: no pgdir");

  deallocuvm(pgdir, KERNBASE, 0);
80107850:	83 ec 04             	sub    $0x4,%esp
80107853:	89 f3                	mov    %esi,%ebx
80107855:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
8010785b:	6a 00                	push   $0x0
8010785d:	68 00 00 00 80       	push   $0x80000000
80107862:	56                   	push   %esi
80107863:	e8 c8 fd ff ff       	call   80107630 <deallocuvm>

  acquire(&tablelock);
80107868:	c7 04 24 00 dc 11 80 	movl   $0x8011dc00,(%esp)
8010786f:	e8 8c d2 ff ff       	call   80104b00 <acquire>
80107874:	83 c4 10             	add    $0x10,%esp
80107877:	eb 0e                	jmp    80107887 <freevm+0x47>
80107879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107880:	83 c3 04             	add    $0x4,%ebx

  for(i = 0; i < NPDENTRIES; i++){
80107883:	39 fb                	cmp    %edi,%ebx
80107885:	74 23                	je     801078aa <freevm+0x6a>
    if(pgdir[i] & PTE_P){
80107887:	8b 03                	mov    (%ebx),%eax
80107889:	a8 01                	test   $0x1,%al
8010788b:	74 f3                	je     80107880 <freevm+0x40>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
8010788d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107892:	83 ec 0c             	sub    $0xc,%esp
80107895:	83 c3 04             	add    $0x4,%ebx
80107898:	05 00 00 00 80       	add    $0x80000000,%eax
8010789d:	50                   	push   %eax
8010789e:	e8 9d aa ff ff       	call   80102340 <kfree>
801078a3:	83 c4 10             	add    $0x10,%esp

  deallocuvm(pgdir, KERNBASE, 0);

  acquire(&tablelock);

  for(i = 0; i < NPDENTRIES; i++){
801078a6:	39 fb                	cmp    %edi,%ebx
801078a8:	75 dd                	jne    80107887 <freevm+0x47>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801078aa:	83 ec 0c             	sub    $0xc,%esp
801078ad:	56                   	push   %esi
801078ae:	e8 8d aa ff ff       	call   80102340 <kfree>
  release(&tablelock);
801078b3:	c7 45 08 00 dc 11 80 	movl   $0x8011dc00,0x8(%ebp)
801078ba:	83 c4 10             	add    $0x10,%esp
}
801078bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078c0:	5b                   	pop    %ebx
801078c1:	5e                   	pop    %esi
801078c2:	5f                   	pop    %edi
801078c3:	5d                   	pop    %ebp
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
  release(&tablelock);
801078c4:	e9 17 d4 ff ff       	jmp    80104ce0 <release>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
801078c9:	83 ec 0c             	sub    $0xc,%esp
801078cc:	68 b2 85 10 80       	push   $0x801085b2
801078d1:	e8 7a 8a ff ff       	call   80100350 <panic>
801078d6:	8d 76 00             	lea    0x0(%esi),%esi
801078d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801078e0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801078e0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801078e1:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801078e3:	89 e5                	mov    %esp,%ebp
801078e5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801078e8:	8b 55 0c             	mov    0xc(%ebp),%edx
801078eb:	8b 45 08             	mov    0x8(%ebp),%eax
801078ee:	e8 2d f8 ff ff       	call   80107120 <walkpgdir>
  if(pte == 0)
801078f3:	85 c0                	test   %eax,%eax
801078f5:	74 05                	je     801078fc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801078f7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801078fa:	c9                   	leave  
801078fb:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801078fc:	83 ec 0c             	sub    $0xc,%esp
801078ff:	68 c3 85 10 80       	push   $0x801085c3
80107904:	e8 47 8a ff ff       	call   80100350 <panic>
80107909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107910 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107910:	55                   	push   %ebp
80107911:	89 e5                	mov    %esp,%ebp
80107913:	57                   	push   %edi
80107914:	56                   	push   %esi
80107915:	53                   	push   %ebx
80107916:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107919:	e8 82 fa ff ff       	call   801073a0 <setupkvm>
8010791e:	85 c0                	test   %eax,%eax
80107920:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107923:	0f 84 c5 00 00 00    	je     801079ee <copyuvm+0xde>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107929:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010792c:	85 c9                	test   %ecx,%ecx
8010792e:	0f 84 9c 00 00 00    	je     801079d0 <copyuvm+0xc0>
80107934:	31 ff                	xor    %edi,%edi
80107936:	eb 4a                	jmp    80107982 <copyuvm+0x72>
80107938:	90                   	nop
80107939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107940:	83 ec 04             	sub    $0x4,%esp
80107943:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107949:	68 00 10 00 00       	push   $0x1000
8010794e:	53                   	push   %ebx
8010794f:	50                   	push   %eax
80107950:	e8 8b d4 ff ff       	call   80104de0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107955:	58                   	pop    %eax
80107956:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
8010795c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107961:	5a                   	pop    %edx
80107962:	ff 75 e4             	pushl  -0x1c(%ebp)
80107965:	50                   	push   %eax
80107966:	89 fa                	mov    %edi,%edx
80107968:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010796b:	e8 40 f8 ff ff       	call   801071b0 <mappages>
80107970:	83 c4 10             	add    $0x10,%esp
80107973:	85 c0                	test   %eax,%eax
80107975:	78 69                	js     801079e0 <copyuvm+0xd0>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107977:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010797d:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80107980:	76 4e                	jbe    801079d0 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107982:	8b 45 08             	mov    0x8(%ebp),%eax
80107985:	31 c9                	xor    %ecx,%ecx
80107987:	89 fa                	mov    %edi,%edx
80107989:	e8 92 f7 ff ff       	call   80107120 <walkpgdir>
8010798e:	85 c0                	test   %eax,%eax
80107990:	74 6d                	je     801079ff <copyuvm+0xef>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107992:	8b 00                	mov    (%eax),%eax
80107994:	a8 01                	test   $0x1,%al
80107996:	74 5a                	je     801079f2 <copyuvm+0xe2>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107998:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
8010799a:	25 ff 0f 00 00       	and    $0xfff,%eax
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
8010799f:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
801079a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
801079a8:	e8 43 ab ff ff       	call   801024f0 <kalloc>
801079ad:	85 c0                	test   %eax,%eax
801079af:	89 c6                	mov    %eax,%esi
801079b1:	75 8d                	jne    80107940 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801079b3:	83 ec 0c             	sub    $0xc,%esp
801079b6:	ff 75 e0             	pushl  -0x20(%ebp)
801079b9:	e8 82 fe ff ff       	call   80107840 <freevm>
  return 0;
801079be:	83 c4 10             	add    $0x10,%esp
801079c1:	31 c0                	xor    %eax,%eax
}
801079c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079c6:	5b                   	pop    %ebx
801079c7:	5e                   	pop    %esi
801079c8:	5f                   	pop    %edi
801079c9:	5d                   	pop    %ebp
801079ca:	c3                   	ret    
801079cb:	90                   	nop
801079cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801079d0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
801079d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079d6:	5b                   	pop    %ebx
801079d7:	5e                   	pop    %esi
801079d8:	5f                   	pop    %edi
801079d9:	5d                   	pop    %ebp
801079da:	c3                   	ret    
801079db:	90                   	nop
801079dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
801079e0:	83 ec 0c             	sub    $0xc,%esp
801079e3:	56                   	push   %esi
801079e4:	e8 57 a9 ff ff       	call   80102340 <kfree>
      goto bad;
801079e9:	83 c4 10             	add    $0x10,%esp
801079ec:	eb c5                	jmp    801079b3 <copyuvm+0xa3>
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
801079ee:	31 c0                	xor    %eax,%eax
801079f0:	eb d1                	jmp    801079c3 <copyuvm+0xb3>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
801079f2:	83 ec 0c             	sub    $0xc,%esp
801079f5:	68 e7 85 10 80       	push   $0x801085e7
801079fa:	e8 51 89 ff ff       	call   80100350 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801079ff:	83 ec 0c             	sub    $0xc,%esp
80107a02:	68 cd 85 10 80       	push   $0x801085cd
80107a07:	e8 44 89 ff ff       	call   80100350 <panic>
80107a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107a10 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107a10:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107a11:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107a13:	89 e5                	mov    %esp,%ebp
80107a15:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107a18:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a1b:	8b 45 08             	mov    0x8(%ebp),%eax
80107a1e:	e8 fd f6 ff ff       	call   80107120 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107a23:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107a25:	89 c2                	mov    %eax,%edx
80107a27:	83 e2 05             	and    $0x5,%edx
80107a2a:	83 fa 05             	cmp    $0x5,%edx
80107a2d:	75 11                	jne    80107a40 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107a2f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80107a34:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107a35:	05 00 00 00 80       	add    $0x80000000,%eax
}
80107a3a:	c3                   	ret    
80107a3b:	90                   	nop
80107a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80107a40:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80107a42:	c9                   	leave  
80107a43:	c3                   	ret    
80107a44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107a4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107a50 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107a50:	55                   	push   %ebp
80107a51:	89 e5                	mov    %esp,%ebp
80107a53:	57                   	push   %edi
80107a54:	56                   	push   %esi
80107a55:	53                   	push   %ebx
80107a56:	83 ec 1c             	sub    $0x1c,%esp
80107a59:	8b 5d 14             	mov    0x14(%ebp),%ebx
80107a5c:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a5f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107a62:	85 db                	test   %ebx,%ebx
80107a64:	75 40                	jne    80107aa6 <copyout+0x56>
80107a66:	eb 70                	jmp    80107ad8 <copyout+0x88>
80107a68:	90                   	nop
80107a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107a70:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107a73:	89 f1                	mov    %esi,%ecx
80107a75:	29 d1                	sub    %edx,%ecx
80107a77:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80107a7d:	39 d9                	cmp    %ebx,%ecx
80107a7f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107a82:	29 f2                	sub    %esi,%edx
80107a84:	83 ec 04             	sub    $0x4,%esp
80107a87:	01 d0                	add    %edx,%eax
80107a89:	51                   	push   %ecx
80107a8a:	57                   	push   %edi
80107a8b:	50                   	push   %eax
80107a8c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80107a8f:	e8 4c d3 ff ff       	call   80104de0 <memmove>
    len -= n;
    buf += n;
80107a94:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107a97:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80107a9a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107aa0:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107aa2:	29 cb                	sub    %ecx,%ebx
80107aa4:	74 32                	je     80107ad8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107aa6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107aa8:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80107aab:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107aae:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107ab4:	56                   	push   %esi
80107ab5:	ff 75 08             	pushl  0x8(%ebp)
80107ab8:	e8 53 ff ff ff       	call   80107a10 <uva2ka>
    if(pa0 == 0)
80107abd:	83 c4 10             	add    $0x10,%esp
80107ac0:	85 c0                	test   %eax,%eax
80107ac2:	75 ac                	jne    80107a70 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107ac4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
80107ac7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80107acc:	5b                   	pop    %ebx
80107acd:	5e                   	pop    %esi
80107ace:	5f                   	pop    %edi
80107acf:	5d                   	pop    %ebp
80107ad0:	c3                   	ret    
80107ad1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ad8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80107adb:	31 c0                	xor    %eax,%eax
}
80107add:	5b                   	pop    %ebx
80107ade:	5e                   	pop    %esi
80107adf:	5f                   	pop    %edi
80107ae0:	5d                   	pop    %ebp
80107ae1:	c3                   	ret    
80107ae2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107af0 <pageFault>:

//handler in case of pagefault
// 3.2 allocate a new page in physical memorty
int 
pageFault(void)
{
80107af0:	55                   	push   %ebp
80107af1:	89 e5                	mov    %esp,%ebp
80107af3:	57                   	push   %edi
80107af4:	56                   	push   %esi
80107af5:	53                   	push   %ebx
80107af6:	83 ec 1c             	sub    $0x1c,%esp

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80107af9:	0f 20 d3             	mov    %cr2,%ebx
  pte_t *pte;
  char *mem;
  
  addr = rcr2();

  if(addr==0)
80107afc:	85 db                	test   %ebx,%ebx
80107afe:	0f 84 ec 00 00 00    	je     80107bf0 <pageFault+0x100>
  {
    cprintf("ERROR: NULL POINTER EXEPTION!!\n");
    proc->killed = 1;
    exit();
  } 
  if((pte=walkpgdir(proc->pgdir,(void* )addr,0))==0)
80107b04:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107b0a:	31 c9                	xor    %ecx,%ecx
80107b0c:	89 da                	mov    %ebx,%edx
80107b0e:	8b 40 04             	mov    0x4(%eax),%eax
80107b11:	e8 0a f6 ff ff       	call   80107120 <walkpgdir>
80107b16:	85 c0                	test   %eax,%eax
80107b18:	89 c6                	mov    %eax,%esi
80107b1a:	0f 84 2f 01 00 00    	je     80107c4f <pageFault+0x15f>
  {
    panic("pageFault: pte should exist");
  }
  if(!(*pte & PTE_P))
80107b20:	8b 00                	mov    (%eax),%eax
80107b22:	a8 01                	test   $0x1,%al
80107b24:	0f 84 32 01 00 00    	je     80107c5c <pageFault+0x16c>
    panic("pageFault: page not present");

  pa = PTE_ADDR(*pte);
  ppn=( pa >> PTXSHIFT) & 0xFFFFF;

  if(addr < proc->sz)
80107b2a:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107b31:	39 1a                	cmp    %ebx,(%edx)
80107b33:	77 0b                	ja     80107b40 <pageFault+0x50>
    lcr3(V2P(proc->pgdir)); // flush the TLB
    return 1;
  }
  bad:
  return 0 ;
}
80107b35:	8d 65 f4             	lea    -0xc(%ebp),%esp
    release(&tablelock);
    lcr3(V2P(proc->pgdir)); // flush the TLB
    return 1;
  }
  bad:
  return 0 ;
80107b38:	31 c0                	xor    %eax,%eax
}
80107b3a:	5b                   	pop    %ebx
80107b3b:	5e                   	pop    %esi
80107b3c:	5f                   	pop    %edi
80107b3d:	5d                   	pop    %ebp
80107b3e:	c3                   	ret    
80107b3f:	90                   	nop
    panic("pageFault: pte should exist");
  }
  if(!(*pte & PTE_P))
    panic("pageFault: page not present");

  pa = PTE_ADDR(*pte);
80107b40:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  ppn=( pa >> PTXSHIFT) & 0xFFFFF;

  if(addr < proc->sz)
  {
    acquire(&tablelock);
80107b45:	83 ec 0c             	sub    $0xc,%esp
  }
  if(!(*pte & PTE_P))
    panic("pageFault: page not present");

  pa = PTE_ADDR(*pte);
  ppn=( pa >> PTXSHIFT) & 0xFFFFF;
80107b48:	89 c7                	mov    %eax,%edi

  if(addr < proc->sz)
  {
    acquire(&tablelock);
80107b4a:	68 00 dc 11 80       	push   $0x8011dc00
    panic("pageFault: pte should exist");
  }
  if(!(*pte & PTE_P))
    panic("pageFault: page not present");

  pa = PTE_ADDR(*pte);
80107b4f:	89 c3                	mov    %eax,%ebx
  ppn=( pa >> PTXSHIFT) & 0xFFFFF;
80107b51:	c1 ef 0c             	shr    $0xc,%edi

  if(addr < proc->sz)
  {
    acquire(&tablelock);
80107b54:	e8 a7 cf ff ff       	call   80104b00 <acquire>

    //checking if there are still process that shared this table, if not we will add writeable on this page
    if(sharedCounter[ppn] > 0)
80107b59:	83 c4 10             	add    $0x10,%esp
80107b5c:	80 bf 40 dc 11 80 00 	cmpb   $0x0,-0x7fee23c0(%edi)
80107b63:	0f 8e b7 00 00 00    	jle    80107c20 <pageFault+0x130>
    {
      if((mem = kalloc()) == 0) //  allocate new page in the physical mem
80107b69:	e8 82 a9 ff ff       	call   801024f0 <kalloc>
80107b6e:	85 c0                	test   %eax,%eax
80107b70:	89 c2                	mov    %eax,%edx
80107b72:	74 c1                	je     80107b35 <pageFault+0x45>
        goto bad; 

      memmove(mem, (char*)P2V(pa), PGSIZE);
80107b74:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107b7a:	83 ec 04             	sub    $0x4,%esp
80107b7d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80107b80:	68 00 10 00 00       	push   $0x1000

      flags = PTE_FLAGS(*pte);
      flags |= (flags & PTE_WS) ? PTE_W : 0;
80107b85:	bb 02 00 00 00       	mov    $0x2,%ebx
    if(sharedCounter[ppn] > 0)
    {
      if((mem = kalloc()) == 0) //  allocate new page in the physical mem
        goto bad; 

      memmove(mem, (char*)P2V(pa), PGSIZE);
80107b8a:	50                   	push   %eax
80107b8b:	52                   	push   %edx
80107b8c:	e8 4f d2 ff ff       	call   80104de0 <memmove>

      flags = PTE_FLAGS(*pte);
80107b91:	8b 06                	mov    (%esi),%eax
      flags |= (flags & PTE_WS) ? PTE_W : 0;
80107b93:	83 c4 10             	add    $0x10,%esp
      flags &= flags & ~PTE_WS;
      flags &= 0x00000FFF;

      *pte &= 0x0;
      *pte |= flags;
      *pte |= V2P(mem); // insert the new physical page num and set to writable
80107b96:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      if((mem = kalloc()) == 0) //  allocate new page in the physical mem
        goto bad; 

      memmove(mem, (char*)P2V(pa), PGSIZE);

      flags = PTE_FLAGS(*pte);
80107b99:	89 c1                	mov    %eax,%ecx
80107b9b:	81 e1 ff 0f 00 00    	and    $0xfff,%ecx
      flags |= (flags & PTE_WS) ? PTE_W : 0;
80107ba1:	25 00 01 00 00       	and    $0x100,%eax
80107ba6:	0f 45 c3             	cmovne %ebx,%eax
      flags &= flags & ~PTE_WS;
      flags &= 0x00000FFF;

      *pte &= 0x0;
      *pte |= flags;
      *pte |= V2P(mem); // insert the new physical page num and set to writable
80107ba9:	81 c2 00 00 00 80    	add    $0x80000000,%edx
        goto bad; 

      memmove(mem, (char*)P2V(pa), PGSIZE);

      flags = PTE_FLAGS(*pte);
      flags |= (flags & PTE_WS) ? PTE_W : 0;
80107baf:	09 c8                	or     %ecx,%eax
      flags &= flags & ~PTE_WS;
      flags &= 0x00000FFF;

      *pte &= 0x0;
      *pte |= flags;
      *pte |= V2P(mem); // insert the new physical page num and set to writable
80107bb1:	25 ff 0e 00 00       	and    $0xeff,%eax
80107bb6:	09 c2                	or     %eax,%edx
80107bb8:	89 16                	mov    %edx,(%esi)

      sharedCounter[ppn]--;   //decrease the sharing page counter
80107bba:	80 af 40 dc 11 80 01 	subb   $0x1,-0x7fee23c0(%edi)
      *pte |= flags;
    }
    else // the counter is zero, and so nobody should point to that page
      panic("shared counter mismatched");

    release(&tablelock);
80107bc1:	83 ec 0c             	sub    $0xc,%esp
80107bc4:	68 00 dc 11 80       	push   $0x8011dc00
80107bc9:	e8 12 d1 ff ff       	call   80104ce0 <release>
    lcr3(V2P(proc->pgdir)); // flush the TLB
80107bce:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107bd4:	8b 40 04             	mov    0x4(%eax),%eax
80107bd7:	05 00 00 00 80       	add    $0x80000000,%eax
80107bdc:	0f 22 d8             	mov    %eax,%cr3
    return 1;
80107bdf:	83 c4 10             	add    $0x10,%esp
  }
  bad:
  return 0 ;
}
80107be2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else // the counter is zero, and so nobody should point to that page
      panic("shared counter mismatched");

    release(&tablelock);
    lcr3(V2P(proc->pgdir)); // flush the TLB
    return 1;
80107be5:	b8 01 00 00 00       	mov    $0x1,%eax
  }
  bad:
  return 0 ;
}
80107bea:	5b                   	pop    %ebx
80107beb:	5e                   	pop    %esi
80107bec:	5f                   	pop    %edi
80107bed:	5d                   	pop    %ebp
80107bee:	c3                   	ret    
80107bef:	90                   	nop
  
  addr = rcr2();

  if(addr==0)
  {
    cprintf("ERROR: NULL POINTER EXEPTION!!\n");
80107bf0:	83 ec 0c             	sub    $0xc,%esp
80107bf3:	68 78 86 10 80       	push   $0x80108678
80107bf8:	e8 43 8a ff ff       	call   80100640 <cprintf>
    proc->killed = 1;
80107bfd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80107c03:	c7 40 14 01 00 00 00 	movl   $0x1,0x14(%eax)
    exit();
80107c0a:	e8 21 c3 ff ff       	call   80103f30 <exit>
80107c0f:	83 c4 10             	add    $0x10,%esp
80107c12:	e9 ed fe ff ff       	jmp    80107b04 <pageFault+0x14>
80107c17:	89 f6                	mov    %esi,%esi
80107c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *pte |= flags;
      *pte |= V2P(mem); // insert the new physical page num and set to writable

      sharedCounter[ppn]--;   //decrease the sharing page counter
    }
    else if(sharedCounter[ppn]==0)
80107c20:	75 47                	jne    80107c69 <pageFault+0x179>
    {
      flags = PTE_FLAGS(*pte);
80107c22:	8b 06                	mov    (%esi),%eax
      flags |= (flags & PTE_WS) ? PTE_W : 0;
80107c24:	bb 02 00 00 00       	mov    $0x2,%ebx

      sharedCounter[ppn]--;   //decrease the sharing page counter
    }
    else if(sharedCounter[ppn]==0)
    {
      flags = PTE_FLAGS(*pte);
80107c29:	89 c2                	mov    %eax,%edx
      flags |= (flags & PTE_WS) ? PTE_W : 0;
80107c2b:	89 c1                	mov    %eax,%ecx

      sharedCounter[ppn]--;   //decrease the sharing page counter
    }
    else if(sharedCounter[ppn]==0)
    {
      flags = PTE_FLAGS(*pte);
80107c2d:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
      flags |= (flags & PTE_WS) ? PTE_W : 0;
80107c33:	81 e1 00 01 00 00    	and    $0x100,%ecx
80107c39:	0f 45 cb             	cmovne %ebx,%ecx
      flags &= flags & ~PTE_WS;

      *pte &= 0xfffff000;
      *pte |= flags;
80107c3c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      sharedCounter[ppn]--;   //decrease the sharing page counter
    }
    else if(sharedCounter[ppn]==0)
    {
      flags = PTE_FLAGS(*pte);
      flags |= (flags & PTE_WS) ? PTE_W : 0;
80107c41:	09 ca                	or     %ecx,%edx
      flags &= flags & ~PTE_WS;

      *pte &= 0xfffff000;
      *pte |= flags;
80107c43:	80 e6 fe             	and    $0xfe,%dh
80107c46:	09 d0                	or     %edx,%eax
80107c48:	89 06                	mov    %eax,(%esi)
80107c4a:	e9 72 ff ff ff       	jmp    80107bc1 <pageFault+0xd1>
    proc->killed = 1;
    exit();
  } 
  if((pte=walkpgdir(proc->pgdir,(void* )addr,0))==0)
  {
    panic("pageFault: pte should exist");
80107c4f:	83 ec 0c             	sub    $0xc,%esp
80107c52:	68 01 86 10 80       	push   $0x80108601
80107c57:	e8 f4 86 ff ff       	call   80100350 <panic>
  }
  if(!(*pte & PTE_P))
    panic("pageFault: page not present");
80107c5c:	83 ec 0c             	sub    $0xc,%esp
80107c5f:	68 1d 86 10 80       	push   $0x8010861d
80107c64:	e8 e7 86 ff ff       	call   80100350 <panic>

      *pte &= 0xfffff000;
      *pte |= flags;
    }
    else // the counter is zero, and so nobody should point to that page
      panic("shared counter mismatched");
80107c69:	83 ec 0c             	sub    $0xc,%esp
80107c6c:	68 39 86 10 80       	push   $0x80108639
80107c71:	e8 da 86 ff ff       	call   80100350 <panic>
