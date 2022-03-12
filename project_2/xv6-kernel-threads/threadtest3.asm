
_threadtest3:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}
 
int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	83 ec 14             	sub    $0x14,%esp
  uint *stack, *stack1, *stack2;
  int tid, tid1, tid2;
 
  stack = malloc(MAX_STACK_SIZE);
  14:	68 00 04 00 00       	push   $0x400
  19:	e8 e2 07 00 00       	call   800 <malloc>
  memset(stack, 0, sizeof(*stack));
  1e:	83 c4 0c             	add    $0xc,%esp
main(int argc, char *argv[])
{
  uint *stack, *stack1, *stack2;
  int tid, tid1, tid2;
 
  stack = malloc(MAX_STACK_SIZE);
  21:	89 c3                	mov    %eax,%ebx
  memset(stack, 0, sizeof(*stack));
  23:	6a 04                	push   $0x4
  25:	6a 00                	push   $0x0
  27:	50                   	push   %eax
  28:	e8 83 02 00 00       	call   2b0 <memset>
  if ((tid = (kthread_create(printme, stack, MAX_STACK_SIZE))) < 0) {
  2d:	83 c4 0c             	add    $0xc,%esp
  30:	68 00 04 00 00       	push   $0x400
  35:	53                   	push   %ebx
  36:	68 d0 01 00 00       	push   $0x1d0
  3b:	e8 a2 04 00 00       	call   4e2 <kthread_create>
  40:	83 c4 10             	add    $0x10,%esp
  43:	85 c0                	test   %eax,%eax
  45:	89 c7                	mov    %eax,%edi
  47:	0f 88 f5 00 00 00    	js     142 <main+0x142>
    printf(2, "thread_create error\n");
  }
  stack1  = malloc(MAX_STACK_SIZE);
  4d:	83 ec 0c             	sub    $0xc,%esp
  50:	68 00 04 00 00       	push   $0x400
  55:	e8 a6 07 00 00       	call   800 <malloc>
  memset(stack1, 0, sizeof(*stack1));
  5a:	83 c4 0c             	add    $0xc,%esp
  stack = malloc(MAX_STACK_SIZE);
  memset(stack, 0, sizeof(*stack));
  if ((tid = (kthread_create(printme, stack, MAX_STACK_SIZE))) < 0) {
    printf(2, "thread_create error\n");
  }
  stack1  = malloc(MAX_STACK_SIZE);
  5d:	89 c3                	mov    %eax,%ebx
  memset(stack1, 0, sizeof(*stack1));
  5f:	6a 04                	push   $0x4
  61:	6a 00                	push   $0x0
  63:	50                   	push   %eax
  64:	e8 47 02 00 00       	call   2b0 <memset>
  if ((tid1 = (kthread_create(printme, stack1, MAX_STACK_SIZE))) < 0) {
  69:	83 c4 0c             	add    $0xc,%esp
  6c:	68 00 04 00 00       	push   $0x400
  71:	53                   	push   %ebx
  72:	68 d0 01 00 00       	push   $0x1d0
  77:	e8 66 04 00 00       	call   4e2 <kthread_create>
  7c:	83 c4 10             	add    $0x10,%esp
  7f:	85 c0                	test   %eax,%eax
  81:	89 c6                	mov    %eax,%esi
  83:	0f 88 cf 00 00 00    	js     158 <main+0x158>
    printf(2, "thread_create error\n");
  }
  stack2  = malloc(MAX_STACK_SIZE);
  89:	83 ec 0c             	sub    $0xc,%esp
  8c:	68 00 04 00 00       	push   $0x400
  91:	e8 6a 07 00 00       	call   800 <malloc>
  memset(stack2, 0, sizeof(*stack2));
  96:	83 c4 0c             	add    $0xc,%esp
  stack1  = malloc(MAX_STACK_SIZE);
  memset(stack1, 0, sizeof(*stack1));
  if ((tid1 = (kthread_create(printme, stack1, MAX_STACK_SIZE))) < 0) {
    printf(2, "thread_create error\n");
  }
  stack2  = malloc(MAX_STACK_SIZE);
  99:	89 c3                	mov    %eax,%ebx
  memset(stack2, 0, sizeof(*stack2));
  9b:	6a 04                	push   $0x4
  9d:	6a 00                	push   $0x0
  9f:	50                   	push   %eax
  a0:	e8 0b 02 00 00       	call   2b0 <memset>
  if ((tid2 = (kthread_create(printme, stack2, MAX_STACK_SIZE))) < 0) {
  a5:	83 c4 0c             	add    $0xc,%esp
  a8:	68 00 04 00 00       	push   $0x400
  ad:	53                   	push   %ebx
  ae:	68 d0 01 00 00       	push   $0x1d0
  b3:	e8 2a 04 00 00       	call   4e2 <kthread_create>
  b8:	83 c4 10             	add    $0x10,%esp
  bb:	85 c0                	test   %eax,%eax
  bd:	89 c3                	mov    %eax,%ebx
  bf:	0f 88 a9 00 00 00    	js     16e <main+0x16e>
    printf(2, "thread_create error\n");
  }
  printf(1, "Joining %d\n", tid);
  c5:	83 ec 04             	sub    $0x4,%esp
  c8:	57                   	push   %edi
  c9:	68 1a 09 00 00       	push   $0x91a
  ce:	6a 01                	push   $0x1
  d0:	e8 fb 04 00 00       	call   5d0 <printf>
  if (kthread_join(tid) < 0) {
  d5:	89 3c 24             	mov    %edi,(%esp)
  d8:	e8 1d 04 00 00       	call   4fa <kthread_join>
  dd:	83 c4 10             	add    $0x10,%esp
  e0:	85 c0                	test   %eax,%eax
  e2:	0f 88 9c 00 00 00    	js     184 <main+0x184>
    printf(2, "join error\n");
  }
 
  printf(1, "Joining %d\n", tid1);
  e8:	83 ec 04             	sub    $0x4,%esp
  eb:	56                   	push   %esi
  ec:	68 1a 09 00 00       	push   $0x91a
  f1:	6a 01                	push   $0x1
  f3:	e8 d8 04 00 00       	call   5d0 <printf>
  if (kthread_join(tid1) < 0) {
  f8:	89 34 24             	mov    %esi,(%esp)
  fb:	e8 fa 03 00 00       	call   4fa <kthread_join>
 100:	83 c4 10             	add    $0x10,%esp
 103:	85 c0                	test   %eax,%eax
 105:	0f 88 8f 00 00 00    	js     19a <main+0x19a>
    printf(2, "join error\n");
  }
 
 
  printf(1, "Joining %d\n", tid2);
 10b:	83 ec 04             	sub    $0x4,%esp
 10e:	53                   	push   %ebx
 10f:	68 1a 09 00 00       	push   $0x91a
 114:	6a 01                	push   $0x1
 116:	e8 b5 04 00 00       	call   5d0 <printf>
  if (kthread_join(tid2) < 0) {
 11b:	89 1c 24             	mov    %ebx,(%esp)
 11e:	e8 d7 03 00 00       	call   4fa <kthread_join>
 123:	83 c4 10             	add    $0x10,%esp
 126:	85 c0                	test   %eax,%eax
 128:	0f 88 82 00 00 00    	js     1b0 <main+0x1b0>
    printf(2, "join error\n");
  }
 
 
  printf(1, "\nAll threads done!\n");
 12e:	83 ec 08             	sub    $0x8,%esp
 131:	68 32 09 00 00       	push   $0x932
 136:	6a 01                	push   $0x1
 138:	e8 93 04 00 00       	call   5d0 <printf>
 
  exit();
 13d:	e8 00 03 00 00       	call   442 <exit>
  int tid, tid1, tid2;
 
  stack = malloc(MAX_STACK_SIZE);
  memset(stack, 0, sizeof(*stack));
  if ((tid = (kthread_create(printme, stack, MAX_STACK_SIZE))) < 0) {
    printf(2, "thread_create error\n");
 142:	50                   	push   %eax
 143:	50                   	push   %eax
 144:	68 05 09 00 00       	push   $0x905
 149:	6a 02                	push   $0x2
 14b:	e8 80 04 00 00       	call   5d0 <printf>
 150:	83 c4 10             	add    $0x10,%esp
 153:	e9 f5 fe ff ff       	jmp    4d <main+0x4d>
  }
  stack1  = malloc(MAX_STACK_SIZE);
  memset(stack1, 0, sizeof(*stack1));
  if ((tid1 = (kthread_create(printme, stack1, MAX_STACK_SIZE))) < 0) {
    printf(2, "thread_create error\n");
 158:	50                   	push   %eax
 159:	50                   	push   %eax
 15a:	68 05 09 00 00       	push   $0x905
 15f:	6a 02                	push   $0x2
 161:	e8 6a 04 00 00       	call   5d0 <printf>
 166:	83 c4 10             	add    $0x10,%esp
 169:	e9 1b ff ff ff       	jmp    89 <main+0x89>
  }
  stack2  = malloc(MAX_STACK_SIZE);
  memset(stack2, 0, sizeof(*stack2));
  if ((tid2 = (kthread_create(printme, stack2, MAX_STACK_SIZE))) < 0) {
    printf(2, "thread_create error\n");
 16e:	50                   	push   %eax
 16f:	50                   	push   %eax
 170:	68 05 09 00 00       	push   $0x905
 175:	6a 02                	push   $0x2
 177:	e8 54 04 00 00       	call   5d0 <printf>
 17c:	83 c4 10             	add    $0x10,%esp
 17f:	e9 41 ff ff ff       	jmp    c5 <main+0xc5>
  }
  printf(1, "Joining %d\n", tid);
  if (kthread_join(tid) < 0) {
    printf(2, "join error\n");
 184:	51                   	push   %ecx
 185:	51                   	push   %ecx
 186:	68 26 09 00 00       	push   $0x926
 18b:	6a 02                	push   $0x2
 18d:	e8 3e 04 00 00       	call   5d0 <printf>
 192:	83 c4 10             	add    $0x10,%esp
 195:	e9 4e ff ff ff       	jmp    e8 <main+0xe8>
  }
 
  printf(1, "Joining %d\n", tid1);
  if (kthread_join(tid1) < 0) {
    printf(2, "join error\n");
 19a:	52                   	push   %edx
 19b:	52                   	push   %edx
 19c:	68 26 09 00 00       	push   $0x926
 1a1:	6a 02                	push   $0x2
 1a3:	e8 28 04 00 00       	call   5d0 <printf>
 1a8:	83 c4 10             	add    $0x10,%esp
 1ab:	e9 5b ff ff ff       	jmp    10b <main+0x10b>
  }
 
 
  printf(1, "Joining %d\n", tid2);
  if (kthread_join(tid2) < 0) {
    printf(2, "join error\n");
 1b0:	50                   	push   %eax
 1b1:	50                   	push   %eax
 1b2:	68 26 09 00 00       	push   $0x926
 1b7:	6a 02                	push   $0x2
 1b9:	e8 12 04 00 00       	call   5d0 <printf>
 1be:	83 c4 10             	add    $0x10,%esp
 1c1:	e9 68 ff ff ff       	jmp    12e <main+0x12e>
 1c6:	66 90                	xchg   %ax,%ax
 1c8:	66 90                	xchg   %ax,%ax
 1ca:	66 90                	xchg   %ax,%ax
 1cc:	66 90                	xchg   %ax,%ax
 1ce:	66 90                	xchg   %ax,%ax

000001d0 <printme>:
#include "stat.h"
#include "user.h"
#include "kthread.h"
#define MAX_STACK_SIZE  1024

void* printme() {
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	83 ec 08             	sub    $0x8,%esp
  printf(1,"Thread %d running !\n", kthread_id());
 1d6:	e8 0f 03 00 00       	call   4ea <kthread_id>
 1db:	83 ec 04             	sub    $0x4,%esp
 1de:	50                   	push   %eax
 1df:	68 f0 08 00 00       	push   $0x8f0
 1e4:	6a 01                	push   $0x1
 1e6:	e8 e5 03 00 00       	call   5d0 <printf>
  kthread_exit();
 1eb:	e8 02 03 00 00       	call   4f2 <kthread_exit>
  return 0;
}
 1f0:	31 c0                	xor    %eax,%eax
 1f2:	c9                   	leave  
 1f3:	c3                   	ret    
 1f4:	66 90                	xchg   %ax,%ax
 1f6:	66 90                	xchg   %ax,%ax
 1f8:	66 90                	xchg   %ax,%ax
 1fa:	66 90                	xchg   %ax,%ax
 1fc:	66 90                	xchg   %ax,%ax
 1fe:	66 90                	xchg   %ax,%ax

00000200 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	8b 45 08             	mov    0x8(%ebp),%eax
 207:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 20a:	89 c2                	mov    %eax,%edx
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 210:	83 c1 01             	add    $0x1,%ecx
 213:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 217:	83 c2 01             	add    $0x1,%edx
 21a:	84 db                	test   %bl,%bl
 21c:	88 5a ff             	mov    %bl,-0x1(%edx)
 21f:	75 ef                	jne    210 <strcpy+0x10>
    ;
  return os;
}
 221:	5b                   	pop    %ebx
 222:	5d                   	pop    %ebp
 223:	c3                   	ret    
 224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 22a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000230 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	56                   	push   %esi
 234:	53                   	push   %ebx
 235:	8b 55 08             	mov    0x8(%ebp),%edx
 238:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 23b:	0f b6 02             	movzbl (%edx),%eax
 23e:	0f b6 19             	movzbl (%ecx),%ebx
 241:	84 c0                	test   %al,%al
 243:	75 1e                	jne    263 <strcmp+0x33>
 245:	eb 29                	jmp    270 <strcmp+0x40>
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 250:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 253:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 256:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 259:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 25d:	84 c0                	test   %al,%al
 25f:	74 0f                	je     270 <strcmp+0x40>
 261:	89 f1                	mov    %esi,%ecx
 263:	38 d8                	cmp    %bl,%al
 265:	74 e9                	je     250 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 267:	29 d8                	sub    %ebx,%eax
}
 269:	5b                   	pop    %ebx
 26a:	5e                   	pop    %esi
 26b:	5d                   	pop    %ebp
 26c:	c3                   	ret    
 26d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 270:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 272:	29 d8                	sub    %ebx,%eax
}
 274:	5b                   	pop    %ebx
 275:	5e                   	pop    %esi
 276:	5d                   	pop    %ebp
 277:	c3                   	ret    
 278:	90                   	nop
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000280 <strlen>:

