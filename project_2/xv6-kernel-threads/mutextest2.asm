
_mutextest2:     file format elf32-i386


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
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 14             	sub    $0x14,%esp
	printf(stdout, "~~~~~~~~~~~~~~~~~~ mutex test 2 ~~~~~~~~~~~~~~~~~~\n");
  13:	68 c4 0f 00 00       	push   $0xfc4
  18:	ff 35 88 14 00 00    	pushl  0x1488
  1e:	e8 7d 0b 00 00       	call   ba0 <printf>

	int thread;
	pid = getpid();
  23:	e8 6a 0a 00 00       	call   a92 <getpid>
	int expected;

	//attempt to lock a nonexistent mutex
	ASSERT(kthread_mutex_lock(-10) < 0, "locking an invalid mutex returns success");
  28:	c7 04 24 f6 ff ff ff 	movl   $0xfffffff6,(%esp)
main(int argc, char *argv[])
{
	printf(stdout, "~~~~~~~~~~~~~~~~~~ mutex test 2 ~~~~~~~~~~~~~~~~~~\n");

	int thread;
	pid = getpid();
  2f:	a3 98 14 00 00       	mov    %eax,0x1498
	int expected;

	//attempt to lock a nonexistent mutex
	ASSERT(kthread_mutex_lock(-10) < 0, "locking an invalid mutex returns success");
  34:	e8 a9 0a 00 00       	call   ae2 <kthread_mutex_lock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  39:	83 c4 10             	add    $0x10,%esp
  3c:	85 c0                	test   %eax,%eax
  3e:	78 0f                	js     4f <main+0x4f>
  40:	ba 56 00 00 00       	mov    $0x56,%edx
  45:	b8 f8 0f 00 00       	mov    $0xff8,%eax
  4a:	e8 11 05 00 00       	call   560 <assert.part.0>
	int expected;

	//attempt to lock a nonexistent mutex
	ASSERT(kthread_mutex_lock(-10) < 0, "locking an invalid mutex returns success");
	//attempt to unlock a nonexistent mutex
	ASSERT(kthread_mutex_unlock(-10) < 0, "unlocking an invalid mutex returns success");
  4f:	83 ec 0c             	sub    $0xc,%esp
  52:	6a f6                	push   $0xfffffff6
  54:	e8 91 0a 00 00       	call   aea <kthread_mutex_unlock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  59:	83 c4 10             	add    $0x10,%esp
  5c:	85 c0                	test   %eax,%eax
  5e:	78 0f                	js     6f <main+0x6f>
  60:	ba 58 00 00 00       	mov    $0x58,%edx
  65:	b8 24 10 00 00       	mov    $0x1024,%eax
  6a:	e8 f1 04 00 00       	call   560 <assert.part.0>
	  return 0;
}

