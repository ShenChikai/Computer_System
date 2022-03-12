
_threadtest2:     file format elf32-i386


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
   d:	51                   	push   %ecx
   e:	81 ec 0c 0c 00 00    	sub    $0xc0c,%esp
  printf(stdout, "~~~~~~~~~~~~~~~~~~ thread test ~~~~~~~~~~~~~~~~~~\n");
  14:	68 94 0c 00 00       	push   $0xc94
  19:	ff 35 e4 10 00 00    	pushl  0x10e4
  1f:	e8 bc 07 00 00       	call   7e0 <printf>
  pid = getpid();
  24:	e8 a9 06 00 00       	call   6d2 <getpid>
  29:	a3 f4 10 00 00       	mov    %eax,0x10f4

  char stack1[MAX_STACK_SIZE];
  char stack2[MAX_STACK_SIZE];
  char stack3[MAX_STACK_SIZE];
  
  thread_ids[2] = kthread_create(third, stack3, MAX_STACK_SIZE);
  2e:	8d 85 f8 fb ff ff    	lea    -0x408(%ebp),%eax
  34:	83 c4 0c             	add    $0xc,%esp
  37:	68 00 04 00 00       	push   $0x400
  3c:	50                   	push   %eax
  3d:	68 30 03 00 00       	push   $0x330
  42:	e8 ab 06 00 00       	call   6f2 <kthread_create>
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  47:	83 c4 10             	add    $0x10,%esp
  4a:	85 c0                	test   %eax,%eax

  char stack1[MAX_STACK_SIZE];
  char stack2[MAX_STACK_SIZE];
  char stack3[MAX_STACK_SIZE];
  
  thread_ids[2] = kthread_create(third, stack3, MAX_STACK_SIZE);
  4c:	a3 e0 10 00 00       	mov    %eax,0x10e0
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  51:	0f 88 31 01 00 00    	js     188 <main+0x188>
  char stack2[MAX_STACK_SIZE];
  char stack3[MAX_STACK_SIZE];
  
  thread_ids[2] = kthread_create(third, stack3, MAX_STACK_SIZE);
  ASSERT(thread_ids[2] >= 0, "failed to create thread 3");
  thread_ids[1] = kthread_create(second, stack2, MAX_STACK_SIZE);
  57:	8d 85 f8 f7 ff ff    	lea    -0x808(%ebp),%eax
  5d:	83 ec 04             	sub    $0x4,%esp
  60:	68 00 04 00 00       	push   $0x400
  65:	50                   	push   %eax
  66:	68 b0 02 00 00       	push   $0x2b0
  6b:	e8 82 06 00 00       	call   6f2 <kthread_create>
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  70:	83 c4 10             	add    $0x10,%esp
  73:	85 c0                	test   %eax,%eax
  char stack2[MAX_STACK_SIZE];
  char stack3[MAX_STACK_SIZE];
  
  thread_ids[2] = kthread_create(third, stack3, MAX_STACK_SIZE);
  ASSERT(thread_ids[2] >= 0, "failed to create thread 3");
  thread_ids[1] = kthread_create(second, stack2, MAX_STACK_SIZE);
  75:	a3 dc 10 00 00       	mov    %eax,0x10dc
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  7a:	0f 88 1c 01 00 00    	js     19c <main+0x19c>
  
  thread_ids[2] = kthread_create(third, stack3, MAX_STACK_SIZE);
  ASSERT(thread_ids[2] >= 0, "failed to create thread 3");
  thread_ids[1] = kthread_create(second, stack2, MAX_STACK_SIZE);
  ASSERT(thread_ids[1] >= 0, "failed to create thread 2");
  thread_ids[0] = kthread_create(first, stack1, MAX_STACK_SIZE);
  80:	8d 85 f8 f3 ff ff    	lea    -0xc08(%ebp),%eax
  86:	83 ec 04             	sub    $0x4,%esp
  89:	68 00 04 00 00       	push   $0x400
  8e:	50                   	push   %eax
  8f:	68 70 02 00 00       	push   $0x270
  94:	e8 59 06 00 00       	call   6f2 <kthread_create>
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  99:	83 c4 10             	add    $0x10,%esp
  9c:	85 c0                	test   %eax,%eax
  
  thread_ids[2] = kthread_create(third, stack3, MAX_STACK_SIZE);
  ASSERT(thread_ids[2] >= 0, "failed to create thread 3");
  thread_ids[1] = kthread_create(second, stack2, MAX_STACK_SIZE);
  ASSERT(thread_ids[1] >= 0, "failed to create thread 2");
  thread_ids[0] = kthread_create(first, stack1, MAX_STACK_SIZE);
  9e:	a3 d8 10 00 00       	mov    %eax,0x10d8
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  a3:	0f 88 07 01 00 00    	js     1b0 <main+0x1b0>
  thread_ids[1] = kthread_create(second, stack2, MAX_STACK_SIZE);
  ASSERT(thread_ids[1] >= 0, "failed to create thread 2");
  thread_ids[0] = kthread_create(first, stack1, MAX_STACK_SIZE);
  ASSERT(thread_ids[0] >= 0, "failed to create thread 1");

  ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread 1");
  a9:	83 ec 0c             	sub    $0xc,%esp
  ac:	50                   	push   %eax
  ad:	e8 58 06 00 00       	call   70a <kthread_join>
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  b2:	83 c4 10             	add    $0x10,%esp
  b5:	85 c0                	test   %eax,%eax
  b7:	0f 88 0c 01 00 00    	js     1c9 <main+0x1c9>
  ASSERT(thread_ids[1] >= 0, "failed to create thread 2");
  thread_ids[0] = kthread_create(first, stack1, MAX_STACK_SIZE);
  ASSERT(thread_ids[0] >= 0, "failed to create thread 1");

  ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread 1");
  ASSERT(kthread_join(thread_ids[1]) >= 0, "failed to join thread 2");
  bd:	83 ec 0c             	sub    $0xc,%esp
  c0:	ff 35 dc 10 00 00    	pushl  0x10dc
  c6:	e8 3f 06 00 00       	call   70a <kthread_join>
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  cb:	83 c4 10             	add    $0x10,%esp
  ce:	85 c0                	test   %eax,%eax
  d0:	0f 88 07 01 00 00    	js     1dd <main+0x1dd>
  thread_ids[0] = kthread_create(first, stack1, MAX_STACK_SIZE);
  ASSERT(thread_ids[0] >= 0, "failed to create thread 1");

  ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread 1");
  ASSERT(kthread_join(thread_ids[1]) >= 0, "failed to join thread 2");
  ASSERT(kthread_join(thread_ids[2]) >= 0, "failed to join thread 3");
  d6:	83 ec 0c             	sub    $0xc,%esp
  d9:	ff 35 e0 10 00 00    	pushl  0x10e0
  df:	e8 26 06 00 00       	call   70a <kthread_join>
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  e4:	83 c4 10             	add    $0x10,%esp
  e7:	85 c0                	test   %eax,%eax
  e9:	0f 88 02 01 00 00    	js     1f1 <main+0x1f1>
  ASSERT(thread_ids[0] >= 0, "failed to create thread 1");

  ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread 1");
  ASSERT(kthread_join(thread_ids[1]) >= 0, "failed to join thread 2");
  ASSERT(kthread_join(thread_ids[2]) >= 0, "failed to join thread 3");
  printf(stdout, "%s\n", "all threads exited");
  ef:	83 ec 04             	sub    $0x4,%esp
  f2:	68 fc 0b 00 00       	push   $0xbfc
  f7:	68 19 0b 00 00       	push   $0xb19
  fc:	ff 35 e4 10 00 00    	pushl  0x10e4
 102:	e8 d9 06 00 00       	call   7e0 <printf>
  //attempt to join myself
  ASSERT(kthread_join(kthread_id()) < 0, "joining calling thread returns success");
 107:	e8 ee 05 00 00       	call   6fa <kthread_id>
 10c:	89 04 24             	mov    %eax,(%esp)
 10f:	e8 f6 05 00 00       	call   70a <kthread_join>
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 114:	83 c4 10             	add    $0x10,%esp
 117:	85 c0                	test   %eax,%eax
 119:	78 0f                	js     12a <main+0x12a>
 11b:	ba 58 00 00 00       	mov    $0x58,%edx
 120:	b8 c8 0c 00 00       	mov    $0xcc8,%eax
 125:	e8 e6 00 00 00       	call   210 <assert.part.0>
  ASSERT(kthread_join(thread_ids[2]) >= 0, "failed to join thread 3");
  printf(stdout, "%s\n", "all threads exited");
  //attempt to join myself
  ASSERT(kthread_join(kthread_id()) < 0, "joining calling thread returns success");
  //attempt to join an invalid thread id
  ASSERT(kthread_join(-10) < 0, "joining invalid thread returns success");
 12a:	83 ec 0c             	sub    $0xc,%esp
 12d:	6a f6                	push   $0xfffffff6
 12f:	e8 d6 05 00 00       	call   70a <kthread_join>
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 134:	83 c4 10             	add    $0x10,%esp
 137:	85 c0                	test   %eax,%eax
 139:	78 0f                	js     14a <main+0x14a>
 13b:	ba 5a 00 00 00       	mov    $0x5a,%edx
 140:	b8 f0 0c 00 00       	mov    $0xcf0,%eax
 145:	e8 c6 00 00 00       	call   210 <assert.part.0>
  //attempt to join myself
  ASSERT(kthread_join(kthread_id()) < 0, "joining calling thread returns success");
  //attempt to join an invalid thread id
  ASSERT(kthread_join(-10) < 0, "joining invalid thread returns success");
  //attempt to join another process(init)'s thread
  ASSERT(kthread_join(1) < 0, "joining another process's thread returns success");
 14a:	83 ec 0c             	sub    $0xc,%esp
 14d:	6a 01                	push   $0x1
 14f:	e8 b6 05 00 00       	call   70a <kthread_join>
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 154:	83 c4 10             	add    $0x10,%esp
 157:	85 c0                	test   %eax,%eax
 159:	78 0f                	js     16a <main+0x16a>
 15b:	ba 5c 00 00 00       	mov    $0x5c,%edx
 160:	b8 18 0d 00 00       	mov    $0xd18,%eax
 165:	e8 a6 00 00 00       	call   210 <assert.part.0>
  //attempt to join an invalid thread id
  ASSERT(kthread_join(-10) < 0, "joining invalid thread returns success");
  //attempt to join another process(init)'s thread
  ASSERT(kthread_join(1) < 0, "joining another process's thread returns success");
  
  kthread_exit();
 16a:	e8 93 05 00 00       	call   702 <kthread_exit>
 16f:	b8 4c 0d 00 00       	mov    $0xd4c,%eax
 174:	ba 60 00 00 00       	mov    $0x60,%edx
 179:	e8 92 00 00 00       	call   210 <assert.part.0>

  ASSERT(0, "main thread continues to execute after exit");
 17e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
 181:	31 c0                	xor    %eax,%eax
 183:	c9                   	leave  
 184:	8d 61 fc             	lea    -0x4(%ecx),%esp
 187:	c3                   	ret    
 188:	ba 4d 00 00 00       	mov    $0x4d,%edx
 18d:	b8 96 0b 00 00       	mov    $0xb96,%eax
 192:	e8 79 00 00 00       	call   210 <assert.part.0>
 197:	e9 bb fe ff ff       	jmp    57 <main+0x57>
 19c:	ba 4f 00 00 00       	mov    $0x4f,%edx
 1a1:	b8 b0 0b 00 00       	mov    $0xbb0,%eax
 1a6:	e8 65 00 00 00       	call   210 <assert.part.0>
 1ab:	e9 d0 fe ff ff       	jmp    80 <main+0x80>
 1b0:	b8 ca 0b 00 00       	mov    $0xbca,%eax
 1b5:	ba 51 00 00 00       	mov    $0x51,%edx
 1ba:	e8 51 00 00 00       	call   210 <assert.part.0>
 1bf:	a1 d8 10 00 00       	mov    0x10d8,%eax
 1c4:	e9 e0 fe ff ff       	jmp    a9 <main+0xa9>
 1c9:	ba 53 00 00 00       	mov    $0x53,%edx
 1ce:	b8 3e 0b 00 00       	mov    $0xb3e,%eax
 1d3:	e8 38 00 00 00       	call   210 <assert.part.0>
 1d8:	e9 e0 fe ff ff       	jmp    bd <main+0xbd>
 1dd:	ba 54 00 00 00       	mov    $0x54,%edx
 1e2:	b8 6a 0b 00 00       	mov    $0xb6a,%eax
 1e7:	e8 24 00 00 00       	call   210 <assert.part.0>
 1ec:	e9 e5 fe ff ff       	jmp    d6 <main+0xd6>
 1f1:	ba 55 00 00 00       	mov    $0x55,%edx
 1f6:	b8 e4 0b 00 00       	mov    $0xbe4,%eax
 1fb:	e8 10 00 00 00       	call   210 <assert.part.0>
 200:	e9 ea fe ff ff       	jmp    ef <main+0xef>
 205:	66 90                	xchg   %ax,%ax
 207:	66 90                	xchg   %ax,%ax
 209:	66 90                	xchg   %ax,%ax
 20b:	66 90                	xchg   %ax,%ax
 20d:	66 90                	xchg   %ax,%ax
 20f:	90                   	nop