uint
strlen(char *s)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 286:	80 39 00             	cmpb   $0x0,(%ecx)
 289:	74 12                	je     29d <strlen+0x1d>
 28b:	31 d2                	xor    %edx,%edx
 28d:	8d 76 00             	lea    0x0(%esi),%esi
 290:	83 c2 01             	add    $0x1,%edx
 293:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 297:	89 d0                	mov    %edx,%eax
 299:	75 f5                	jne    290 <strlen+0x10>
    ;
  return n;
}
 29b:	5d                   	pop    %ebp
 29c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 29d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 29f:	5d                   	pop    %ebp
 2a0:	c3                   	ret    
 2a1:	eb 0d                	jmp    2b0 <memset>
 2a3:	90                   	nop
 2a4:	90                   	nop
 2a5:	90                   	nop
 2a6:	90                   	nop
 2a7:	90                   	nop
 2a8:	90                   	nop
 2a9:	90                   	nop
 2aa:	90                   	nop
 2ab:	90                   	nop
 2ac:	90                   	nop
 2ad:	90                   	nop
 2ae:	90                   	nop
 2af:	90                   	nop

000002b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 2bd:	89 d7                	mov    %edx,%edi
 2bf:	fc                   	cld    
 2c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2c2:	89 d0                	mov    %edx,%eax
 2c4:	5f                   	pop    %edi
 2c5:	5d                   	pop    %ebp
 2c6:	c3                   	ret    
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <strchr>:

char*
strchr(const char *s, char c)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 45 08             	mov    0x8(%ebp),%eax
 2d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 2da:	0f b6 10             	movzbl (%eax),%edx
 2dd:	84 d2                	test   %dl,%dl
 2df:	74 1d                	je     2fe <strchr+0x2e>
    if(*s == c)
 2e1:	38 d3                	cmp    %dl,%bl
 2e3:	89 d9                	mov    %ebx,%ecx
 2e5:	75 0d                	jne    2f4 <strchr+0x24>
 2e7:	eb 17                	jmp    300 <strchr+0x30>
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2f0:	38 ca                	cmp    %cl,%dl
 2f2:	74 0c                	je     300 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2f4:	83 c0 01             	add    $0x1,%eax
 2f7:	0f b6 10             	movzbl (%eax),%edx
 2fa:	84 d2                	test   %dl,%dl
 2fc:	75 f2                	jne    2f0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 2fe:	31 c0                	xor    %eax,%eax
}
 300:	5b                   	pop    %ebx
 301:	5d                   	pop    %ebp
 302:	c3                   	ret    
 303:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <gets>:

char*
gets(char *buf, int max)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	56                   	push   %esi
 315:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 316:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 318:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 31b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 31e:	eb 29                	jmp    349 <gets+0x39>
    cc = read(0, &c, 1);
 320:	83 ec 04             	sub    $0x4,%esp
 323:	6a 01                	push   $0x1
 325:	57                   	push   %edi
 326:	6a 00                	push   $0x0
 328:	e8 2d 01 00 00       	call   45a <read>
    if(cc < 1)
 32d:	83 c4 10             	add    $0x10,%esp
 330:	85 c0                	test   %eax,%eax
 332:	7e 1d                	jle    351 <gets+0x41>
      break;
    buf[i++] = c;
 334:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 338:	8b 55 08             	mov    0x8(%ebp),%edx
 33b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 33d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 33f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 343:	74 1b                	je     360 <gets+0x50>
 345:	3c 0d                	cmp    $0xd,%al
 347:	74 17                	je     360 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 349:	8d 5e 01             	lea    0x1(%esi),%ebx
 34c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 34f:	7c cf                	jl     320 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 351:	8b 45 08             	mov    0x8(%ebp),%eax
 354:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 358:	8d 65 f4             	lea    -0xc(%ebp),%esp
 35b:	5b                   	pop    %ebx
 35c:	5e                   	pop    %esi
 35d:	5f                   	pop    %edi
 35e:	5d                   	pop    %ebp
 35f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 360:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 363:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 365:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 369:	8d 65 f4             	lea    -0xc(%ebp),%esp
 36c:	5b                   	pop    %ebx
 36d:	5e                   	pop    %esi
 36e:	5f                   	pop    %edi
 36f:	5d                   	pop    %ebp
 370:	c3                   	ret    
 371:	eb 0d                	jmp    380 <stat>
 373:	90                   	nop
 374:	90                   	nop
 375:	90                   	nop
 376:	90                   	nop
 377:	90                   	nop
 378:	90                   	nop
 379:	90                   	nop
 37a:	90                   	nop
 37b:	90                   	nop
 37c:	90                   	nop
 37d:	90                   	nop
 37e:	90                   	nop
 37f:	90                   	nop