int
main(int argc, char *argv[])
{
  6f:	bb 03 00 00 00       	mov    $0x3,%ebx
	//attempt to unlock a nonexistent mutex
	ASSERT(kthread_mutex_unlock(-10) < 0, "unlocking an invalid mutex returns success");
	//allocate and deallocate
	for(int i=0; i<3; i++)
	{
		int dummy = kthread_mutex_alloc();
  74:	e8 59 0a 00 00       	call   ad2 <kthread_mutex_alloc>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  79:	85 c0                	test   %eax,%eax
	//attempt to unlock a nonexistent mutex
	ASSERT(kthread_mutex_unlock(-10) < 0, "unlocking an invalid mutex returns success");
	//allocate and deallocate
	for(int i=0; i<3; i++)
	{
		int dummy = kthread_mutex_alloc();
  7b:	89 c6                	mov    %eax,%esi
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  7d:	0f 88 e1 03 00 00    	js     464 <main+0x464>
	//allocate and deallocate
	for(int i=0; i<3; i++)
	{
		int dummy = kthread_mutex_alloc();
		ASSERT(dummy >= 0, "failed to allocate mutex");
		ASSERT(kthread_mutex_dealloc(dummy) >= 0, "failed to deallocate mutex");
  83:	83 ec 0c             	sub    $0xc,%esp
  86:	56                   	push   %esi
  87:	e8 4e 0a 00 00       	call   ada <kthread_mutex_dealloc>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  8c:	83 c4 10             	add    $0x10,%esp
  8f:	85 c0                	test   %eax,%eax
  91:	0f 88 b9 03 00 00    	js     450 <main+0x450>
	//attempt to lock a nonexistent mutex
	ASSERT(kthread_mutex_lock(-10) < 0, "locking an invalid mutex returns success");
	//attempt to unlock a nonexistent mutex
	ASSERT(kthread_mutex_unlock(-10) < 0, "unlocking an invalid mutex returns success");
	//allocate and deallocate
	for(int i=0; i<3; i++)
  97:	83 eb 01             	sub    $0x1,%ebx
  9a:	75 d8                	jne    74 <main+0x74>
		ASSERT(dummy >= 0, "failed to allocate mutex");
		ASSERT(kthread_mutex_dealloc(dummy) >= 0, "failed to deallocate mutex");
	}


	mutex = kthread_mutex_alloc();
  9c:	e8 31 0a 00 00       	call   ad2 <kthread_mutex_alloc>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  a1:	85 c0                	test   %eax,%eax
		ASSERT(dummy >= 0, "failed to allocate mutex");
		ASSERT(kthread_mutex_dealloc(dummy) >= 0, "failed to deallocate mutex");
	}


	mutex = kthread_mutex_alloc();
  a3:	a3 b0 14 00 00       	mov    %eax,0x14b0
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  a8:	0f 88 7e 04 00 00    	js     52c <main+0x52c>


	mutex = kthread_mutex_alloc();
	ASSERT(mutex >= 0, "failed to allocate mutex");
	//attempt to unlock before mutex is locked
	ASSERT(kthread_mutex_unlock(mutex) < 0, "unlocking unlocked mutex returns success");
  ae:	83 ec 0c             	sub    $0xc,%esp
  b1:	50                   	push   %eax
  b2:	e8 33 0a 00 00       	call   aea <kthread_mutex_unlock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  b7:	83 c4 10             	add    $0x10,%esp
  ba:	85 c0                	test   %eax,%eax
  bc:	78 0f                	js     cd <main+0xcd>
  be:	ba 65 00 00 00       	mov    $0x65,%edx
  c3:	b8 50 10 00 00       	mov    $0x1050,%eax
  c8:	e8 93 04 00 00       	call   560 <assert.part.0>

	mutex = kthread_mutex_alloc();
	ASSERT(mutex >= 0, "failed to allocate mutex");
	//attempt to unlock before mutex is locked
	ASSERT(kthread_mutex_unlock(mutex) < 0, "unlocking unlocked mutex returns success");
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
  cd:	83 ec 0c             	sub    $0xc,%esp
  d0:	ff 35 b0 14 00 00    	pushl  0x14b0
  d6:	e8 07 0a 00 00       	call   ae2 <kthread_mutex_lock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  db:	83 c4 10             	add    $0x10,%esp
  de:	85 c0                	test   %eax,%eax
  e0:	0f 88 ba 03 00 00    	js     4a0 <main+0x4a0>
	ASSERT(mutex >= 0, "failed to allocate mutex");
	//attempt to unlock before mutex is locked
	ASSERT(kthread_mutex_unlock(mutex) < 0, "unlocking unlocked mutex returns success");
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	//attempt to deallocate when mutex is locked
	ASSERT(kthread_mutex_dealloc(mutex) < 0, "deallocating a locked mutex returns success");
  e6:	83 ec 0c             	sub    $0xc,%esp
  e9:	ff 35 b0 14 00 00    	pushl  0x14b0
  ef:	e8 e6 09 00 00       	call   ada <kthread_mutex_dealloc>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
  f4:	83 c4 10             	add    $0x10,%esp
  f7:	85 c0                	test   %eax,%eax
  f9:	78 0f                	js     10a <main+0x10a>
  fb:	ba 68 00 00 00       	mov    $0x68,%edx
 100:	b8 7c 10 00 00       	mov    $0x107c,%eax
 105:	e8 56 04 00 00       	call   560 <assert.part.0>
	//attempt to unlock before mutex is locked
	ASSERT(kthread_mutex_unlock(mutex) < 0, "unlocking unlocked mutex returns success");
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	//attempt to deallocate when mutex is locked
	ASSERT(kthread_mutex_dealloc(mutex) < 0, "deallocating a locked mutex returns success");
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");
 10a:	83 ec 0c             	sub    $0xc,%esp
 10d:	ff 35 b0 14 00 00    	pushl  0x14b0
 113:	e8 d2 09 00 00       	call   aea <kthread_mutex_unlock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 118:	83 c4 10             	add    $0x10,%esp
 11b:	85 c0                	test   %eax,%eax
 11d:	0f 88 91 03 00 00    	js     4b4 <main+0x4b4>
	ASSERT(kthread_mutex_unlock(mutex) < 0, "unlocking unlocked mutex returns success");
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	//attempt to deallocate when mutex is locked
	ASSERT(kthread_mutex_dealloc(mutex) < 0, "deallocating a locked mutex returns success");
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");
	ASSERT(kthread_mutex_dealloc(mutex) >= 0, "failed to deallocate mutex");
 123:	83 ec 0c             	sub    $0xc,%esp
 126:	ff 35 b0 14 00 00    	pushl  0x14b0
 12c:	e8 a9 09 00 00       	call   ada <kthread_mutex_dealloc>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 131:	83 c4 10             	add    $0x10,%esp
 134:	85 c0                	test   %eax,%eax
 136:	0f 88 8c 03 00 00    	js     4c8 <main+0x4c8>
	//attempt to deallocate when mutex is locked
	ASSERT(kthread_mutex_dealloc(mutex) < 0, "deallocating a locked mutex returns success");
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");
	ASSERT(kthread_mutex_dealloc(mutex) >= 0, "failed to deallocate mutex");

	thread = kthread_create(allocate_and_lock, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 13c:	83 ec 0c             	sub    $0xc,%esp
 13f:	68 00 04 00 00       	push   $0x400
 144:	e8 87 0c 00 00       	call   dd0 <malloc>
 149:	83 c4 0c             	add    $0xc,%esp
 14c:	68 00 04 00 00       	push   $0x400
 151:	50                   	push   %eax
 152:	68 c0 05 00 00       	push   $0x5c0
 157:	e8 56 09 00 00       	call   ab2 <kthread_create>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 15c:	83 c4 10             	add    $0x10,%esp
 15f:	85 c0                	test   %eax,%eax
	//attempt to deallocate when mutex is locked
	ASSERT(kthread_mutex_dealloc(mutex) < 0, "deallocating a locked mutex returns success");
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");
	ASSERT(kthread_mutex_dealloc(mutex) >= 0, "failed to deallocate mutex");

	thread = kthread_create(allocate_and_lock, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 161:	89 c3                	mov    %eax,%ebx
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 163:	0f 88 73 03 00 00    	js     4dc <main+0x4dc>
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");
	ASSERT(kthread_mutex_dealloc(mutex) >= 0, "failed to deallocate mutex");

	thread = kthread_create(allocate_and_lock, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
  	ASSERT(thread >= 0, "failed to create thread");
  	ASSERT(kthread_join(thread) >= 0, "failed to join thread");
 169:	83 ec 0c             	sub    $0xc,%esp
 16c:	53                   	push   %ebx
 16d:	e8 58 09 00 00       	call   aca <kthread_join>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 172:	83 c4 10             	add    $0x10,%esp
 175:	85 c0                	test   %eax,%eax
 177:	0f 88 73 03 00 00    	js     4f0 <main+0x4f0>

	thread = kthread_create(allocate_and_lock, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
  	ASSERT(thread >= 0, "failed to create thread");
  	ASSERT(kthread_join(thread) >= 0, "failed to join thread");
	//attempt to unlock a mutex that's locked by another thread
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");
 17d:	83 ec 0c             	sub    $0xc,%esp
 180:	ff 35 b0 14 00 00    	pushl  0x14b0
 186:	e8 5f 09 00 00       	call   aea <kthread_mutex_unlock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 18b:	83 c4 10             	add    $0x10,%esp
 18e:	85 c0                	test   %eax,%eax
 190:	0f 88 6e 03 00 00    	js     504 <main+0x504>
  	ASSERT(kthread_join(thread) >= 0, "failed to join thread");
	//attempt to unlock a mutex that's locked by another thread
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");

	//shared variable test #1
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
 196:	83 ec 0c             	sub    $0xc,%esp
 199:	ff 35 b0 14 00 00    	pushl  0x14b0
 19f:	e8 3e 09 00 00       	call   ae2 <kthread_mutex_lock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 1a4:	83 c4 10             	add    $0x10,%esp
 1a7:	85 c0                	test   %eax,%eax
 1a9:	0f 88 96 03 00 00    	js     545 <main+0x545>
	//attempt to unlock a mutex that's locked by another thread
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");

	//shared variable test #1
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	shared = 0;
 1af:	c7 05 b4 14 00 00 00 	movl   $0x0,0x14b4
 1b6:	00 00 00 
 1b9:	31 db                	xor    %ebx,%ebx

	for(int i=0; i<5; i++)
	{
	  	thread = kthread_create(increment, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 1bb:	83 ec 0c             	sub    $0xc,%esp
 1be:	68 00 04 00 00       	push   $0x400
 1c3:	e8 08 0c 00 00       	call   dd0 <malloc>
 1c8:	83 c4 0c             	add    $0xc,%esp
 1cb:	68 00 04 00 00       	push   $0x400
 1d0:	50                   	push   %eax
 1d1:	68 30 06 00 00       	push   $0x630
 1d6:	e8 d7 08 00 00       	call   ab2 <kthread_create>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 1db:	83 c4 10             	add    $0x10,%esp
 1de:	85 c0                	test   %eax,%eax
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	shared = 0;

	for(int i=0; i<5; i++)
	{
	  	thread = kthread_create(increment, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 1e0:	89 c6                	mov    %eax,%esi
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 1e2:	0f 88 54 02 00 00    	js     43c <main+0x43c>

	for(int i=0; i<5; i++)
	{
	  	thread = kthread_create(increment, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
  		ASSERT(thread >= 0, "failed to create thread");
  		thread_ids[i] = thread;
 1e8:	89 b3 9c 14 00 00    	mov    %esi,0x149c(%ebx)
 1ee:	83 c3 04             	add    $0x4,%ebx

	//shared variable test #1
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	shared = 0;

	for(int i=0; i<5; i++)
 1f1:	83 fb 14             	cmp    $0x14,%ebx
 1f4:	75 c5                	jne    1bb <main+0x1bb>
	  	thread = kthread_create(increment, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
  		ASSERT(thread >= 0, "failed to create thread");
  		thread_ids[i] = thread;
	}

	sleep(6 * TIME_SLICE); //sleep with lock held for a while
 1f6:	83 ec 0c             	sub    $0xc,%esp
 1f9:	6a 3c                	push   $0x3c
 1fb:	e8 a2 08 00 00       	call   aa2 <sleep>
	ASSERT(shared == 0, "mutex failed to prevent writing to shared");
 200:	a1 b4 14 00 00       	mov    0x14b4,%eax
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 205:	83 c4 10             	add    $0x10,%esp
 208:	85 c0                	test   %eax,%eax
 20a:	0f 85 68 02 00 00    	jne    478 <main+0x478>
  		thread_ids[i] = thread;
	}

	sleep(6 * TIME_SLICE); //sleep with lock held for a while
	ASSERT(shared == 0, "mutex failed to prevent writing to shared");
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");
 210:	83 ec 0c             	sub    $0xc,%esp
 213:	ff 35 b0 14 00 00    	pushl  0x14b0
 219:	e8 cc 08 00 00       	call   aea <kthread_mutex_unlock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 21e:	83 c4 10             	add    $0x10,%esp
 221:	85 c0                	test   %eax,%eax
 223:	0f 88 63 02 00 00    	js     48c <main+0x48c>
	//attempt to unlock a mutex that's locked by another thread
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");

	//shared variable test #1
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	shared = 0;
 229:	31 db                	xor    %ebx,%ebx
	ASSERT(shared == 0, "mutex failed to prevent writing to shared");
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");

	for(int i=0; i<5; i++)
	{
		ASSERT(kthread_join(thread_ids[i]) >= 0, "failed to join thread");
 22b:	83 ec 0c             	sub    $0xc,%esp
 22e:	ff b3 9c 14 00 00    	pushl  0x149c(%ebx)
 234:	e8 91 08 00 00       	call   aca <kthread_join>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 239:	83 c4 10             	add    $0x10,%esp
 23c:	85 c0                	test   %eax,%eax
 23e:	0f 88 e4 01 00 00    	js     428 <main+0x428>
 244:	83 c3 04             	add    $0x4,%ebx

	sleep(6 * TIME_SLICE); //sleep with lock held for a while
	ASSERT(shared == 0, "mutex failed to prevent writing to shared");
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");

	for(int i=0; i<5; i++)
 247:	83 fb 14             	cmp    $0x14,%ebx
 24a:	75 df                	jne    22b <main+0x22b>
	{
		ASSERT(kthread_join(thread_ids[i]) >= 0, "failed to join thread");
	}

	expected = 5;
	if(shared != expected)
 24c:	a1 b4 14 00 00       	mov    0x14b4,%eax
 251:	83 f8 05             	cmp    $0x5,%eax
 254:	74 1b                	je     271 <main+0x271>
	{
		printf(stdout, "value=%d, expected=%d\n", shared, expected);
 256:	a1 b4 14 00 00       	mov    0x14b4,%eax
 25b:	6a 05                	push   $0x5
 25d:	50                   	push   %eax
 25e:	68 77 0f 00 00       	push   $0xf77
 263:	ff 35 88 14 00 00    	pushl  0x1488
 269:	e8 32 09 00 00       	call   ba0 <printf>
 26e:	83 c4 10             	add    $0x10,%esp
	}
	ASSERT(shared == expected, "shared variable does not have a correct value");
 271:	a1 b4 14 00 00       	mov    0x14b4,%eax
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 276:	83 f8 05             	cmp    $0x5,%eax
 279:	74 0f                	je     28a <main+0x28a>
 27b:	ba 8b 00 00 00       	mov    $0x8b,%edx
 280:	b8 d4 10 00 00       	mov    $0x10d4,%eax
 285:	e8 d6 02 00 00       	call   560 <assert.part.0>
	//attempt to unlock a mutex that's locked by another thread
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");

	//shared variable test #1
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	shared = 0;
 28a:	bb 05 00 00 00       	mov    $0x5,%ebx
	//loop 5 times
	//for each iteration, correct order: *5 then +3
	for(int i=0; i<5; i++)
	{
		//make sure plus_three is blocked
		ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
 28f:	83 ec 0c             	sub    $0xc,%esp
 292:	ff 35 b0 14 00 00    	pushl  0x14b0
 298:	e8 45 08 00 00       	call   ae2 <kthread_mutex_lock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 29d:	83 c4 10             	add    $0x10,%esp
 2a0:	85 c0                	test   %eax,%eax
 2a2:	0f 88 6c 01 00 00    	js     414 <main+0x414>
	for(int i=0; i<5; i++)
	{
		//make sure plus_three is blocked
		ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");

		thread = kthread_create(plus_three, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 2a8:	83 ec 0c             	sub    $0xc,%esp
 2ab:	68 00 04 00 00       	push   $0x400
 2b0:	e8 1b 0b 00 00       	call   dd0 <malloc>
 2b5:	83 c4 0c             	add    $0xc,%esp
 2b8:	68 00 04 00 00       	push   $0x400
 2bd:	50                   	push   %eax
 2be:	68 c0 06 00 00       	push   $0x6c0
 2c3:	e8 ea 07 00 00       	call   ab2 <kthread_create>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 2c8:	83 c4 10             	add    $0x10,%esp
 2cb:	85 c0                	test   %eax,%eax
	for(int i=0; i<5; i++)
	{
		//make sure plus_three is blocked
		ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");

		thread = kthread_create(plus_three, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 2cd:	89 c6                	mov    %eax,%esi
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 2cf:	0f 88 2b 01 00 00    	js     400 <main+0x400>

		thread = kthread_create(plus_three, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
		ASSERT(thread >= 0, "failed to create thread");
		thread_ids[0] = thread;

		thread = kthread_create(times_five, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 2d5:	83 ec 0c             	sub    $0xc,%esp
		//make sure plus_three is blocked
		ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");

		thread = kthread_create(plus_three, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
		ASSERT(thread >= 0, "failed to create thread");
		thread_ids[0] = thread;
 2d8:	89 35 9c 14 00 00    	mov    %esi,0x149c

		thread = kthread_create(times_five, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 2de:	68 00 04 00 00       	push   $0x400
 2e3:	e8 e8 0a 00 00       	call   dd0 <malloc>
 2e8:	83 c4 0c             	add    $0xc,%esp
 2eb:	68 00 04 00 00       	push   $0x400
 2f0:	50                   	push   %eax
 2f1:	68 50 07 00 00       	push   $0x750
 2f6:	e8 b7 07 00 00       	call   ab2 <kthread_create>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 2fb:	83 c4 10             	add    $0x10,%esp
 2fe:	85 c0                	test   %eax,%eax

		thread = kthread_create(plus_three, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
		ASSERT(thread >= 0, "failed to create thread");
		thread_ids[0] = thread;

		thread = kthread_create(times_five, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
 300:	89 c6                	mov    %eax,%esi
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 302:	0f 88 e4 00 00 00    	js     3ec <main+0x3ec>

		thread = kthread_create(times_five, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
		ASSERT(thread >= 0, "failed to create thread");
		thread_ids[1] = thread;

		ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread");
 308:	83 ec 0c             	sub    $0xc,%esp
 30b:	ff 35 9c 14 00 00    	pushl  0x149c
		ASSERT(thread >= 0, "failed to create thread");
		thread_ids[0] = thread;

		thread = kthread_create(times_five, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
		ASSERT(thread >= 0, "failed to create thread");
		thread_ids[1] = thread;
 311:	89 35 a0 14 00 00    	mov    %esi,0x14a0

		ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread");
 317:	e8 ae 07 00 00       	call   aca <kthread_join>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 31c:	83 c4 10             	add    $0x10,%esp
 31f:	85 c0                	test   %eax,%eax
 321:	0f 88 b1 00 00 00    	js     3d8 <main+0x3d8>
		thread = kthread_create(times_five, malloc(MAX_STACK_SIZE), MAX_STACK_SIZE);
		ASSERT(thread >= 0, "failed to create thread");
		thread_ids[1] = thread;

		ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread");
		ASSERT(kthread_join(thread_ids[1]) >= 0, "failed to join thread");
 327:	83 ec 0c             	sub    $0xc,%esp
 32a:	ff 35 a0 14 00 00    	pushl  0x14a0
 330:	e8 95 07 00 00       	call   aca <kthread_join>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 335:	83 c4 10             	add    $0x10,%esp
 338:	85 c0                	test   %eax,%eax
 33a:	0f 88 84 00 00 00    	js     3c4 <main+0x3c4>


	//shared variable test #2
	//loop 5 times
	//for each iteration, correct order: *5 then +3
	for(int i=0; i<5; i++)
 340:	83 eb 01             	sub    $0x1,%ebx
 343:	0f 85 46 ff ff ff    	jne    28f <main+0x28f>
		ASSERT(kthread_join(thread_ids[0]) >= 0, "failed to join thread");
		ASSERT(kthread_join(thread_ids[1]) >= 0, "failed to join thread");
	}

	expected = 17968;
	if(shared != expected)
 349:	a1 b4 14 00 00       	mov    0x14b4,%eax
 34e:	3d 30 46 00 00       	cmp    $0x4630,%eax
 353:	74 1e                	je     373 <main+0x373>
	{
		printf(stdout, "value=%d, expected=%d\n", shared, expected);
 355:	a1 b4 14 00 00       	mov    0x14b4,%eax
 35a:	68 30 46 00 00       	push   $0x4630
 35f:	50                   	push   %eax
 360:	68 77 0f 00 00       	push   $0xf77
 365:	ff 35 88 14 00 00    	pushl  0x1488
 36b:	e8 30 08 00 00       	call   ba0 <printf>
 370:	83 c4 10             	add    $0x10,%esp
	}
	ASSERT(shared == expected, "shared variable does not have a correct value");
 373:	a1 b4 14 00 00       	mov    0x14b4,%eax
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 378:	3d 30 46 00 00       	cmp    $0x4630,%eax
 37d:	74 0f                	je     38e <main+0x38e>
 37f:	ba a7 00 00 00       	mov    $0xa7,%edx
 384:	b8 d4 10 00 00       	mov    $0x10d4,%eax
 389:	e8 d2 01 00 00       	call   560 <assert.part.0>
	{
		printf(stdout, "value=%d, expected=%d\n", shared, expected);
	}
	ASSERT(shared == expected, "shared variable does not have a correct value");

	ASSERT(kthread_mutex_dealloc(mutex) >= 0, "failed to deallocate mutex");
 38e:	83 ec 0c             	sub    $0xc,%esp
 391:	ff 35 b0 14 00 00    	pushl  0x14b0
 397:	e8 3e 07 00 00       	call   ada <kthread_mutex_dealloc>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 39c:	83 c4 10             	add    $0x10,%esp
 39f:	85 c0                	test   %eax,%eax
 3a1:	0f 88 71 01 00 00    	js     518 <main+0x518>
		printf(stdout, "value=%d, expected=%d\n", shared, expected);
	}
	ASSERT(shared == expected, "shared variable does not have a correct value");

	ASSERT(kthread_mutex_dealloc(mutex) >= 0, "failed to deallocate mutex");
	printf(stdout, "%s\n", "test passed");
 3a7:	83 ec 04             	sub    $0x4,%esp
 3aa:	68 8e 0f 00 00       	push   $0xf8e
 3af:	68 d8 0e 00 00       	push   $0xed8
 3b4:	ff 35 88 14 00 00    	pushl  0x1488
 3ba:	e8 e1 07 00 00       	call   ba0 <printf>
	exit();
 3bf:	e8 4e 06 00 00       	call   a12 <exit>
 3c4:	ba 9f 00 00 00       	mov    $0x9f,%edx
 3c9:	b8 61 0f 00 00       	mov    $0xf61,%eax
 3ce:	e8 8d 01 00 00       	call   560 <assert.part.0>
 3d3:	e9 68 ff ff ff       	jmp    340 <main+0x340>
 3d8:	ba 9e 00 00 00       	mov    $0x9e,%edx
 3dd:	b8 61 0f 00 00       	mov    $0xf61,%eax
 3e2:	e8 79 01 00 00       	call   560 <assert.part.0>
 3e7:	e9 3b ff ff ff       	jmp    327 <main+0x327>
 3ec:	ba 9b 00 00 00       	mov    $0x9b,%edx
 3f1:	b8 49 0f 00 00       	mov    $0xf49,%eax
 3f6:	e8 65 01 00 00       	call   560 <assert.part.0>
 3fb:	e9 08 ff ff ff       	jmp    308 <main+0x308>
 400:	ba 97 00 00 00       	mov    $0x97,%edx
 405:	b8 49 0f 00 00       	mov    $0xf49,%eax
 40a:	e8 51 01 00 00       	call   560 <assert.part.0>
 40f:	e9 c1 fe ff ff       	jmp    2d5 <main+0x2d5>
 414:	ba 94 00 00 00       	mov    $0x94,%edx
 419:	b8 02 0f 00 00       	mov    $0xf02,%eax
 41e:	e8 3d 01 00 00       	call   560 <assert.part.0>
 423:	e9 80 fe ff ff       	jmp    2a8 <main+0x2a8>
 428:	ba 83 00 00 00       	mov    $0x83,%edx
 42d:	b8 61 0f 00 00       	mov    $0xf61,%eax
 432:	e8 29 01 00 00       	call   560 <assert.part.0>
 437:	e9 08 fe ff ff       	jmp    244 <main+0x244>
 43c:	ba 79 00 00 00       	mov    $0x79,%edx
 441:	b8 49 0f 00 00       	mov    $0xf49,%eax
 446:	e8 15 01 00 00       	call   560 <assert.part.0>
 44b:	e9 98 fd ff ff       	jmp    1e8 <main+0x1e8>
 450:	ba 5e 00 00 00       	mov    $0x5e,%edx
 455:	b8 2e 0f 00 00       	mov    $0xf2e,%eax
 45a:	e8 01 01 00 00       	call   560 <assert.part.0>
 45f:	e9 33 fc ff ff       	jmp    97 <main+0x97>
 464:	ba 5d 00 00 00       	mov    $0x5d,%edx
 469:	b8 e9 0e 00 00       	mov    $0xee9,%eax
 46e:	e8 ed 00 00 00       	call   560 <assert.part.0>
 473:	e9 0b fc ff ff       	jmp    83 <main+0x83>
 478:	ba 7e 00 00 00       	mov    $0x7e,%edx
 47d:	b8 a8 10 00 00       	mov    $0x10a8,%eax
 482:	e8 d9 00 00 00       	call   560 <assert.part.0>
 487:	e9 84 fd ff ff       	jmp    210 <main+0x210>
 48c:	ba 7f 00 00 00       	mov    $0x7f,%edx
 491:	b8 17 0f 00 00       	mov    $0xf17,%eax
 496:	e8 c5 00 00 00       	call   560 <assert.part.0>
 49b:	e9 89 fd ff ff       	jmp    229 <main+0x229>
 4a0:	ba 66 00 00 00       	mov    $0x66,%edx
 4a5:	b8 02 0f 00 00       	mov    $0xf02,%eax
 4aa:	e8 b1 00 00 00       	call   560 <assert.part.0>
 4af:	e9 32 fc ff ff       	jmp    e6 <main+0xe6>
 4b4:	ba 69 00 00 00       	mov    $0x69,%edx
 4b9:	b8 17 0f 00 00       	mov    $0xf17,%eax
 4be:	e8 9d 00 00 00       	call   560 <assert.part.0>
 4c3:	e9 5b fc ff ff       	jmp    123 <main+0x123>
 4c8:	ba 6a 00 00 00       	mov    $0x6a,%edx
 4cd:	b8 2e 0f 00 00       	mov    $0xf2e,%eax
 4d2:	e8 89 00 00 00       	call   560 <assert.part.0>
 4d7:	e9 60 fc ff ff       	jmp    13c <main+0x13c>
 4dc:	ba 6d 00 00 00       	mov    $0x6d,%edx
 4e1:	b8 49 0f 00 00       	mov    $0xf49,%eax
 4e6:	e8 75 00 00 00       	call   560 <assert.part.0>
 4eb:	e9 79 fc ff ff       	jmp    169 <main+0x169>
 4f0:	ba 6e 00 00 00       	mov    $0x6e,%edx
 4f5:	b8 61 0f 00 00       	mov    $0xf61,%eax
 4fa:	e8 61 00 00 00       	call   560 <assert.part.0>
 4ff:	e9 79 fc ff ff       	jmp    17d <main+0x17d>
 504:	ba 70 00 00 00       	mov    $0x70,%edx
 509:	b8 17 0f 00 00       	mov    $0xf17,%eax
 50e:	e8 4d 00 00 00       	call   560 <assert.part.0>
 513:	e9 7e fc ff ff       	jmp    196 <main+0x196>
 518:	ba a9 00 00 00       	mov    $0xa9,%edx
 51d:	b8 2e 0f 00 00       	mov    $0xf2e,%eax
 522:	e8 39 00 00 00       	call   560 <assert.part.0>
 527:	e9 7b fe ff ff       	jmp    3a7 <main+0x3a7>
 52c:	b8 e9 0e 00 00       	mov    $0xee9,%eax
 531:	ba 63 00 00 00       	mov    $0x63,%edx
 536:	e8 25 00 00 00       	call   560 <assert.part.0>
 53b:	a1 b0 14 00 00       	mov    0x14b0,%eax
 540:	e9 69 fb ff ff       	jmp    ae <main+0xae>
 545:	ba 73 00 00 00       	mov    $0x73,%edx
 54a:	b8 02 0f 00 00       	mov    $0xf02,%eax
 54f:	e8 0c 00 00 00       	call   560 <assert.part.0>
 554:	e9 56 fc ff ff       	jmp    1af <main+0x1af>
 559:	66 90                	xchg   %ax,%ax
 55b:	66 90                	xchg   %ax,%ax
 55d:	66 90                	xchg   %ax,%ax
 55f:	90                   	nop

00000560 <assert.part.0>:
int mutex;
int thread_ids[5];
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	53                   	push   %ebx
 564:	89 c3                	mov    %eax,%ebx
 566:	83 ec 04             	sub    $0x4,%esp
{
	if(!assumption)
	{
		printf(stdout, "at %s:%d, ", __FILE__, curLine);
 569:	52                   	push   %edx
 56a:	68 c0 0e 00 00       	push   $0xec0
 56f:	68 cd 0e 00 00       	push   $0xecd
 574:	ff 35 88 14 00 00    	pushl  0x1488
 57a:	e8 21 06 00 00       	call   ba0 <printf>
		printf(stdout, "%s\n", errMsg);
 57f:	83 c4 0c             	add    $0xc,%esp
 582:	53                   	push   %ebx
 583:	68 d8 0e 00 00       	push   $0xed8
 588:	ff 35 88 14 00 00    	pushl  0x1488
 58e:	e8 0d 06 00 00       	call   ba0 <printf>
		printf(stdout, "test failed\n");
 593:	58                   	pop    %eax
 594:	5a                   	pop    %edx
 595:	68 dc 0e 00 00       	push   $0xedc
 59a:	ff 35 88 14 00 00    	pushl  0x1488
 5a0:	e8 fb 05 00 00       	call   ba0 <printf>
		kill(pid);
 5a5:	59                   	pop    %ecx
 5a6:	ff 35 98 14 00 00    	pushl  0x1498
 5ac:	e8 91 04 00 00       	call   a42 <kill>
 5b1:	83 c4 10             	add    $0x10,%esp
	}
}
 5b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5b7:	c9                   	leave  
 5b8:	c3                   	ret    
 5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005c0 <allocate_and_lock>:

void*
allocate_and_lock(void)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	83 ec 08             	sub    $0x8,%esp
	mutex = kthread_mutex_alloc();
 5c6:	e8 07 05 00 00       	call   ad2 <kthread_mutex_alloc>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 5cb:	85 c0                	test   %eax,%eax
}

void*
allocate_and_lock(void)
{
	mutex = kthread_mutex_alloc();
 5cd:	a3 b0 14 00 00       	mov    %eax,0x14b0
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 5d2:	78 44                	js     618 <allocate_and_lock+0x58>
void*
allocate_and_lock(void)
{
	mutex = kthread_mutex_alloc();
	ASSERT(mutex >= 0, "failed to allocate mutex");
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
 5d4:	83 ec 0c             	sub    $0xc,%esp
 5d7:	50                   	push   %eax
 5d8:	e8 05 05 00 00       	call   ae2 <kthread_mutex_lock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 5dd:	83 c4 10             	add    $0x10,%esp
 5e0:	85 c0                	test   %eax,%eax
 5e2:	78 1c                	js     600 <allocate_and_lock+0x40>
allocate_and_lock(void)
{
	mutex = kthread_mutex_alloc();
	ASSERT(mutex >= 0, "failed to allocate mutex");
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	kthread_exit();
 5e4:	e8 d9 04 00 00       	call   ac2 <kthread_exit>
 5e9:	b8 9c 0f 00 00       	mov    $0xf9c,%eax
 5ee:	ba 23 00 00 00       	mov    $0x23,%edx
 5f3:	e8 68 ff ff ff       	call   560 <assert.part.0>
	ASSERT(0, "thread continues to execute after exit");
	  return 0;
}
 5f8:	31 c0                	xor    %eax,%eax
 5fa:	c9                   	leave  
 5fb:	c3                   	ret    
 5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 600:	ba 21 00 00 00       	mov    $0x21,%edx
 605:	b8 02 0f 00 00       	mov    $0xf02,%eax
 60a:	e8 51 ff ff ff       	call   560 <assert.part.0>
 60f:	eb d3                	jmp    5e4 <allocate_and_lock+0x24>
 611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 618:	b8 e9 0e 00 00       	mov    $0xee9,%eax
 61d:	ba 20 00 00 00       	mov    $0x20,%edx
 622:	e8 39 ff ff ff       	call   560 <assert.part.0>
 627:	a1 b0 14 00 00       	mov    0x14b0,%eax
 62c:	eb a6                	jmp    5d4 <allocate_and_lock+0x14>
 62e:	66 90                	xchg   %ax,%ax

00000630 <increment>:

void*
increment(void)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	83 ec 14             	sub    $0x14,%esp
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
 636:	ff 35 b0 14 00 00    	pushl  0x14b0
 63c:	e8 a1 04 00 00       	call   ae2 <kthread_mutex_lock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 641:	83 c4 10             	add    $0x10,%esp
 644:	85 c0                	test   %eax,%eax
 646:	78 58                	js     6a0 <increment+0x70>

void*
increment(void)
{
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	shared++;
 648:	a1 b4 14 00 00       	mov    0x14b4,%eax
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");
 64d:	83 ec 0c             	sub    $0xc,%esp
 650:	ff 35 b0 14 00 00    	pushl  0x14b0

void*
increment(void)
{
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	shared++;
 656:	83 c0 01             	add    $0x1,%eax
 659:	a3 b4 14 00 00       	mov    %eax,0x14b4
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");
 65e:	e8 87 04 00 00       	call   aea <kthread_mutex_unlock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 663:	83 c4 10             	add    $0x10,%esp
 666:	85 c0                	test   %eax,%eax
 668:	78 1e                	js     688 <increment+0x58>
{
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	shared++;
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex");

	kthread_exit();
 66a:	e8 53 04 00 00       	call   ac2 <kthread_exit>
 66f:	b8 9c 0f 00 00       	mov    $0xf9c,%eax
 674:	ba 2f 00 00 00       	mov    $0x2f,%edx
 679:	e8 e2 fe ff ff       	call   560 <assert.part.0>
	ASSERT(0, "thread continues to execute after exit");
	  return 0;
}
 67e:	31 c0                	xor    %eax,%eax
 680:	c9                   	leave  
 681:	c3                   	ret    
 682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 688:	ba 2c 00 00 00       	mov    $0x2c,%edx
 68d:	b8 17 0f 00 00       	mov    $0xf17,%eax
 692:	e8 c9 fe ff ff       	call   560 <assert.part.0>
 697:	eb d1                	jmp    66a <increment+0x3a>
 699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6a0:	ba 2a 00 00 00       	mov    $0x2a,%edx
 6a5:	b8 02 0f 00 00       	mov    $0xf02,%eax
 6aa:	e8 b1 fe ff ff       	call   560 <assert.part.0>
 6af:	eb 97                	jmp    648 <increment+0x18>
 6b1:	eb 0d                	jmp    6c0 <plus_three>
 6b3:	90                   	nop
 6b4:	90                   	nop
 6b5:	90                   	nop
 6b6:	90                   	nop
 6b7:	90                   	nop
 6b8:	90                   	nop
 6b9:	90                   	nop
 6ba:	90                   	nop
 6bb:	90                   	nop
 6bc:	90                   	nop
 6bd:	90                   	nop
 6be:	90                   	nop
 6bf:	90                   	nop

000006c0 <plus_three>:

void*
plus_three(void)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	83 ec 14             	sub    $0x14,%esp
	//waits for times_five
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
 6c6:	ff 35 b0 14 00 00    	pushl  0x14b0
 6cc:	e8 11 04 00 00       	call   ae2 <kthread_mutex_lock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 6d1:	83 c4 10             	add    $0x10,%esp
 6d4:	85 c0                	test   %eax,%eax
 6d6:	78 58                	js     730 <plus_three+0x70>
void*
plus_three(void)
{
	//waits for times_five
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	shared += 3;
 6d8:	a1 b4 14 00 00       	mov    0x14b4,%eax
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex"); 
 6dd:	83 ec 0c             	sub    $0xc,%esp
 6e0:	ff 35 b0 14 00 00    	pushl  0x14b0
void*
plus_three(void)
{
	//waits for times_five
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	shared += 3;
 6e6:	83 c0 03             	add    $0x3,%eax
 6e9:	a3 b4 14 00 00       	mov    %eax,0x14b4
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex"); 
 6ee:	e8 f7 03 00 00       	call   aea <kthread_mutex_unlock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 6f3:	83 c4 10             	add    $0x10,%esp
 6f6:	85 c0                	test   %eax,%eax
 6f8:	78 1e                	js     718 <plus_three+0x58>
	//waits for times_five
	ASSERT(kthread_mutex_lock(mutex) >= 0, "failed to lock mutex");
	shared += 3;
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex"); 

	kthread_exit();
 6fa:	e8 c3 03 00 00       	call   ac2 <kthread_exit>
 6ff:	b8 9c 0f 00 00       	mov    $0xf9c,%eax
 704:	ba 3c 00 00 00       	mov    $0x3c,%edx
 709:	e8 52 fe ff ff       	call   560 <assert.part.0>
	ASSERT(0, "thread continues to execute after exit");
	  return 0;
}
 70e:	31 c0                	xor    %eax,%eax
 710:	c9                   	leave  
 711:	c3                   	ret    
 712:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 718:	ba 39 00 00 00       	mov    $0x39,%edx
 71d:	b8 17 0f 00 00       	mov    $0xf17,%eax
 722:	e8 39 fe ff ff       	call   560 <assert.part.0>
 727:	eb d1                	jmp    6fa <plus_three+0x3a>
 729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 730:	ba 37 00 00 00       	mov    $0x37,%edx
 735:	b8 02 0f 00 00       	mov    $0xf02,%eax
 73a:	e8 21 fe ff ff       	call   560 <assert.part.0>
 73f:	eb 97                	jmp    6d8 <plus_three+0x18>
 741:	eb 0d                	jmp    750 <times_five>
 743:	90                   	nop
 744:	90                   	nop
 745:	90                   	nop
 746:	90                   	nop
 747:	90                   	nop
 748:	90                   	nop
 749:	90                   	nop
 74a:	90                   	nop
 74b:	90                   	nop
 74c:	90                   	nop
 74d:	90                   	nop
 74e:	90                   	nop
 74f:	90                   	nop

00000750 <times_five>:

void*
times_five(void)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	83 ec 14             	sub    $0x14,%esp
	shared *= 5;
 756:	a1 b4 14 00 00       	mov    0x14b4,%eax
	//unblocks plus_three when done
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex"); 
 75b:	ff 35 b0 14 00 00    	pushl  0x14b0
}

void*
times_five(void)
{
	shared *= 5;
 761:	8d 04 80             	lea    (%eax,%eax,4),%eax
 764:	a3 b4 14 00 00       	mov    %eax,0x14b4
	//unblocks plus_three when done
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex"); 
 769:	e8 7c 03 00 00       	call   aea <kthread_mutex_unlock>
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
	if(!assumption)
 76e:	83 c4 10             	add    $0x10,%esp
 771:	85 c0                	test   %eax,%eax
 773:	78 1b                	js     790 <times_five+0x40>
{
	shared *= 5;
	//unblocks plus_three when done
	ASSERT(kthread_mutex_unlock(mutex) >= 0, "failed to unlock mutex"); 

	kthread_exit();
 775:	e8 48 03 00 00       	call   ac2 <kthread_exit>
 77a:	b8 9c 0f 00 00       	mov    $0xf9c,%eax
 77f:	ba 48 00 00 00       	mov    $0x48,%edx
 784:	e8 d7 fd ff ff       	call   560 <assert.part.0>
	ASSERT(0, "thread continues to execute after exit");
	  return 0;
}
 789:	31 c0                	xor    %eax,%eax
 78b:	c9                   	leave  
 78c:	c3                   	ret    
 78d:	8d 76 00             	lea    0x0(%esi),%esi
 790:	ba 45 00 00 00       	mov    $0x45,%edx
 795:	b8 17 0f 00 00       	mov    $0xf17,%eax
 79a:	e8 c1 fd ff ff       	call   560 <assert.part.0>
 79f:	eb d4                	jmp    775 <times_five+0x25>
 7a1:	eb 0d                	jmp    7b0 <assert>
 7a3:	90                   	nop
 7a4:	90                   	nop
 7a5:	90                   	nop
 7a6:	90                   	nop
 7a7:	90                   	nop
 7a8:	90                   	nop
 7a9:	90                   	nop
 7aa:	90                   	nop
 7ab:	90                   	nop
 7ac:	90                   	nop
 7ad:	90                   	nop
 7ae:	90                   	nop
 7af:	90                   	nop

000007b0 <assert>:
int thread_ids[5];
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
	if(!assumption)
 7b3:	80 7d 08 00          	cmpb   $0x0,0x8(%ebp)
int thread_ids[5];
volatile int shared;

void
assert(_Bool assumption, char* errMsg, int curLine)
{
 7b7:	8b 45 0c             	mov    0xc(%ebp),%eax
 7ba:	8b 55 10             	mov    0x10(%ebp),%edx
	if(!assumption)
 7bd:	74 09                	je     7c8 <assert+0x18>
		printf(stdout, "at %s:%d, ", __FILE__, curLine);
		printf(stdout, "%s\n", errMsg);
		printf(stdout, "test failed\n");
		kill(pid);
	}
}
 7bf:	5d                   	pop    %ebp
 7c0:	c3                   	ret    
 7c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7c8:	5d                   	pop    %ebp
 7c9:	e9 92 fd ff ff       	jmp    560 <assert.part.0>
 7ce:	66 90                	xchg   %ax,%ax

000007d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	53                   	push   %ebx
 7d4:	8b 45 08             	mov    0x8(%ebp),%eax
 7d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 7da:	89 c2                	mov    %eax,%edx
 7dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7e0:	83 c1 01             	add    $0x1,%ecx
 7e3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 7e7:	83 c2 01             	add    $0x1,%edx
 7ea:	84 db                	test   %bl,%bl
 7ec:	88 5a ff             	mov    %bl,-0x1(%edx)
 7ef:	75 ef                	jne    7e0 <strcpy+0x10>
    ;
  return os;
}
 7f1:	5b                   	pop    %ebx
 7f2:	5d                   	pop    %ebp
 7f3:	c3                   	ret    
 7f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000800 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	56                   	push   %esi
 804:	53                   	push   %ebx
 805:	8b 55 08             	mov    0x8(%ebp),%edx
 808:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 80b:	0f b6 02             	movzbl (%edx),%eax
 80e:	0f b6 19             	movzbl (%ecx),%ebx
 811:	84 c0                	test   %al,%al
 813:	75 1e                	jne    833 <strcmp+0x33>
 815:	eb 29                	jmp    840 <strcmp+0x40>
 817:	89 f6                	mov    %esi,%esi
 819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 820:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 823:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 826:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 829:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 82d:	84 c0                	test   %al,%al
 82f:	74 0f                	je     840 <strcmp+0x40>
 831:	89 f1                	mov    %esi,%ecx
 833:	38 d8                	cmp    %bl,%al
 835:	74 e9                	je     820 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 837:	29 d8                	sub    %ebx,%eax
}
 839:	5b                   	pop    %ebx
 83a:	5e                   	pop    %esi
 83b:	5d                   	pop    %ebp
 83c:	c3                   	ret    
 83d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 840:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 842:	29 d8                	sub    %ebx,%eax
}
 844:	5b                   	pop    %ebx
 845:	5e                   	pop    %esi
 846:	5d                   	pop    %ebp
 847:	c3                   	ret    
 848:	90                   	nop
 849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000850 <strlen>:

uint
strlen(char *s)
{
 850:	55                   	push   %ebp
 851:	89 e5                	mov    %esp,%ebp
 853:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 856:	80 39 00             	cmpb   $0x0,(%ecx)
 859:	74 12                	je     86d <strlen+0x1d>
 85b:	31 d2                	xor    %edx,%edx
 85d:	8d 76 00             	lea    0x0(%esi),%esi
 860:	83 c2 01             	add    $0x1,%edx
 863:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 867:	89 d0                	mov    %edx,%eax
 869:	75 f5                	jne    860 <strlen+0x10>
    ;
  return n;
}
 86b:	5d                   	pop    %ebp
 86c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 86d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 86f:	5d                   	pop    %ebp
 870:	c3                   	ret    
 871:	eb 0d                	jmp    880 <memset>
 873:	90                   	nop
 874:	90                   	nop
 875:	90                   	nop
 876:	90                   	nop
 877:	90                   	nop
 878:	90                   	nop
 879:	90                   	nop
 87a:	90                   	nop
 87b:	90                   	nop
 87c:	90                   	nop
 87d:	90                   	nop
 87e:	90                   	nop
 87f:	90                   	nop

00000880 <memset>:

void*
memset(void *dst, int c, uint n)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	57                   	push   %edi
 884:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 887:	8b 4d 10             	mov    0x10(%ebp),%ecx
 88a:	8b 45 0c             	mov    0xc(%ebp),%eax
 88d:	89 d7                	mov    %edx,%edi
 88f:	fc                   	cld    
 890:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 892:	89 d0                	mov    %edx,%eax
 894:	5f                   	pop    %edi
 895:	5d                   	pop    %ebp
 896:	c3                   	ret    
 897:	89 f6                	mov    %esi,%esi
 899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008a0 <strchr>:

char*
strchr(const char *s, char c)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	53                   	push   %ebx
 8a4:	8b 45 08             	mov    0x8(%ebp),%eax
 8a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 8aa:	0f b6 10             	movzbl (%eax),%edx
 8ad:	84 d2                	test   %dl,%dl
 8af:	74 1d                	je     8ce <strchr+0x2e>
    if(*s == c)
 8b1:	38 d3                	cmp    %dl,%bl
 8b3:	89 d9                	mov    %ebx,%ecx
 8b5:	75 0d                	jne    8c4 <strchr+0x24>
 8b7:	eb 17                	jmp    8d0 <strchr+0x30>
 8b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8c0:	38 ca                	cmp    %cl,%dl
 8c2:	74 0c                	je     8d0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 8c4:	83 c0 01             	add    $0x1,%eax
 8c7:	0f b6 10             	movzbl (%eax),%edx
 8ca:	84 d2                	test   %dl,%dl
 8cc:	75 f2                	jne    8c0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 8ce:	31 c0                	xor    %eax,%eax
}
 8d0:	5b                   	pop    %ebx
 8d1:	5d                   	pop    %ebp
 8d2:	c3                   	ret    
 8d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008e0 <gets>:

char*
gets(char *buf, int max)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	57                   	push   %edi
 8e4:	56                   	push   %esi
 8e5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 8e6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 8e8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 8eb:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 8ee:	eb 29                	jmp    919 <gets+0x39>
    cc = read(0, &c, 1);
 8f0:	83 ec 04             	sub    $0x4,%esp
 8f3:	6a 01                	push   $0x1
 8f5:	57                   	push   %edi
 8f6:	6a 00                	push   $0x0
 8f8:	e8 2d 01 00 00       	call   a2a <read>
    if(cc < 1)
 8fd:	83 c4 10             	add    $0x10,%esp
 900:	85 c0                	test   %eax,%eax
 902:	7e 1d                	jle    921 <gets+0x41>
      break;
    buf[i++] = c;
 904:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 908:	8b 55 08             	mov    0x8(%ebp),%edx
 90b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 90d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 90f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 913:	74 1b                	je     930 <gets+0x50>
 915:	3c 0d                	cmp    $0xd,%al
 917:	74 17                	je     930 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 919:	8d 5e 01             	lea    0x1(%esi),%ebx
 91c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 91f:	7c cf                	jl     8f0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 921:	8b 45 08             	mov    0x8(%ebp),%eax
 924:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 928:	8d 65 f4             	lea    -0xc(%ebp),%esp
 92b:	5b                   	pop    %ebx
 92c:	5e                   	pop    %esi
 92d:	5f                   	pop    %edi
 92e:	5d                   	pop    %ebp
 92f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 930:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 933:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 935:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 939:	8d 65 f4             	lea    -0xc(%ebp),%esp
 93c:	5b                   	pop    %ebx
 93d:	5e                   	pop    %esi
 93e:	5f                   	pop    %edi
 93f:	5d                   	pop    %ebp
 940:	c3                   	ret    
 941:	eb 0d                	jmp    950 <stat>
 943:	90                   	nop
 944:	90                   	nop
 945:	90                   	nop
 946:	90                   	nop
 947:	90                   	nop
 948:	90                   	nop
 949:	90                   	nop
 94a:	90                   	nop
 94b:	90                   	nop
 94c:	90                   	nop
 94d:	90                   	nop
 94e:	90                   	nop
 94f:	90                   	nop

00000950 <stat>:

int
stat(char *n, struct stat *st)
{
 950:	55                   	push   %ebp
 951:	89 e5                	mov    %esp,%ebp
 953:	56                   	push   %esi
 954:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 955:	83 ec 08             	sub    $0x8,%esp
 958:	6a 00                	push   $0x0
 95a:	ff 75 08             	pushl  0x8(%ebp)
 95d:	e8 f0 00 00 00       	call   a52 <open>
  if(fd < 0)
 962:	83 c4 10             	add    $0x10,%esp
 965:	85 c0                	test   %eax,%eax
 967:	78 27                	js     990 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 969:	83 ec 08             	sub    $0x8,%esp
 96c:	ff 75 0c             	pushl  0xc(%ebp)
 96f:	89 c3                	mov    %eax,%ebx
 971:	50                   	push   %eax
 972:	e8 f3 00 00 00       	call   a6a <fstat>
 977:	89 c6                	mov    %eax,%esi
  close(fd);
 979:	89 1c 24             	mov    %ebx,(%esp)
 97c:	e8 b9 00 00 00       	call   a3a <close>
  return r;
 981:	83 c4 10             	add    $0x10,%esp
 984:	89 f0                	mov    %esi,%eax
}
 986:	8d 65 f8             	lea    -0x8(%ebp),%esp
 989:	5b                   	pop    %ebx
 98a:	5e                   	pop    %esi
 98b:	5d                   	pop    %ebp
 98c:	c3                   	ret    
 98d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 990:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 995:	eb ef                	jmp    986 <stat+0x36>
 997:	89 f6                	mov    %esi,%esi
 999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009a0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 9a0:	55                   	push   %ebp
 9a1:	89 e5                	mov    %esp,%ebp
 9a3:	53                   	push   %ebx
 9a4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 9a7:	0f be 11             	movsbl (%ecx),%edx
 9aa:	8d 42 d0             	lea    -0x30(%edx),%eax
 9ad:	3c 09                	cmp    $0x9,%al
 9af:	b8 00 00 00 00       	mov    $0x0,%eax
 9b4:	77 1f                	ja     9d5 <atoi+0x35>
 9b6:	8d 76 00             	lea    0x0(%esi),%esi
 9b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 9c0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 9c3:	83 c1 01             	add    $0x1,%ecx
 9c6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 9ca:	0f be 11             	movsbl (%ecx),%edx
 9cd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 9d0:	80 fb 09             	cmp    $0x9,%bl
 9d3:	76 eb                	jbe    9c0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 9d5:	5b                   	pop    %ebx
 9d6:	5d                   	pop    %ebp
 9d7:	c3                   	ret    
 9d8:	90                   	nop
 9d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000009e0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 9e0:	55                   	push   %ebp
 9e1:	89 e5                	mov    %esp,%ebp
 9e3:	56                   	push   %esi
 9e4:	53                   	push   %ebx
 9e5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 9e8:	8b 45 08             	mov    0x8(%ebp),%eax
 9eb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 9ee:	85 db                	test   %ebx,%ebx
 9f0:	7e 14                	jle    a06 <memmove+0x26>
 9f2:	31 d2                	xor    %edx,%edx
 9f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 9f8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 9fc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 9ff:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 a02:	39 da                	cmp    %ebx,%edx
 a04:	75 f2                	jne    9f8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 a06:	5b                   	pop    %ebx
 a07:	5e                   	pop    %esi
 a08:	5d                   	pop    %ebp
 a09:	c3                   	ret    

00000a0a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 a0a:	b8 01 00 00 00       	mov    $0x1,%eax
 a0f:	cd 40                	int    $0x40
 a11:	c3                   	ret    

00000a12 <exit>:
SYSCALL(exit)
 a12:	b8 02 00 00 00       	mov    $0x2,%eax
 a17:	cd 40                	int    $0x40
 a19:	c3                   	ret    

00000a1a <wait>:
SYSCALL(wait)
 a1a:	b8 03 00 00 00       	mov    $0x3,%eax
 a1f:	cd 40                	int    $0x40
 a21:	c3                   	ret    

00000a22 <pipe>:
SYSCALL(pipe)
 a22:	b8 04 00 00 00       	mov    $0x4,%eax
 a27:	cd 40                	int    $0x40
 a29:	c3                   	ret    

00000a2a <read>:
SYSCALL(read)
 a2a:	b8 05 00 00 00       	mov    $0x5,%eax
 a2f:	cd 40                	int    $0x40
 a31:	c3                   	ret    

00000a32 <write>:
SYSCALL(write)
 a32:	b8 10 00 00 00       	mov    $0x10,%eax
 a37:	cd 40                	int    $0x40
 a39:	c3                   	ret    

00000a3a <close>:
SYSCALL(close)
 a3a:	b8 15 00 00 00       	mov    $0x15,%eax
 a3f:	cd 40                	int    $0x40
 a41:	c3                   	ret    

00000a42 <kill>:
SYSCALL(kill)
 a42:	b8 06 00 00 00       	mov    $0x6,%eax
 a47:	cd 40                	int    $0x40
 a49:	c3                   	ret    

00000a4a <exec>:
SYSCALL(exec)
 a4a:	b8 07 00 00 00       	mov    $0x7,%eax
 a4f:	cd 40                	int    $0x40
 a51:	c3                   	ret    

00000a52 <open>:
SYSCALL(open)
 a52:	b8 0f 00 00 00       	mov    $0xf,%eax
 a57:	cd 40                	int    $0x40
 a59:	c3                   	ret    

00000a5a <mknod>:
SYSCALL(mknod)
 a5a:	b8 11 00 00 00       	mov    $0x11,%eax
 a5f:	cd 40                	int    $0x40
 a61:	c3                   	ret    

00000a62 <unlink>:
SYSCALL(unlink)
 a62:	b8 12 00 00 00       	mov    $0x12,%eax
 a67:	cd 40                	int    $0x40
 a69:	c3                   	ret    

00000a6a <fstat>:
SYSCALL(fstat)
 a6a:	b8 08 00 00 00       	mov    $0x8,%eax
 a6f:	cd 40                	int    $0x40
 a71:	c3                   	ret    

00000a72 <link>:
SYSCALL(link)
 a72:	b8 13 00 00 00       	mov    $0x13,%eax
 a77:	cd 40                	int    $0x40
 a79:	c3                   	ret    

00000a7a <mkdir>:
SYSCALL(mkdir)
 a7a:	b8 14 00 00 00       	mov    $0x14,%eax
 a7f:	cd 40                	int    $0x40
 a81:	c3                   	ret    

00000a82 <chdir>:
SYSCALL(chdir)
 a82:	b8 09 00 00 00       	mov    $0x9,%eax
 a87:	cd 40                	int    $0x40
 a89:	c3                   	ret    

00000a8a <dup>:
SYSCALL(dup)
 a8a:	b8 0a 00 00 00       	mov    $0xa,%eax
 a8f:	cd 40                	int    $0x40
 a91:	c3                   	ret    

00000a92 <getpid>:
SYSCALL(getpid)
 a92:	b8 0b 00 00 00       	mov    $0xb,%eax
 a97:	cd 40                	int    $0x40
 a99:	c3                   	ret    

00000a9a <sbrk>:
SYSCALL(sbrk)
 a9a:	b8 0c 00 00 00       	mov    $0xc,%eax
 a9f:	cd 40                	int    $0x40
 aa1:	c3                   	ret    

00000aa2 <sleep>:
SYSCALL(sleep)
 aa2:	b8 0d 00 00 00       	mov    $0xd,%eax
 aa7:	cd 40                	int    $0x40
 aa9:	c3                   	ret    

00000aaa <uptime>:
SYSCALL(uptime)
 aaa:	b8 0e 00 00 00       	mov    $0xe,%eax
 aaf:	cd 40                	int    $0x40
 ab1:	c3                   	ret    

00000ab2 <kthread_create>:
SYSCALL(kthread_create)
 ab2:	b8 16 00 00 00       	mov    $0x16,%eax
 ab7:	cd 40                	int    $0x40
 ab9:	c3                   	ret    

00000aba <kthread_id>:
SYSCALL(kthread_id)
 aba:	b8 17 00 00 00       	mov    $0x17,%eax
 abf:	cd 40                	int    $0x40
 ac1:	c3                   	ret    

00000ac2 <kthread_exit>:
SYSCALL(kthread_exit)
 ac2:	b8 18 00 00 00       	mov    $0x18,%eax
 ac7:	cd 40                	int    $0x40
 ac9:	c3                   	ret    

00000aca <kthread_join>:
SYSCALL(kthread_join)
 aca:	b8 19 00 00 00       	mov    $0x19,%eax
 acf:	cd 40                	int    $0x40
 ad1:	c3                   	ret    

00000ad2 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 ad2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 ad7:	cd 40                	int    $0x40
 ad9:	c3                   	ret    

00000ada <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 ada:	b8 1b 00 00 00       	mov    $0x1b,%eax
 adf:	cd 40                	int    $0x40
 ae1:	c3                   	ret    

00000ae2 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 ae2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 ae7:	cd 40                	int    $0x40
 ae9:	c3                   	ret    

00000aea <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 aea:	b8 1d 00 00 00       	mov    $0x1d,%eax
 aef:	cd 40                	int    $0x40
 af1:	c3                   	ret    

00000af2 <procdump>:
 af2:	b8 1e 00 00 00       	mov    $0x1e,%eax
 af7:	cd 40                	int    $0x40
 af9:	c3                   	ret    
 afa:	66 90                	xchg   %ax,%ax
 afc:	66 90                	xchg   %ax,%ax
 afe:	66 90                	xchg   %ax,%ax

00000b00 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 b00:	55                   	push   %ebp
 b01:	89 e5                	mov    %esp,%ebp
 b03:	57                   	push   %edi
 b04:	56                   	push   %esi
 b05:	53                   	push   %ebx
 b06:	89 c6                	mov    %eax,%esi
 b08:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 b0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 b0e:	85 db                	test   %ebx,%ebx
 b10:	74 7e                	je     b90 <printint+0x90>
 b12:	89 d0                	mov    %edx,%eax
 b14:	c1 e8 1f             	shr    $0x1f,%eax
 b17:	84 c0                	test   %al,%al
 b19:	74 75                	je     b90 <printint+0x90>
    neg = 1;
    x = -xx;
 b1b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 b1d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 b24:	f7 d8                	neg    %eax
 b26:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 b29:	31 ff                	xor    %edi,%edi
 b2b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 b2e:	89 ce                	mov    %ecx,%esi
 b30:	eb 08                	jmp    b3a <printint+0x3a>
 b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 b38:	89 cf                	mov    %ecx,%edi
 b3a:	31 d2                	xor    %edx,%edx
 b3c:	8d 4f 01             	lea    0x1(%edi),%ecx
 b3f:	f7 f6                	div    %esi
 b41:	0f b6 92 0c 11 00 00 	movzbl 0x110c(%edx),%edx
  }while((x /= base) != 0);
 b48:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 b4a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 b4d:	75 e9                	jne    b38 <printint+0x38>
  if(neg)
 b4f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 b52:	8b 75 c0             	mov    -0x40(%ebp),%esi
 b55:	85 c0                	test   %eax,%eax
 b57:	74 08                	je     b61 <printint+0x61>
    buf[i++] = '-';
 b59:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 b5e:	8d 4f 02             	lea    0x2(%edi),%ecx
 b61:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 b65:	8d 76 00             	lea    0x0(%esi),%esi
 b68:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 b6b:	83 ec 04             	sub    $0x4,%esp
 b6e:	83 ef 01             	sub    $0x1,%edi
 b71:	6a 01                	push   $0x1
 b73:	53                   	push   %ebx
 b74:	56                   	push   %esi
 b75:	88 45 d7             	mov    %al,-0x29(%ebp)
 b78:	e8 b5 fe ff ff       	call   a32 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 b7d:	83 c4 10             	add    $0x10,%esp
 b80:	39 df                	cmp    %ebx,%edi
 b82:	75 e4                	jne    b68 <printint+0x68>
    putc(fd, buf[i]);
}
 b84:	8d 65 f4             	lea    -0xc(%ebp),%esp
 b87:	5b                   	pop    %ebx
 b88:	5e                   	pop    %esi
 b89:	5f                   	pop    %edi
 b8a:	5d                   	pop    %ebp
 b8b:	c3                   	ret    
 b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 b90:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 b92:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 b99:	eb 8b                	jmp    b26 <printint+0x26>
 b9b:	90                   	nop
 b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ba0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 ba0:	55                   	push   %ebp
 ba1:	89 e5                	mov    %esp,%ebp
 ba3:	57                   	push   %edi
 ba4:	56                   	push   %esi
 ba5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 ba6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 ba9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 bac:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 baf:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 bb2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 bb5:	0f b6 1e             	movzbl (%esi),%ebx
 bb8:	83 c6 01             	add    $0x1,%esi
 bbb:	84 db                	test   %bl,%bl
 bbd:	0f 84 b0 00 00 00    	je     c73 <printf+0xd3>
 bc3:	31 d2                	xor    %edx,%edx
 bc5:	eb 39                	jmp    c00 <printf+0x60>
 bc7:	89 f6                	mov    %esi,%esi
 bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 bd0:	83 f8 25             	cmp    $0x25,%eax
 bd3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 bd6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 bdb:	74 18                	je     bf5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 bdd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 be0:	83 ec 04             	sub    $0x4,%esp
 be3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 be6:	6a 01                	push   $0x1
 be8:	50                   	push   %eax
 be9:	57                   	push   %edi
 bea:	e8 43 fe ff ff       	call   a32 <write>
 bef:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 bf2:	83 c4 10             	add    $0x10,%esp
 bf5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 bf8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 bfc:	84 db                	test   %bl,%bl
 bfe:	74 73                	je     c73 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 c00:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 c02:	0f be cb             	movsbl %bl,%ecx
 c05:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 c08:	74 c6                	je     bd0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 c0a:	83 fa 25             	cmp    $0x25,%edx
 c0d:	75 e6                	jne    bf5 <printf+0x55>
      if(c == 'd'){
 c0f:	83 f8 64             	cmp    $0x64,%eax
 c12:	0f 84 f8 00 00 00    	je     d10 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 c18:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 c1e:	83 f9 70             	cmp    $0x70,%ecx
 c21:	74 5d                	je     c80 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 c23:	83 f8 73             	cmp    $0x73,%eax
 c26:	0f 84 84 00 00 00    	je     cb0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 c2c:	83 f8 63             	cmp    $0x63,%eax
 c2f:	0f 84 ea 00 00 00    	je     d1f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 c35:	83 f8 25             	cmp    $0x25,%eax
 c38:	0f 84 c2 00 00 00    	je     d00 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 c3e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 c41:	83 ec 04             	sub    $0x4,%esp
 c44:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 c48:	6a 01                	push   $0x1
 c4a:	50                   	push   %eax
 c4b:	57                   	push   %edi
 c4c:	e8 e1 fd ff ff       	call   a32 <write>
 c51:	83 c4 0c             	add    $0xc,%esp
 c54:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 c57:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 c5a:	6a 01                	push   $0x1
 c5c:	50                   	push   %eax
 c5d:	57                   	push   %edi
 c5e:	83 c6 01             	add    $0x1,%esi
 c61:	e8 cc fd ff ff       	call   a32 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c66:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 c6a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 c6d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 c6f:	84 db                	test   %bl,%bl
 c71:	75 8d                	jne    c00 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 c73:	8d 65 f4             	lea    -0xc(%ebp),%esp
 c76:	5b                   	pop    %ebx
 c77:	5e                   	pop    %esi
 c78:	5f                   	pop    %edi
 c79:	5d                   	pop    %ebp
 c7a:	c3                   	ret    
 c7b:	90                   	nop
 c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 c80:	83 ec 0c             	sub    $0xc,%esp
 c83:	b9 10 00 00 00       	mov    $0x10,%ecx
 c88:	6a 00                	push   $0x0
 c8a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 c8d:	89 f8                	mov    %edi,%eax
 c8f:	8b 13                	mov    (%ebx),%edx
 c91:	e8 6a fe ff ff       	call   b00 <printint>
        ap++;
 c96:	89 d8                	mov    %ebx,%eax
 c98:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 c9b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 c9d:	83 c0 04             	add    $0x4,%eax
 ca0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 ca3:	e9 4d ff ff ff       	jmp    bf5 <printf+0x55>
 ca8:	90                   	nop
 ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 cb0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 cb3:	8b 18                	mov    (%eax),%ebx
        ap++;
 cb5:	83 c0 04             	add    $0x4,%eax
 cb8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 cbb:	b8 04 11 00 00       	mov    $0x1104,%eax
 cc0:	85 db                	test   %ebx,%ebx
 cc2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 cc5:	0f b6 03             	movzbl (%ebx),%eax
 cc8:	84 c0                	test   %al,%al
 cca:	74 23                	je     cef <printf+0x14f>
 ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 cd0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 cd3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 cd6:	83 ec 04             	sub    $0x4,%esp
 cd9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 cdb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 cde:	50                   	push   %eax
 cdf:	57                   	push   %edi
 ce0:	e8 4d fd ff ff       	call   a32 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 ce5:	0f b6 03             	movzbl (%ebx),%eax
 ce8:	83 c4 10             	add    $0x10,%esp
 ceb:	84 c0                	test   %al,%al
 ced:	75 e1                	jne    cd0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 cef:	31 d2                	xor    %edx,%edx
 cf1:	e9 ff fe ff ff       	jmp    bf5 <printf+0x55>
 cf6:	8d 76 00             	lea    0x0(%esi),%esi
 cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d00:	83 ec 04             	sub    $0x4,%esp
 d03:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 d06:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 d09:	6a 01                	push   $0x1
 d0b:	e9 4c ff ff ff       	jmp    c5c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 d10:	83 ec 0c             	sub    $0xc,%esp
 d13:	b9 0a 00 00 00       	mov    $0xa,%ecx
 d18:	6a 01                	push   $0x1
 d1a:	e9 6b ff ff ff       	jmp    c8a <printf+0xea>
 d1f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 d22:	83 ec 04             	sub    $0x4,%esp
 d25:	8b 03                	mov    (%ebx),%eax
 d27:	6a 01                	push   $0x1
 d29:	88 45 e4             	mov    %al,-0x1c(%ebp)
 d2c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 d2f:	50                   	push   %eax
 d30:	57                   	push   %edi
 d31:	e8 fc fc ff ff       	call   a32 <write>
 d36:	e9 5b ff ff ff       	jmp    c96 <printf+0xf6>
 d3b:	66 90                	xchg   %ax,%ax
 d3d:	66 90                	xchg   %ax,%ax
 d3f:	90                   	nop

00000d40 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 d40:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d41:	a1 8c 14 00 00       	mov    0x148c,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 d46:	89 e5                	mov    %esp,%ebp
 d48:	57                   	push   %edi
 d49:	56                   	push   %esi
 d4a:	53                   	push   %ebx
 d4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d4e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 d50:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d53:	39 c8                	cmp    %ecx,%eax
 d55:	73 19                	jae    d70 <free+0x30>
 d57:	89 f6                	mov    %esi,%esi
 d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 d60:	39 d1                	cmp    %edx,%ecx
 d62:	72 1c                	jb     d80 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d64:	39 d0                	cmp    %edx,%eax
 d66:	73 18                	jae    d80 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 d68:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d6a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d6c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 d6e:	72 f0                	jb     d60 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 d70:	39 d0                	cmp    %edx,%eax
 d72:	72 f4                	jb     d68 <free+0x28>
 d74:	39 d1                	cmp    %edx,%ecx
 d76:	73 f0                	jae    d68 <free+0x28>
 d78:	90                   	nop
 d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 d80:	8b 73 fc             	mov    -0x4(%ebx),%esi
 d83:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 d86:	39 d7                	cmp    %edx,%edi
 d88:	74 19                	je     da3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 d8a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 d8d:	8b 50 04             	mov    0x4(%eax),%edx
 d90:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 d93:	39 f1                	cmp    %esi,%ecx
 d95:	74 23                	je     dba <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 d97:	89 08                	mov    %ecx,(%eax)
  freep = p;
 d99:	a3 8c 14 00 00       	mov    %eax,0x148c
}
 d9e:	5b                   	pop    %ebx
 d9f:	5e                   	pop    %esi
 da0:	5f                   	pop    %edi
 da1:	5d                   	pop    %ebp
 da2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 da3:	03 72 04             	add    0x4(%edx),%esi
 da6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 da9:	8b 10                	mov    (%eax),%edx
 dab:	8b 12                	mov    (%edx),%edx
 dad:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 db0:	8b 50 04             	mov    0x4(%eax),%edx
 db3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 db6:	39 f1                	cmp    %esi,%ecx
 db8:	75 dd                	jne    d97 <free+0x57>
    p->s.size += bp->s.size;
 dba:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 dbd:	a3 8c 14 00 00       	mov    %eax,0x148c
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 dc2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 dc5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 dc8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 dca:	5b                   	pop    %ebx
 dcb:	5e                   	pop    %esi
 dcc:	5f                   	pop    %edi
 dcd:	5d                   	pop    %ebp
 dce:	c3                   	ret    
 dcf:	90                   	nop

00000dd0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 dd0:	55                   	push   %ebp
 dd1:	89 e5                	mov    %esp,%ebp
 dd3:	57                   	push   %edi
 dd4:	56                   	push   %esi
 dd5:	53                   	push   %ebx
 dd6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 ddc:	8b 15 8c 14 00 00    	mov    0x148c,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 de2:	8d 78 07             	lea    0x7(%eax),%edi
 de5:	c1 ef 03             	shr    $0x3,%edi
 de8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 deb:	85 d2                	test   %edx,%edx
 ded:	0f 84 a3 00 00 00    	je     e96 <malloc+0xc6>
 df3:	8b 02                	mov    (%edx),%eax
 df5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 df8:	39 cf                	cmp    %ecx,%edi
 dfa:	76 74                	jbe    e70 <malloc+0xa0>
 dfc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 e02:	be 00 10 00 00       	mov    $0x1000,%esi
 e07:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 e0e:	0f 43 f7             	cmovae %edi,%esi
 e11:	ba 00 80 00 00       	mov    $0x8000,%edx
 e16:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 e1c:	0f 46 da             	cmovbe %edx,%ebx
 e1f:	eb 10                	jmp    e31 <malloc+0x61>
 e21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e28:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 e2a:	8b 48 04             	mov    0x4(%eax),%ecx
 e2d:	39 cf                	cmp    %ecx,%edi
 e2f:	76 3f                	jbe    e70 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 e31:	39 05 8c 14 00 00    	cmp    %eax,0x148c
 e37:	89 c2                	mov    %eax,%edx
 e39:	75 ed                	jne    e28 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 e3b:	83 ec 0c             	sub    $0xc,%esp
 e3e:	53                   	push   %ebx
 e3f:	e8 56 fc ff ff       	call   a9a <sbrk>
  if(p == (char*)-1)
 e44:	83 c4 10             	add    $0x10,%esp
 e47:	83 f8 ff             	cmp    $0xffffffff,%eax
 e4a:	74 1c                	je     e68 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 e4c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 e4f:	83 ec 0c             	sub    $0xc,%esp
 e52:	83 c0 08             	add    $0x8,%eax
 e55:	50                   	push   %eax
 e56:	e8 e5 fe ff ff       	call   d40 <free>
  return freep;
 e5b:	8b 15 8c 14 00 00    	mov    0x148c,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 e61:	83 c4 10             	add    $0x10,%esp
 e64:	85 d2                	test   %edx,%edx
 e66:	75 c0                	jne    e28 <malloc+0x58>
        return 0;
 e68:	31 c0                	xor    %eax,%eax
 e6a:	eb 1c                	jmp    e88 <malloc+0xb8>
 e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 e70:	39 cf                	cmp    %ecx,%edi
 e72:	74 1c                	je     e90 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 e74:	29 f9                	sub    %edi,%ecx
 e76:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 e79:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 e7c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 e7f:	89 15 8c 14 00 00    	mov    %edx,0x148c
      return (void*)(p + 1);
 e85:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 e88:	8d 65 f4             	lea    -0xc(%ebp),%esp
 e8b:	5b                   	pop    %ebx
 e8c:	5e                   	pop    %esi
 e8d:	5f                   	pop    %edi
 e8e:	5d                   	pop    %ebp
 e8f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 e90:	8b 08                	mov    (%eax),%ecx
 e92:	89 0a                	mov    %ecx,(%edx)
 e94:	eb e9                	jmp    e7f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 e96:	c7 05 8c 14 00 00 90 	movl   $0x1490,0x148c
 e9d:	14 00 00 
 ea0:	c7 05 90 14 00 00 90 	movl   $0x1490,0x1490
 ea7:	14 00 00 
    base.s.size = 0;
 eaa:	b8 90 14 00 00       	mov    $0x1490,%eax
 eaf:	c7 05 94 14 00 00 00 	movl   $0x0,0x1494
 eb6:	00 00 00 
 eb9:	e9 3e ff ff ff       	jmp    dfc <malloc+0x2c>