00000210 <assert.part.0>:
int stdout = 1;
int pid;
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	89 c3                	mov    %eax,%ebx
 216:	83 ec 04             	sub    $0x4,%esp
{
	if(!assumption)
	{
		printf(stdout, "at %s:%d, ", __FILE__, curLine);
 219:	52                   	push   %edx
 21a:	68 00 0b 00 00       	push   $0xb00
 21f:	68 0e 0b 00 00       	push   $0xb0e
 224:	ff 35 e4 10 00 00    	pushl  0x10e4
 22a:	e8 b1 05 00 00       	call   7e0 <printf>
		printf(stdout, "%s\n", errMsg);
 22f:	83 c4 0c             	add    $0xc,%esp
 232:	53                   	push   %ebx
 233:	68 19 0b 00 00       	push   $0xb19
 238:	ff 35 e4 10 00 00    	pushl  0x10e4
 23e:	e8 9d 05 00 00       	call   7e0 <printf>
		printf(stdout, "test failed\n");
 243:	58                   	pop    %eax
 244:	5a                   	pop    %edx
 245:	68 1d 0b 00 00       	push   $0xb1d
 24a:	ff 35 e4 10 00 00    	pushl  0x10e4
 250:	e8 8b 05 00 00       	call   7e0 <printf>
		kill(pid);
 255:	59                   	pop    %ecx
 256:	ff 35 f4 10 00 00    	pushl  0x10f4
 25c:	e8 21 04 00 00       	call   682 <kill>
 261:	83 c4 10             	add    $0x10,%esp
	}
}
 264:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 267:	c9                   	leave  
 268:	c3                   	ret    
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000270 <first>:

void*
first(void)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	83 ec 0c             	sub    $0xc,%esp
	printf(stdout, "%s\n", "thread 1 says hello");
 276:	68 2a 0b 00 00       	push   $0xb2a
 27b:	68 19 0b 00 00       	push   $0xb19
 280:	ff 35 e4 10 00 00    	pushl  0x10e4
 286:	e8 55 05 00 00       	call   7e0 <printf>
  sleep(2 * TIME_SLICE); //sleep for some scheduling rounds instead of immediately exiting so that others can join
 28b:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
 292:	e8 4b 04 00 00       	call   6e2 <sleep>
	kthread_exit();
 297:	e8 66 04 00 00       	call   702 <kthread_exit>
 29c:	b8 10 0c 00 00       	mov    $0xc10,%eax
 2a1:	ba 21 00 00 00       	mov    $0x21,%edx
 2a6:	e8 65 ff ff ff       	call   210 <assert.part.0>

  ASSERT(0, "thread 1 continues to execute after exit");
  	return 0;
}
 2ab:	31 c0                	xor    %eax,%eax
 2ad:	c9                   	leave  
 2ae:	c3                   	ret    
 2af:	90                   	nop

000002b0 <second>:

void*
second(void)
{
 2b0:	a1 d8 10 00 00       	mov    0x10d8,%eax
 2b5:	8d 76 00             	lea    0x0(%esi),%esi
	while(thread_ids[0]<0); //wait for the first thread to be created
 2b8:	85 c0                	test   %eax,%eax
 2ba:	78 fc                	js     2b8 <second+0x8>
  	return 0;
}