00000380 <stat>:

int
stat(char *n, struct stat *st)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	56                   	push   %esi
 384:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 385:	83 ec 08             	sub    $0x8,%esp
 388:	6a 00                	push   $0x0
 38a:	ff 75 08             	pushl  0x8(%ebp)
 38d:	e8 f0 00 00 00       	call   482 <open>
  if(fd < 0)
 392:	83 c4 10             	add    $0x10,%esp
 395:	85 c0                	test   %eax,%eax
 397:	78 27                	js     3c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 399:	83 ec 08             	sub    $0x8,%esp
 39c:	ff 75 0c             	pushl  0xc(%ebp)
 39f:	89 c3                	mov    %eax,%ebx
 3a1:	50                   	push   %eax
 3a2:	e8 f3 00 00 00       	call   49a <fstat>
 3a7:	89 c6                	mov    %eax,%esi
  close(fd);
 3a9:	89 1c 24             	mov    %ebx,(%esp)
 3ac:	e8 b9 00 00 00       	call   46a <close>
  return r;
 3b1:	83 c4 10             	add    $0x10,%esp
 3b4:	89 f0                	mov    %esi,%eax
}
 3b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3b9:	5b                   	pop    %ebx
 3ba:	5e                   	pop    %esi
 3bb:	5d                   	pop    %ebp
 3bc:	c3                   	ret    
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 3c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3c5:	eb ef                	jmp    3b6 <stat+0x36>
 3c7:	89 f6                	mov    %esi,%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003d0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	53                   	push   %ebx
 3d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3d7:	0f be 11             	movsbl (%ecx),%edx
 3da:	8d 42 d0             	lea    -0x30(%edx),%eax
 3dd:	3c 09                	cmp    $0x9,%al
 3df:	b8 00 00 00 00       	mov    $0x0,%eax
 3e4:	77 1f                	ja     405 <atoi+0x35>
 3e6:	8d 76 00             	lea    0x0(%esi),%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 3f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3f3:	83 c1 01             	add    $0x1,%ecx
 3f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3fa:	0f be 11             	movsbl (%ecx),%edx
 3fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 400:	80 fb 09             	cmp    $0x9,%bl
 403:	76 eb                	jbe    3f0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 405:	5b                   	pop    %ebx
 406:	5d                   	pop    %ebp
 407:	c3                   	ret    
 408:	90                   	nop
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000410 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	56                   	push   %esi
 414:	53                   	push   %ebx
 415:	8b 5d 10             	mov    0x10(%ebp),%ebx
 418:	8b 45 08             	mov    0x8(%ebp),%eax
 41b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 41e:	85 db                	test   %ebx,%ebx
 420:	7e 14                	jle    436 <memmove+0x26>
 422:	31 d2                	xor    %edx,%edx
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 428:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 42c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 42f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 432:	39 da                	cmp    %ebx,%edx
 434:	75 f2                	jne    428 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 436:	5b                   	pop    %ebx
 437:	5e                   	pop    %esi
 438:	5d                   	pop    %ebp
 439:	c3                   	ret    