void*
second(void)
{
 2bc:	55                   	push   %ebp
 2bd:	89 e5                	mov    %esp,%ebp
 2bf:	83 ec 14             	sub    $0x14,%esp
	while(thread_ids[0]<0); //wait for the first thread to be created
	ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread 1");
 2c2:	50                   	push   %eax
 2c3:	e8 42 04 00 00       	call   70a <kthread_join>
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 2c8:	83 c4 10             	add    $0x10,%esp
 2cb:	85 c0                	test   %eax,%eax
 2cd:	78 41                	js     310 <second+0x60>
second(void)
{
	while(thread_ids[0]<0); //wait for the first thread to be created
	ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread 1");

	printf(stdout, "%s\n", "thread 2 says hello");
 2cf:	83 ec 04             	sub    $0x4,%esp
 2d2:	68 56 0b 00 00       	push   $0xb56
 2d7:	68 19 0b 00 00       	push   $0xb19
 2dc:	ff 35 e4 10 00 00    	pushl  0x10e4
 2e2:	e8 f9 04 00 00       	call   7e0 <printf>
  sleep(2 * TIME_SLICE); //sleep for some scheduling rounds instead of immediately exiting so that others can join
 2e7:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
 2ee:	e8 ef 03 00 00       	call   6e2 <sleep>
	kthread_exit();
 2f3:	e8 0a 04 00 00       	call   702 <kthread_exit>
 2f8:	b8 3c 0c 00 00       	mov    $0xc3c,%eax
 2fd:	ba 2f 00 00 00       	mov    $0x2f,%edx
 302:	e8 09 ff ff ff       	call   210 <assert.part.0>

  ASSERT(0, "thread 2 continues to execute after exit");
  	return 0;
}
 307:	31 c0                	xor    %eax,%eax
 309:	c9                   	leave  
 30a:	c3                   	ret    
 30b:	90                   	nop
 30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 310:	ba 29 00 00 00       	mov    $0x29,%edx
 315:	b8 3e 0b 00 00       	mov    $0xb3e,%eax
 31a:	e8 f1 fe ff ff       	call   210 <assert.part.0>
 31f:	eb ae                	jmp    2cf <second+0x1f>
 321:	eb 0d                	jmp    330 <third>
 323:	90                   	nop
 324:	90                   	nop
 325:	90                   	nop
 326:	90                   	nop
 327:	90                   	nop
 328:	90                   	nop
 329:	90                   	nop
 32a:	90                   	nop
 32b:	90                   	nop
 32c:	90                   	nop
 32d:	90                   	nop
 32e:	90                   	nop
 32f:	90                   	nop

00000330 <third>:

void*
third(void)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	83 ec 08             	sub    $0x8,%esp
 336:	a1 d8 10 00 00       	mov    0x10d8,%eax
	while(thread_ids[0]<0 && thread_ids[1]<0); //wait for the first two threads to be created
 33b:	8b 15 dc 10 00 00    	mov    0x10dc,%edx
 341:	eb 09                	jmp    34c <third+0x1c>
 343:	90                   	nop
 344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 348:	85 d2                	test   %edx,%edx
 34a:	79 04                	jns    350 <third+0x20>
 34c:	85 c0                	test   %eax,%eax
 34e:	78 f8                	js     348 <third+0x18>
	ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread 1");
 350:	83 ec 0c             	sub    $0xc,%esp
 353:	50                   	push   %eax
 354:	e8 b1 03 00 00       	call   70a <kthread_join>
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 359:	83 c4 10             	add    $0x10,%esp
 35c:	85 c0                	test   %eax,%eax
 35e:	78 70                	js     3d0 <third+0xa0>
void*
third(void)
{
	while(thread_ids[0]<0 && thread_ids[1]<0); //wait for the first two threads to be created
	ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread 1");
	ASSERT(kthread_join(thread_ids[1]) >= 0, "failed to join thread 2");
 360:	83 ec 0c             	sub    $0xc,%esp
 363:	ff 35 dc 10 00 00    	pushl  0x10dc
 369:	e8 9c 03 00 00       	call   70a <kthread_join>
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 36e:	83 c4 10             	add    $0x10,%esp
 371:	85 c0                	test   %eax,%eax
 373:	78 43                	js     3b8 <third+0x88>
{
	while(thread_ids[0]<0 && thread_ids[1]<0); //wait for the first two threads to be created
	ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread 1");
	ASSERT(kthread_join(thread_ids[1]) >= 0, "failed to join thread 2");

	printf(stdout, "%s\n", "thread 3 says hello");
 375:	83 ec 04             	sub    $0x4,%esp
 378:	68 82 0b 00 00       	push   $0xb82
 37d:	68 19 0b 00 00       	push   $0xb19
 382:	ff 35 e4 10 00 00    	pushl  0x10e4
 388:	e8 53 04 00 00       	call   7e0 <printf>
  sleep(2 * TIME_SLICE); //sleep for some scheduling rounds instead of immediately exiting so that others can join
 38d:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
 394:	e8 49 03 00 00       	call   6e2 <sleep>
	kthread_exit();
 399:	e8 64 03 00 00       	call   702 <kthread_exit>
 39e:	b8 68 0c 00 00       	mov    $0xc68,%eax
 3a3:	ba 3e 00 00 00       	mov    $0x3e,%edx
 3a8:	e8 63 fe ff ff       	call   210 <assert.part.0>

  ASSERT(0, "thread 3 continues to execute after exit");
  	return 0;
}
 3ad:	31 c0                	xor    %eax,%eax
 3af:	c9                   	leave  
 3b0:	c3                   	ret    
 3b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3b8:	ba 38 00 00 00       	mov    $0x38,%edx
 3bd:	b8 6a 0b 00 00       	mov    $0xb6a,%eax
 3c2:	e8 49 fe ff ff       	call   210 <assert.part.0>
 3c7:	eb ac                	jmp    375 <third+0x45>
 3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3d0:	ba 37 00 00 00       	mov    $0x37,%edx
 3d5:	b8 3e 0b 00 00       	mov    $0xb3e,%eax
 3da:	e8 31 fe ff ff       	call   210 <assert.part.0>
 3df:	e9 7c ff ff ff       	jmp    360 <third+0x30>
 3e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003f0 <assert>:
int pid;
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
	if(!assumption)
 3f3:	80 7d 08 00          	cmpb   $0x0,0x8(%ebp)
int pid;
int thread_ids[3] = {-1,-1,-1};

void
assert(_Bool assumption, char* errMsg, int curLine)
{
 3f7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fa:	8b 55 10             	mov    0x10(%ebp),%edx
	if(!assumption)
 3fd:	74 09                	je     408 <assert+0x18>
		printf(stdout, "at %s:%d, ", __FILE__, curLine);
		printf(stdout, "%s\n", errMsg);
		printf(stdout, "test failed\n");
		kill(pid);
	}
}
 3ff:	5d                   	pop    %ebp
 400:	c3                   	ret    
 401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 408:	5d                   	pop    %ebp
 409:	e9 02 fe ff ff       	jmp    210 <assert.part.0>
 40e:	66 90                	xchg   %ax,%ax

00000410 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	53                   	push   %ebx
 414:	8b 45 08             	mov    0x8(%ebp),%eax
 417:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 41a:	89 c2                	mov    %eax,%edx
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 420:	83 c1 01             	add    $0x1,%ecx
 423:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 427:	83 c2 01             	add    $0x1,%edx
 42a:	84 db                	test   %bl,%bl
 42c:	88 5a ff             	mov    %bl,-0x1(%edx)
 42f:	75 ef                	jne    420 <strcpy+0x10>
    ;
  return os;
}
 431:	5b                   	pop    %ebx
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    
 434:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 43a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000440 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	56                   	push   %esi
 444:	53                   	push   %ebx
 445:	8b 55 08             	mov    0x8(%ebp),%edx
 448:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 44b:	0f b6 02             	movzbl (%edx),%eax
 44e:	0f b6 19             	movzbl (%ecx),%ebx
 451:	84 c0                	test   %al,%al
 453:	75 1e                	jne    473 <strcmp+0x33>
 455:	eb 29                	jmp    480 <strcmp+0x40>
 457:	89 f6                	mov    %esi,%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 460:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 463:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 466:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 469:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 46d:	84 c0                	test   %al,%al
 46f:	74 0f                	je     480 <strcmp+0x40>
 471:	89 f1                	mov    %esi,%ecx
 473:	38 d8                	cmp    %bl,%al
 475:	74 e9                	je     460 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 477:	29 d8                	sub    %ebx,%eax
}
 479:	5b                   	pop    %ebx
 47a:	5e                   	pop    %esi
 47b:	5d                   	pop    %ebp
 47c:	c3                   	ret    
 47d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 480:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 482:	29 d8                	sub    %ebx,%eax
}
 484:	5b                   	pop    %ebx
 485:	5e                   	pop    %esi
 486:	5d                   	pop    %ebp
 487:	c3                   	ret    
 488:	90                   	nop
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000490 <strlen>:

uint
strlen(char *s)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 496:	80 39 00             	cmpb   $0x0,(%ecx)
 499:	74 12                	je     4ad <strlen+0x1d>
 49b:	31 d2                	xor    %edx,%edx
 49d:	8d 76 00             	lea    0x0(%esi),%esi
 4a0:	83 c2 01             	add    $0x1,%edx
 4a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 4a7:	89 d0                	mov    %edx,%eax
 4a9:	75 f5                	jne    4a0 <strlen+0x10>
    ;
  return n;
}
 4ab:	5d                   	pop    %ebp
 4ac:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 4ad:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 4af:	5d                   	pop    %ebp
 4b0:	c3                   	ret    
 4b1:	eb 0d                	jmp    4c0 <memset>
 4b3:	90                   	nop
 4b4:	90                   	nop
 4b5:	90                   	nop
 4b6:	90                   	nop
 4b7:	90                   	nop
 4b8:	90                   	nop
 4b9:	90                   	nop
 4ba:	90                   	nop
 4bb:	90                   	nop
 4bc:	90                   	nop
 4bd:	90                   	nop
 4be:	90                   	nop
 4bf:	90                   	nop

000004c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 4c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 4cd:	89 d7                	mov    %edx,%edi
 4cf:	fc                   	cld    
 4d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 4d2:	89 d0                	mov    %edx,%eax
 4d4:	5f                   	pop    %edi
 4d5:	5d                   	pop    %ebp
 4d6:	c3                   	ret    
 4d7:	89 f6                	mov    %esi,%esi
 4d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004e0 <strchr>:

char*
strchr(const char *s, char c)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	53                   	push   %ebx
 4e4:	8b 45 08             	mov    0x8(%ebp),%eax
 4e7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 4ea:	0f b6 10             	movzbl (%eax),%edx
 4ed:	84 d2                	test   %dl,%dl
 4ef:	74 1d                	je     50e <strchr+0x2e>
    if(*s == c)
 4f1:	38 d3                	cmp    %dl,%bl
 4f3:	89 d9                	mov    %ebx,%ecx
 4f5:	75 0d                	jne    504 <strchr+0x24>
 4f7:	eb 17                	jmp    510 <strchr+0x30>
 4f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 500:	38 ca                	cmp    %cl,%dl
 502:	74 0c                	je     510 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 504:	83 c0 01             	add    $0x1,%eax
 507:	0f b6 10             	movzbl (%eax),%edx
 50a:	84 d2                	test   %dl,%dl
 50c:	75 f2                	jne    500 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 50e:	31 c0                	xor    %eax,%eax
}
 510:	5b                   	pop    %ebx
 511:	5d                   	pop    %ebp
 512:	c3                   	ret    
 513:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000520 <gets>:

char*
gets(char *buf, int max)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 526:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 528:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 52b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 52e:	eb 29                	jmp    559 <gets+0x39>
    cc = read(0, &c, 1);
 530:	83 ec 04             	sub    $0x4,%esp
 533:	6a 01                	push   $0x1
 535:	57                   	push   %edi
 536:	6a 00                	push   $0x0
 538:	e8 2d 01 00 00       	call   66a <read>
    if(cc < 1)
 53d:	83 c4 10             	add    $0x10,%esp
 540:	85 c0                	test   %eax,%eax
 542:	7e 1d                	jle    561 <gets+0x41>
      break;
    buf[i++] = c;
 544:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 548:	8b 55 08             	mov    0x8(%ebp),%edx
 54b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 54d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 54f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 553:	74 1b                	je     570 <gets+0x50>
 555:	3c 0d                	cmp    $0xd,%al
 557:	74 17                	je     570 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 559:	8d 5e 01             	lea    0x1(%esi),%ebx
 55c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 55f:	7c cf                	jl     530 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 561:	8b 45 08             	mov    0x8(%ebp),%eax
 564:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 568:	8d 65 f4             	lea    -0xc(%ebp),%esp
 56b:	5b                   	pop    %ebx
 56c:	5e                   	pop    %esi
 56d:	5f                   	pop    %edi
 56e:	5d                   	pop    %ebp
 56f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 570:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 573:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 575:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 579:	8d 65 f4             	lea    -0xc(%ebp),%esp
 57c:	5b                   	pop    %ebx
 57d:	5e                   	pop    %esi
 57e:	5f                   	pop    %edi
 57f:	5d                   	pop    %ebp
 580:	c3                   	ret    
 581:	eb 0d                	jmp    590 <stat>
 583:	90                   	nop
 584:	90                   	nop
 585:	90                   	nop
 586:	90                   	nop
 587:	90                   	nop
 588:	90                   	nop
 589:	90                   	nop
 58a:	90                   	nop
 58b:	90                   	nop
 58c:	90                   	nop
 58d:	90                   	nop
 58e:	90                   	nop
 58f:	90                   	nop

00000590 <stat>:

int
stat(char *n, struct stat *st)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	56                   	push   %esi
 594:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 595:	83 ec 08             	sub    $0x8,%esp
 598:	6a 00                	push   $0x0
 59a:	ff 75 08             	pushl  0x8(%ebp)
 59d:	e8 f0 00 00 00       	call   692 <open>
  if(fd < 0)
 5a2:	83 c4 10             	add    $0x10,%esp
 5a5:	85 c0                	test   %eax,%eax
 5a7:	78 27                	js     5d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 5a9:	83 ec 08             	sub    $0x8,%esp
 5ac:	ff 75 0c             	pushl  0xc(%ebp)
 5af:	89 c3                	mov    %eax,%ebx
 5b1:	50                   	push   %eax
 5b2:	e8 f3 00 00 00       	call   6aa <fstat>
 5b7:	89 c6                	mov    %eax,%esi
  close(fd);
 5b9:	89 1c 24             	mov    %ebx,(%esp)
 5bc:	e8 b9 00 00 00       	call   67a <close>
  return r;
 5c1:	83 c4 10             	add    $0x10,%esp
 5c4:	89 f0                	mov    %esi,%eax
}
 5c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 5c9:	5b                   	pop    %ebx
 5ca:	5e                   	pop    %esi
 5cb:	5d                   	pop    %ebp
 5cc:	c3                   	ret    
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 5d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 5d5:	eb ef                	jmp    5c6 <stat+0x36>
 5d7:	89 f6                	mov    %esi,%esi
 5d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005e0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	53                   	push   %ebx
 5e4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5e7:	0f be 11             	movsbl (%ecx),%edx
 5ea:	8d 42 d0             	lea    -0x30(%edx),%eax
 5ed:	3c 09                	cmp    $0x9,%al
 5ef:	b8 00 00 00 00       	mov    $0x0,%eax
 5f4:	77 1f                	ja     615 <atoi+0x35>
 5f6:	8d 76 00             	lea    0x0(%esi),%esi
 5f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 600:	8d 04 80             	lea    (%eax,%eax,4),%eax
 603:	83 c1 01             	add    $0x1,%ecx
 606:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 60a:	0f be 11             	movsbl (%ecx),%edx
 60d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 610:	80 fb 09             	cmp    $0x9,%bl
 613:	76 eb                	jbe    600 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 615:	5b                   	pop    %ebx
 616:	5d                   	pop    %ebp
 617:	c3                   	ret    
 618:	90                   	nop
 619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000620 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	56                   	push   %esi
 624:	53                   	push   %ebx
 625:	8b 5d 10             	mov    0x10(%ebp),%ebx
 628:	8b 45 08             	mov    0x8(%ebp),%eax
 62b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 62e:	85 db                	test   %ebx,%ebx
 630:	7e 14                	jle    646 <memmove+0x26>
 632:	31 d2                	xor    %edx,%edx
 634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 638:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 63c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 63f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 642:	39 da                	cmp    %ebx,%edx
 644:	75 f2                	jne    638 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 646:	5b                   	pop    %ebx
 647:	5e                   	pop    %esi
 648:	5d                   	pop    %ebp
 649:	c3                   	ret    

0000064a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 64a:	b8 01 00 00 00       	mov    $0x1,%eax
 64f:	cd 40                	int    $0x40
 651:	c3                   	ret    

00000652 <exit>:
SYSCALL(exit)
 652:	b8 02 00 00 00       	mov    $0x2,%eax
 657:	cd 40                	int    $0x40
 659:	c3                   	ret    

0000065a <wait>:
SYSCALL(wait)
 65a:	b8 03 00 00 00       	mov    $0x3,%eax
 65f:	cd 40                	int    $0x40
 661:	c3                   	ret    

00000662 <pipe>:
SYSCALL(pipe)
 662:	b8 04 00 00 00       	mov    $0x4,%eax
 667:	cd 40                	int    $0x40
 669:	c3                   	ret    

0000066a <read>:
SYSCALL(read)
 66a:	b8 05 00 00 00       	mov    $0x5,%eax
 66f:	cd 40                	int    $0x40
 671:	c3                   	ret    

00000672 <write>:
SYSCALL(write)
 672:	b8 10 00 00 00       	mov    $0x10,%eax
 677:	cd 40                	int    $0x40
 679:	c3                   	ret    

0000067a <close>:
SYSCALL(close)
 67a:	b8 15 00 00 00       	mov    $0x15,%eax
 67f:	cd 40                	int    $0x40
 681:	c3                   	ret    

00000682 <kill>:
SYSCALL(kill)
 682:	b8 06 00 00 00       	mov    $0x6,%eax
 687:	cd 40                	int    $0x40
 689:	c3                   	ret    

0000068a <exec>:
SYSCALL(exec)
 68a:	b8 07 00 00 00       	mov    $0x7,%eax
 68f:	cd 40                	int    $0x40
 691:	c3                   	ret    

00000692 <open>:
SYSCALL(open)
 692:	b8 0f 00 00 00       	mov    $0xf,%eax
 697:	cd 40                	int    $0x40
 699:	c3                   	ret    

0000069a <mknod>:
SYSCALL(mknod)
 69a:	b8 11 00 00 00       	mov    $0x11,%eax
 69f:	cd 40                	int    $0x40
 6a1:	c3                   	ret    

000006a2 <unlink>:
SYSCALL(unlink)
 6a2:	b8 12 00 00 00       	mov    $0x12,%eax
 6a7:	cd 40                	int    $0x40
 6a9:	c3                   	ret    

000006aa <fstat>:
SYSCALL(fstat)
 6aa:	b8 08 00 00 00       	mov    $0x8,%eax
 6af:	cd 40                	int    $0x40
 6b1:	c3                   	ret    

000006b2 <link>:
SYSCALL(link)
 6b2:	b8 13 00 00 00       	mov    $0x13,%eax
 6b7:	cd 40                	int    $0x40
 6b9:	c3                   	ret    

000006ba <mkdir>:
SYSCALL(mkdir)
 6ba:	b8 14 00 00 00       	mov    $0x14,%eax
 6bf:	cd 40                	int    $0x40
 6c1:	c3                   	ret    

000006c2 <chdir>:
SYSCALL(chdir)
 6c2:	b8 09 00 00 00       	mov    $0x9,%eax
 6c7:	cd 40                	int    $0x40
 6c9:	c3                   	ret    

000006ca <dup>:
SYSCALL(dup)
 6ca:	b8 0a 00 00 00       	mov    $0xa,%eax
 6cf:	cd 40                	int    $0x40
 6d1:	c3                   	ret    

000006d2 <getpid>:
SYSCALL(getpid)
 6d2:	b8 0b 00 00 00       	mov    $0xb,%eax
 6d7:	cd 40                	int    $0x40
 6d9:	c3                   	ret    

000006da <sbrk>:
SYSCALL(sbrk)
 6da:	b8 0c 00 00 00       	mov    $0xc,%eax
 6df:	cd 40                	int    $0x40
 6e1:	c3                   	ret    

000006e2 <sleep>:
SYSCALL(sleep)
 6e2:	b8 0d 00 00 00       	mov    $0xd,%eax
 6e7:	cd 40                	int    $0x40
 6e9:	c3                   	ret    

000006ea <uptime>:
SYSCALL(uptime)
 6ea:	b8 0e 00 00 00       	mov    $0xe,%eax
 6ef:	cd 40                	int    $0x40
 6f1:	c3                   	ret    

000006f2 <kthread_create>:
SYSCALL(kthread_create)
 6f2:	b8 16 00 00 00       	mov    $0x16,%eax
 6f7:	cd 40                	int    $0x40
 6f9:	c3                   	ret    

000006fa <kthread_id>:
SYSCALL(kthread_id)
 6fa:	b8 17 00 00 00       	mov    $0x17,%eax
 6ff:	cd 40                	int    $0x40
 701:	c3                   	ret    

00000702 <kthread_exit>:
SYSCALL(kthread_exit)
 702:	b8 18 00 00 00       	mov    $0x18,%eax
 707:	cd 40                	int    $0x40
 709:	c3                   	ret    

0000070a <kthread_join>:
SYSCALL(kthread_join)
 70a:	b8 19 00 00 00       	mov    $0x19,%eax
 70f:	cd 40                	int    $0x40
 711:	c3                   	ret    

00000712 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 712:	b8 1a 00 00 00       	mov    $0x1a,%eax
 717:	cd 40                	int    $0x40
 719:	c3                   	ret    

0000071a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 71a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 71f:	cd 40                	int    $0x40
 721:	c3                   	ret    

00000722 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 722:	b8 1c 00 00 00       	mov    $0x1c,%eax
 727:	cd 40                	int    $0x40
 729:	c3                   	ret    

0000072a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 72a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 72f:	cd 40                	int    $0x40
 731:	c3                   	ret    

00000732 <procdump>:
 732:	b8 1e 00 00 00       	mov    $0x1e,%eax
 737:	cd 40                	int    $0x40
 739:	c3                   	ret    
 73a:	66 90                	xchg   %ax,%ax
 73c:	66 90                	xchg   %ax,%ax
 73e:	66 90                	xchg   %ax,%ax