0000043a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 43a:	b8 01 00 00 00       	mov    $0x1,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <exit>:
SYSCALL(exit)
 442:	b8 02 00 00 00       	mov    $0x2,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <wait>:
SYSCALL(wait)
 44a:	b8 03 00 00 00       	mov    $0x3,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <pipe>:
SYSCALL(pipe)
 452:	b8 04 00 00 00       	mov    $0x4,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <read>:
SYSCALL(read)
 45a:	b8 05 00 00 00       	mov    $0x5,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <write>:
SYSCALL(write)
 462:	b8 10 00 00 00       	mov    $0x10,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <close>:
SYSCALL(close)
 46a:	b8 15 00 00 00       	mov    $0x15,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <kill>:
SYSCALL(kill)
 472:	b8 06 00 00 00       	mov    $0x6,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <exec>:
SYSCALL(exec)
 47a:	b8 07 00 00 00       	mov    $0x7,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <open>:
SYSCALL(open)
 482:	b8 0f 00 00 00       	mov    $0xf,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <mknod>:
SYSCALL(mknod)
 48a:	b8 11 00 00 00       	mov    $0x11,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <unlink>:
SYSCALL(unlink)
 492:	b8 12 00 00 00       	mov    $0x12,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <fstat>:
SYSCALL(fstat)
 49a:	b8 08 00 00 00       	mov    $0x8,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <link>:
SYSCALL(link)
 4a2:	b8 13 00 00 00       	mov    $0x13,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <mkdir>:
SYSCALL(mkdir)
 4aa:	b8 14 00 00 00       	mov    $0x14,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <chdir>:
SYSCALL(chdir)
 4b2:	b8 09 00 00 00       	mov    $0x9,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <dup>:
SYSCALL(dup)
 4ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <getpid>:
SYSCALL(getpid)
 4c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <sbrk>:
SYSCALL(sbrk)
 4ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <sleep>:
SYSCALL(sleep)
 4d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <uptime>:
SYSCALL(uptime)
 4da:	b8 0e 00 00 00       	mov    $0xe,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <kthread_create>:
SYSCALL(kthread_create)
 4e2:	b8 16 00 00 00       	mov    $0x16,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <kthread_id>:
SYSCALL(kthread_id)
 4ea:	b8 17 00 00 00       	mov    $0x17,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <kthread_exit>:
SYSCALL(kthread_exit)
 4f2:	b8 18 00 00 00       	mov    $0x18,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <kthread_join>:
SYSCALL(kthread_join)
 4fa:	b8 19 00 00 00       	mov    $0x19,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 502:	b8 1a 00 00 00       	mov    $0x1a,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 50a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 512:	b8 1c 00 00 00       	mov    $0x1c,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 51a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <procdump>:
 522:	b8 1e 00 00 00       	mov    $0x1e,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    
 52a:	66 90                	xchg   %ax,%ax
 52c:	66 90                	xchg   %ax,%ax
 52e:	66 90                	xchg   %ax,%ax

00000530 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	89 c6                	mov    %eax,%esi
 538:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 53b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 53e:	85 db                	test   %ebx,%ebx
 540:	74 7e                	je     5c0 <printint+0x90>
 542:	89 d0                	mov    %edx,%eax
 544:	c1 e8 1f             	shr    $0x1f,%eax
 547:	84 c0                	test   %al,%al
 549:	74 75                	je     5c0 <printint+0x90>
    neg = 1;
    x = -xx;
 54b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 54d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 554:	f7 d8                	neg    %eax
 556:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 559:	31 ff                	xor    %edi,%edi
 55b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 55e:	89 ce                	mov    %ecx,%esi
 560:	eb 08                	jmp    56a <printint+0x3a>
 562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 568:	89 cf                	mov    %ecx,%edi
 56a:	31 d2                	xor    %edx,%edx
 56c:	8d 4f 01             	lea    0x1(%edi),%ecx
 56f:	f7 f6                	div    %esi
 571:	0f b6 92 50 09 00 00 	movzbl 0x950(%edx),%edx
  }while((x /= base) != 0);
 578:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 57a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 57d:	75 e9                	jne    568 <printint+0x38>
  if(neg)
 57f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 582:	8b 75 c0             	mov    -0x40(%ebp),%esi
 585:	85 c0                	test   %eax,%eax
 587:	74 08                	je     591 <printint+0x61>
    buf[i++] = '-';
 589:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 58e:	8d 4f 02             	lea    0x2(%edi),%ecx
 591:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 595:	8d 76 00             	lea    0x0(%esi),%esi
 598:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 59b:	83 ec 04             	sub    $0x4,%esp
 59e:	83 ef 01             	sub    $0x1,%edi
 5a1:	6a 01                	push   $0x1
 5a3:	53                   	push   %ebx
 5a4:	56                   	push   %esi
 5a5:	88 45 d7             	mov    %al,-0x29(%ebp)
 5a8:	e8 b5 fe ff ff       	call   462 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5ad:	83 c4 10             	add    $0x10,%esp
 5b0:	39 df                	cmp    %ebx,%edi
 5b2:	75 e4                	jne    598 <printint+0x68>
    putc(fd, buf[i]);
}
 5b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b7:	5b                   	pop    %ebx
 5b8:	5e                   	pop    %esi
 5b9:	5f                   	pop    %edi
 5ba:	5d                   	pop    %ebp
 5bb:	c3                   	ret    
 5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5c0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5c2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 5c9:	eb 8b                	jmp    556 <printint+0x26>
 5cb:	90                   	nop
 5cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005d0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	57                   	push   %edi
 5d4:	56                   	push   %esi
 5d5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5d6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5d9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5dc:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5df:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5e2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5e5:	0f b6 1e             	movzbl (%esi),%ebx
 5e8:	83 c6 01             	add    $0x1,%esi
 5eb:	84 db                	test   %bl,%bl
 5ed:	0f 84 b0 00 00 00    	je     6a3 <printf+0xd3>
 5f3:	31 d2                	xor    %edx,%edx
 5f5:	eb 39                	jmp    630 <printf+0x60>
 5f7:	89 f6                	mov    %esi,%esi
 5f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 600:	83 f8 25             	cmp    $0x25,%eax
 603:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 606:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 60b:	74 18                	je     625 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 60d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 610:	83 ec 04             	sub    $0x4,%esp
 613:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 616:	6a 01                	push   $0x1
 618:	50                   	push   %eax
 619:	57                   	push   %edi
 61a:	e8 43 fe ff ff       	call   462 <write>
 61f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 622:	83 c4 10             	add    $0x10,%esp
 625:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 628:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 62c:	84 db                	test   %bl,%bl
 62e:	74 73                	je     6a3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 630:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 632:	0f be cb             	movsbl %bl,%ecx
 635:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 638:	74 c6                	je     600 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 63a:	83 fa 25             	cmp    $0x25,%edx
 63d:	75 e6                	jne    625 <printf+0x55>
      if(c == 'd'){
 63f:	83 f8 64             	cmp    $0x64,%eax
 642:	0f 84 f8 00 00 00    	je     740 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 648:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 64e:	83 f9 70             	cmp    $0x70,%ecx
 651:	74 5d                	je     6b0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 653:	83 f8 73             	cmp    $0x73,%eax
 656:	0f 84 84 00 00 00    	je     6e0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 65c:	83 f8 63             	cmp    $0x63,%eax
 65f:	0f 84 ea 00 00 00    	je     74f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 665:	83 f8 25             	cmp    $0x25,%eax
 668:	0f 84 c2 00 00 00    	je     730 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 66e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 671:	83 ec 04             	sub    $0x4,%esp
 674:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 678:	6a 01                	push   $0x1
 67a:	50                   	push   %eax
 67b:	57                   	push   %edi
 67c:	e8 e1 fd ff ff       	call   462 <write>
 681:	83 c4 0c             	add    $0xc,%esp
 684:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 687:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 68a:	6a 01                	push   $0x1
 68c:	50                   	push   %eax
 68d:	57                   	push   %edi
 68e:	83 c6 01             	add    $0x1,%esi
 691:	e8 cc fd ff ff       	call   462 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 696:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 69a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 69d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 69f:	84 db                	test   %bl,%bl
 6a1:	75 8d                	jne    630 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6a6:	5b                   	pop    %ebx
 6a7:	5e                   	pop    %esi
 6a8:	5f                   	pop    %edi
 6a9:	5d                   	pop    %ebp
 6aa:	c3                   	ret    
 6ab:	90                   	nop
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 6b0:	83 ec 0c             	sub    $0xc,%esp
 6b3:	b9 10 00 00 00       	mov    $0x10,%ecx
 6b8:	6a 00                	push   $0x0
 6ba:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6bd:	89 f8                	mov    %edi,%eax
 6bf:	8b 13                	mov    (%ebx),%edx
 6c1:	e8 6a fe ff ff       	call   530 <printint>
        ap++;
 6c6:	89 d8                	mov    %ebx,%eax
 6c8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6cb:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 6cd:	83 c0 04             	add    $0x4,%eax
 6d0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6d3:	e9 4d ff ff ff       	jmp    625 <printf+0x55>
 6d8:	90                   	nop
 6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 6e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6e3:	8b 18                	mov    (%eax),%ebx
        ap++;
 6e5:	83 c0 04             	add    $0x4,%eax
 6e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 6eb:	b8 46 09 00 00       	mov    $0x946,%eax
 6f0:	85 db                	test   %ebx,%ebx
 6f2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 6f5:	0f b6 03             	movzbl (%ebx),%eax
 6f8:	84 c0                	test   %al,%al
 6fa:	74 23                	je     71f <printf+0x14f>
 6fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 700:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 703:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 706:	83 ec 04             	sub    $0x4,%esp
 709:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 70b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 70e:	50                   	push   %eax
 70f:	57                   	push   %edi
 710:	e8 4d fd ff ff       	call   462 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 715:	0f b6 03             	movzbl (%ebx),%eax
 718:	83 c4 10             	add    $0x10,%esp
 71b:	84 c0                	test   %al,%al
 71d:	75 e1                	jne    700 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 71f:	31 d2                	xor    %edx,%edx
 721:	e9 ff fe ff ff       	jmp    625 <printf+0x55>
 726:	8d 76 00             	lea    0x0(%esi),%esi
 729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 730:	83 ec 04             	sub    $0x4,%esp
 733:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 736:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 739:	6a 01                	push   $0x1
 73b:	e9 4c ff ff ff       	jmp    68c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 740:	83 ec 0c             	sub    $0xc,%esp
 743:	b9 0a 00 00 00       	mov    $0xa,%ecx
 748:	6a 01                	push   $0x1
 74a:	e9 6b ff ff ff       	jmp    6ba <printf+0xea>
 74f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 752:	83 ec 04             	sub    $0x4,%esp
 755:	8b 03                	mov    (%ebx),%eax
 757:	6a 01                	push   $0x1
 759:	88 45 e4             	mov    %al,-0x1c(%ebp)
 75c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 75f:	50                   	push   %eax
 760:	57                   	push   %edi
 761:	e8 fc fc ff ff       	call   462 <write>
 766:	e9 5b ff ff ff       	jmp    6c6 <printf+0xf6>
 76b:	66 90                	xchg   %ax,%ax
 76d:	66 90                	xchg   %ax,%ax
 76f:	90                   	nop

00000770 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 770:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 771:	a1 14 0c 00 00       	mov    0xc14,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 776:	89 e5                	mov    %esp,%ebp
 778:	57                   	push   %edi
 779:	56                   	push   %esi
 77a:	53                   	push   %ebx
 77b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 780:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 783:	39 c8                	cmp    %ecx,%eax
 785:	73 19                	jae    7a0 <free+0x30>
 787:	89 f6                	mov    %esi,%esi
 789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 790:	39 d1                	cmp    %edx,%ecx
 792:	72 1c                	jb     7b0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 794:	39 d0                	cmp    %edx,%eax
 796:	73 18                	jae    7b0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 798:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 79c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79e:	72 f0                	jb     790 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a0:	39 d0                	cmp    %edx,%eax
 7a2:	72 f4                	jb     798 <free+0x28>
 7a4:	39 d1                	cmp    %edx,%ecx
 7a6:	73 f0                	jae    798 <free+0x28>
 7a8:	90                   	nop
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 7b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7b3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7b6:	39 d7                	cmp    %edx,%edi
 7b8:	74 19                	je     7d3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7bd:	8b 50 04             	mov    0x4(%eax),%edx
 7c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7c3:	39 f1                	cmp    %esi,%ecx
 7c5:	74 23                	je     7ea <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7c7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7c9:	a3 14 0c 00 00       	mov    %eax,0xc14
}
 7ce:	5b                   	pop    %ebx
 7cf:	5e                   	pop    %esi
 7d0:	5f                   	pop    %edi
 7d1:	5d                   	pop    %ebp
 7d2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7d3:	03 72 04             	add    0x4(%edx),%esi
 7d6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7d9:	8b 10                	mov    (%eax),%edx
 7db:	8b 12                	mov    (%edx),%edx
 7dd:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7e0:	8b 50 04             	mov    0x4(%eax),%edx
 7e3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7e6:	39 f1                	cmp    %esi,%ecx
 7e8:	75 dd                	jne    7c7 <free+0x57>
    p->s.size += bp->s.size;
 7ea:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 7ed:	a3 14 0c 00 00       	mov    %eax,0xc14
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7f2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7f5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7f8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7fa:	5b                   	pop    %ebx
 7fb:	5e                   	pop    %esi
 7fc:	5f                   	pop    %edi
 7fd:	5d                   	pop    %ebp
 7fe:	c3                   	ret    
 7ff:	90                   	nop