00000740 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	57                   	push   %edi
 744:	56                   	push   %esi
 745:	53                   	push   %ebx
 746:	89 c6                	mov    %eax,%esi
 748:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 74b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 74e:	85 db                	test   %ebx,%ebx
 750:	74 7e                	je     7d0 <printint+0x90>
 752:	89 d0                	mov    %edx,%eax
 754:	c1 e8 1f             	shr    $0x1f,%eax
 757:	84 c0                	test   %al,%al
 759:	74 75                	je     7d0 <printint+0x90>
    neg = 1;
    x = -xx;
 75b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 75d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 764:	f7 d8                	neg    %eax
 766:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 769:	31 ff                	xor    %edi,%edi
 76b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 76e:	89 ce                	mov    %ecx,%esi
 770:	eb 08                	jmp    77a <printint+0x3a>
 772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 778:	89 cf                	mov    %ecx,%edi
 77a:	31 d2                	xor    %edx,%edx
 77c:	8d 4f 01             	lea    0x1(%edi),%ecx
 77f:	f7 f6                	div    %esi
 781:	0f b6 92 80 0d 00 00 	movzbl 0xd80(%edx),%edx
  }while((x /= base) != 0);
 788:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 78a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 78d:	75 e9                	jne    778 <printint+0x38>
  if(neg)
 78f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 792:	8b 75 c0             	mov    -0x40(%ebp),%esi
 795:	85 c0                	test   %eax,%eax
 797:	74 08                	je     7a1 <printint+0x61>
    buf[i++] = '-';
 799:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 79e:	8d 4f 02             	lea    0x2(%edi),%ecx
 7a1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 7a5:	8d 76 00             	lea    0x0(%esi),%esi
 7a8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7ab:	83 ec 04             	sub    $0x4,%esp
 7ae:	83 ef 01             	sub    $0x1,%edi
 7b1:	6a 01                	push   $0x1
 7b3:	53                   	push   %ebx
 7b4:	56                   	push   %esi
 7b5:	88 45 d7             	mov    %al,-0x29(%ebp)
 7b8:	e8 b5 fe ff ff       	call   672 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 7bd:	83 c4 10             	add    $0x10,%esp
 7c0:	39 df                	cmp    %ebx,%edi
 7c2:	75 e4                	jne    7a8 <printint+0x68>
    putc(fd, buf[i]);
}
 7c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7c7:	5b                   	pop    %ebx
 7c8:	5e                   	pop    %esi
 7c9:	5f                   	pop    %edi
 7ca:	5d                   	pop    %ebp
 7cb:	c3                   	ret    
 7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7d0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 7d2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 7d9:	eb 8b                	jmp    766 <printint+0x26>
 7db:	90                   	nop
 7dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007e0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7e6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 7e9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7ec:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 7ef:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7f2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 7f5:	0f b6 1e             	movzbl (%esi),%ebx
 7f8:	83 c6 01             	add    $0x1,%esi
 7fb:	84 db                	test   %bl,%bl
 7fd:	0f 84 b0 00 00 00    	je     8b3 <printf+0xd3>
 803:	31 d2                	xor    %edx,%edx
 805:	eb 39                	jmp    840 <printf+0x60>
 807:	89 f6                	mov    %esi,%esi
 809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 810:	83 f8 25             	cmp    $0x25,%eax
 813:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 816:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 81b:	74 18                	je     835 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 81d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 820:	83 ec 04             	sub    $0x4,%esp
 823:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 826:	6a 01                	push   $0x1
 828:	50                   	push   %eax
 829:	57                   	push   %edi
 82a:	e8 43 fe ff ff       	call   672 <write>
 82f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 832:	83 c4 10             	add    $0x10,%esp
 835:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 838:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 83c:	84 db                	test   %bl,%bl
 83e:	74 73                	je     8b3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 840:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 842:	0f be cb             	movsbl %bl,%ecx
 845:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 848:	74 c6                	je     810 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 84a:	83 fa 25             	cmp    $0x25,%edx
 84d:	75 e6                	jne    835 <printf+0x55>
      if(c == 'd'){
 84f:	83 f8 64             	cmp    $0x64,%eax
 852:	0f 84 f8 00 00 00    	je     950 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 858:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 85e:	83 f9 70             	cmp    $0x70,%ecx
 861:	74 5d                	je     8c0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 863:	83 f8 73             	cmp    $0x73,%eax
 866:	0f 84 84 00 00 00    	je     8f0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 86c:	83 f8 63             	cmp    $0x63,%eax
 86f:	0f 84 ea 00 00 00    	je     95f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 875:	83 f8 25             	cmp    $0x25,%eax
 878:	0f 84 c2 00 00 00    	je     940 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 87e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 881:	83 ec 04             	sub    $0x4,%esp
 884:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 888:	6a 01                	push   $0x1
 88a:	50                   	push   %eax
 88b:	57                   	push   %edi
 88c:	e8 e1 fd ff ff       	call   672 <write>
 891:	83 c4 0c             	add    $0xc,%esp
 894:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 897:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 89a:	6a 01                	push   $0x1
 89c:	50                   	push   %eax
 89d:	57                   	push   %edi
 89e:	83 c6 01             	add    $0x1,%esi
 8a1:	e8 cc fd ff ff       	call   672 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8a6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 8aa:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8ad:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8af:	84 db                	test   %bl,%bl
 8b1:	75 8d                	jne    840 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 8b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8b6:	5b                   	pop    %ebx
 8b7:	5e                   	pop    %esi
 8b8:	5f                   	pop    %edi
 8b9:	5d                   	pop    %ebp
 8ba:	c3                   	ret    
 8bb:	90                   	nop
 8bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 8c0:	83 ec 0c             	sub    $0xc,%esp
 8c3:	b9 10 00 00 00       	mov    $0x10,%ecx
 8c8:	6a 00                	push   $0x0
 8ca:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 8cd:	89 f8                	mov    %edi,%eax
 8cf:	8b 13                	mov    (%ebx),%edx
 8d1:	e8 6a fe ff ff       	call   740 <printint>
        ap++;
 8d6:	89 d8                	mov    %ebx,%eax
 8d8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8db:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 8dd:	83 c0 04             	add    $0x4,%eax
 8e0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 8e3:	e9 4d ff ff ff       	jmp    835 <printf+0x55>
 8e8:	90                   	nop
 8e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 8f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 8f3:	8b 18                	mov    (%eax),%ebx
        ap++;
 8f5:	83 c0 04             	add    $0x4,%eax
 8f8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 8fb:	b8 78 0d 00 00       	mov    $0xd78,%eax
 900:	85 db                	test   %ebx,%ebx
 902:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 905:	0f b6 03             	movzbl (%ebx),%eax
 908:	84 c0                	test   %al,%al
 90a:	74 23                	je     92f <printf+0x14f>
 90c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 910:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 913:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 916:	83 ec 04             	sub    $0x4,%esp
 919:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 91b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 91e:	50                   	push   %eax
 91f:	57                   	push   %edi
 920:	e8 4d fd ff ff       	call   672 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 925:	0f b6 03             	movzbl (%ebx),%eax
 928:	83 c4 10             	add    $0x10,%esp
 92b:	84 c0                	test   %al,%al
 92d:	75 e1                	jne    910 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 92f:	31 d2                	xor    %edx,%edx
 931:	e9 ff fe ff ff       	jmp    835 <printf+0x55>
 936:	8d 76 00             	lea    0x0(%esi),%esi
 939:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 940:	83 ec 04             	sub    $0x4,%esp
 943:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 946:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 949:	6a 01                	push   $0x1
 94b:	e9 4c ff ff ff       	jmp    89c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 950:	83 ec 0c             	sub    $0xc,%esp
 953:	b9 0a 00 00 00       	mov    $0xa,%ecx
 958:	6a 01                	push   $0x1
 95a:	e9 6b ff ff ff       	jmp    8ca <printf+0xea>
 95f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 962:	83 ec 04             	sub    $0x4,%esp
 965:	8b 03                	mov    (%ebx),%eax
 967:	6a 01                	push   $0x1
 969:	88 45 e4             	mov    %al,-0x1c(%ebp)
 96c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 96f:	50                   	push   %eax
 970:	57                   	push   %edi
 971:	e8 fc fc ff ff       	call   672 <write>
 976:	e9 5b ff ff ff       	jmp    8d6 <printf+0xf6>
 97b:	66 90                	xchg   %ax,%ax
 97d:	66 90                	xchg   %ax,%ax
 97f:	90                   	nop

00000980 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 980:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 981:	a1 e8 10 00 00       	mov    0x10e8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 986:	89 e5                	mov    %esp,%ebp
 988:	57                   	push   %edi
 989:	56                   	push   %esi
 98a:	53                   	push   %ebx
 98b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 98e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 990:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 993:	39 c8                	cmp    %ecx,%eax
 995:	73 19                	jae    9b0 <free+0x30>
 997:	89 f6                	mov    %esi,%esi
 999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 9a0:	39 d1                	cmp    %edx,%ecx
 9a2:	72 1c                	jb     9c0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9a4:	39 d0                	cmp    %edx,%eax
 9a6:	73 18                	jae    9c0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 9a8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9aa:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ac:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ae:	72 f0                	jb     9a0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b0:	39 d0                	cmp    %edx,%eax
 9b2:	72 f4                	jb     9a8 <free+0x28>
 9b4:	39 d1                	cmp    %edx,%ecx
 9b6:	73 f0                	jae    9a8 <free+0x28>
 9b8:	90                   	nop
 9b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 9c0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9c3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9c6:	39 d7                	cmp    %edx,%edi
 9c8:	74 19                	je     9e3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 9ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9cd:	8b 50 04             	mov    0x4(%eax),%edx
 9d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9d3:	39 f1                	cmp    %esi,%ecx
 9d5:	74 23                	je     9fa <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 9d7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 9d9:	a3 e8 10 00 00       	mov    %eax,0x10e8
}
 9de:	5b                   	pop    %ebx
 9df:	5e                   	pop    %esi
 9e0:	5f                   	pop    %edi
 9e1:	5d                   	pop    %ebp
 9e2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9e3:	03 72 04             	add    0x4(%edx),%esi
 9e6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9e9:	8b 10                	mov    (%eax),%edx
 9eb:	8b 12                	mov    (%edx),%edx
 9ed:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 9f0:	8b 50 04             	mov    0x4(%eax),%edx
 9f3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9f6:	39 f1                	cmp    %esi,%ecx
 9f8:	75 dd                	jne    9d7 <free+0x57>
    p->s.size += bp->s.size;
 9fa:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 9fd:	a3 e8 10 00 00       	mov    %eax,0x10e8
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a02:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a05:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a08:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 a0a:	5b                   	pop    %ebx
 a0b:	5e                   	pop    %esi
 a0c:	5f                   	pop    %edi
 a0d:	5d                   	pop    %ebp
 a0e:	c3                   	ret    
 a0f:	90                   	nop