00000800 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	57                   	push   %edi
 804:	56                   	push   %esi
 805:	53                   	push   %ebx
 806:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 809:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 80c:	8b 15 14 0c 00 00    	mov    0xc14,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 812:	8d 78 07             	lea    0x7(%eax),%edi
 815:	c1 ef 03             	shr    $0x3,%edi
 818:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 81b:	85 d2                	test   %edx,%edx
 81d:	0f 84 a3 00 00 00    	je     8c6 <malloc+0xc6>
 823:	8b 02                	mov    (%edx),%eax
 825:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 828:	39 cf                	cmp    %ecx,%edi
 82a:	76 74                	jbe    8a0 <malloc+0xa0>
 82c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 832:	be 00 10 00 00       	mov    $0x1000,%esi
 837:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 83e:	0f 43 f7             	cmovae %edi,%esi
 841:	ba 00 80 00 00       	mov    $0x8000,%edx
 846:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 84c:	0f 46 da             	cmovbe %edx,%ebx
 84f:	eb 10                	jmp    861 <malloc+0x61>
 851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 858:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 85a:	8b 48 04             	mov    0x4(%eax),%ecx
 85d:	39 cf                	cmp    %ecx,%edi
 85f:	76 3f                	jbe    8a0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 861:	39 05 14 0c 00 00    	cmp    %eax,0xc14
 867:	89 c2                	mov    %eax,%edx
 869:	75 ed                	jne    858 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 86b:	83 ec 0c             	sub    $0xc,%esp
 86e:	53                   	push   %ebx
 86f:	e8 56 fc ff ff       	call   4ca <sbrk>
  if(p == (char*)-1)
 874:	83 c4 10             	add    $0x10,%esp
 877:	83 f8 ff             	cmp    $0xffffffff,%eax
 87a:	74 1c                	je     898 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 87c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 87f:	83 ec 0c             	sub    $0xc,%esp
 882:	83 c0 08             	add    $0x8,%eax
 885:	50                   	push   %eax
 886:	e8 e5 fe ff ff       	call   770 <free>
  return freep;
 88b:	8b 15 14 0c 00 00    	mov    0xc14,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 891:	83 c4 10             	add    $0x10,%esp
 894:	85 d2                	test   %edx,%edx
 896:	75 c0                	jne    858 <malloc+0x58>
        return 0;
 898:	31 c0                	xor    %eax,%eax
 89a:	eb 1c                	jmp    8b8 <malloc+0xb8>
 89c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 8a0:	39 cf                	cmp    %ecx,%edi
 8a2:	74 1c                	je     8c0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 8a4:	29 f9                	sub    %edi,%ecx
 8a6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8a9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8ac:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 8af:	89 15 14 0c 00 00    	mov    %edx,0xc14
      return (void*)(p + 1);
 8b5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8bb:	5b                   	pop    %ebx
 8bc:	5e                   	pop    %esi
 8bd:	5f                   	pop    %edi
 8be:	5d                   	pop    %ebp
 8bf:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 8c0:	8b 08                	mov    (%eax),%ecx
 8c2:	89 0a                	mov    %ecx,(%edx)
 8c4:	eb e9                	jmp    8af <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8c6:	c7 05 14 0c 00 00 18 	movl   $0xc18,0xc14
 8cd:	0c 00 00 
 8d0:	c7 05 18 0c 00 00 18 	movl   $0xc18,0xc18
 8d7:	0c 00 00 
    base.s.size = 0;
 8da:	b8 18 0c 00 00       	mov    $0xc18,%eax
 8df:	c7 05 1c 0c 00 00 00 	movl   $0x0,0xc1c
 8e6:	00 00 00 
 8e9:	e9 3e ff ff ff       	jmp    82c <malloc+0x2c>