00000a10 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a10:	55                   	push   %ebp
 a11:	89 e5                	mov    %esp,%ebp
 a13:	57                   	push   %edi
 a14:	56                   	push   %esi
 a15:	53                   	push   %ebx
 a16:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a19:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a1c:	8b 15 e8 10 00 00    	mov    0x10e8,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a22:	8d 78 07             	lea    0x7(%eax),%edi
 a25:	c1 ef 03             	shr    $0x3,%edi
 a28:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a2b:	85 d2                	test   %edx,%edx
 a2d:	0f 84 a3 00 00 00    	je     ad6 <malloc+0xc6>
 a33:	8b 02                	mov    (%edx),%eax
 a35:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a38:	39 cf                	cmp    %ecx,%edi
 a3a:	76 74                	jbe    ab0 <malloc+0xa0>
 a3c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 a42:	be 00 10 00 00       	mov    $0x1000,%esi
 a47:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 a4e:	0f 43 f7             	cmovae %edi,%esi
 a51:	ba 00 80 00 00       	mov    $0x8000,%edx
 a56:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 a5c:	0f 46 da             	cmovbe %edx,%ebx
 a5f:	eb 10                	jmp    a71 <malloc+0x61>
 a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a68:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a6a:	8b 48 04             	mov    0x4(%eax),%ecx
 a6d:	39 cf                	cmp    %ecx,%edi
 a6f:	76 3f                	jbe    ab0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a71:	39 05 e8 10 00 00    	cmp    %eax,0x10e8
 a77:	89 c2                	mov    %eax,%edx
 a79:	75 ed                	jne    a68 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 a7b:	83 ec 0c             	sub    $0xc,%esp
 a7e:	53                   	push   %ebx
 a7f:	e8 56 fc ff ff       	call   6da <sbrk>
  if(p == (char*)-1)
 a84:	83 c4 10             	add    $0x10,%esp
 a87:	83 f8 ff             	cmp    $0xffffffff,%eax
 a8a:	74 1c                	je     aa8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 a8c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 a8f:	83 ec 0c             	sub    $0xc,%esp
 a92:	83 c0 08             	add    $0x8,%eax
 a95:	50                   	push   %eax
 a96:	e8 e5 fe ff ff       	call   980 <free>
  return freep;
 a9b:	8b 15 e8 10 00 00    	mov    0x10e8,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 aa1:	83 c4 10             	add    $0x10,%esp
 aa4:	85 d2                	test   %edx,%edx
 aa6:	75 c0                	jne    a68 <malloc+0x58>
        return 0;
 aa8:	31 c0                	xor    %eax,%eax
 aaa:	eb 1c                	jmp    ac8 <malloc+0xb8>
 aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 ab0:	39 cf                	cmp    %ecx,%edi
 ab2:	74 1c                	je     ad0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 ab4:	29 f9                	sub    %edi,%ecx
 ab6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 ab9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 abc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 abf:	89 15 e8 10 00 00    	mov    %edx,0x10e8
      return (void*)(p + 1);
 ac5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 ac8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 acb:	5b                   	pop    %ebx
 acc:	5e                   	pop    %esi
 acd:	5f                   	pop    %edi
 ace:	5d                   	pop    %ebp
 acf:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 ad0:	8b 08                	mov    (%eax),%ecx
 ad2:	89 0a                	mov    %ecx,(%edx)
 ad4:	eb e9                	jmp    abf <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 ad6:	c7 05 e8 10 00 00 ec 	movl   $0x10ec,0x10e8
 add:	10 00 00 
 ae0:	c7 05 ec 10 00 00 ec 	movl   $0x10ec,0x10ec
 ae7:	10 00 00 
    base.s.size = 0;
 aea:	b8 ec 10 00 00       	mov    $0x10ec,%eax
 aef:	c7 05 f0 10 00 00 00 	movl   $0x0,0x10f0
 af6:	00 00 00 
 af9:	e9 3e ff ff ff       	jmp    a3c <malloc+0x2c>
