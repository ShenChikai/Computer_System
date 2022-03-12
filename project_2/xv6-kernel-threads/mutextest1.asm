
_mutextest1:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
	kthread_exit();
	printf(1,"Error: returned from exit !!");
}

int main(int argc, char** argv)
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
	printf(1,"~~~~~~~~~~~~~~~~~~ mutex test 1 ~~~~~~~~~~~~~~~~~~\n");
  13:	68 b4 09 00 00       	push   $0x9b4
  18:	6a 01                	push   $0x1
  1a:	e8 31 06 00 00       	call   650 <printf>
	int input,i;
	mutex = kthread_mutex_alloc();
  1f:	e8 5e 05 00 00       	call   582 <kthread_mutex_alloc>

	if(mutex<0) {
  24:	83 c4 10             	add    $0x10,%esp
  27:	85 c0                	test   %eax,%eax

int main(int argc, char** argv)
{
	printf(1,"~~~~~~~~~~~~~~~~~~ mutex test 1 ~~~~~~~~~~~~~~~~~~\n");
	int input,i;
	mutex = kthread_mutex_alloc();
  29:	a3 04 0e 00 00       	mov    %eax,0xe04

	if(mutex<0) {
  2e:	0f 88 73 01 00 00    	js     1a7 <main+0x1a7>
	kthread_exit();
	printf(1,"Error: returned from exit !!");
}

int main(int argc, char** argv)
{
  34:	be 0f 00 00 00       	mov    $0xf,%esi
  39:	eb 58                	jmp    93 <main+0x93>
  3b:	90                   	nop
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

		printf(1,"joining on thread %d\n",tid);

		if(test) { printf(1,"Error: mutex didnt prevent writing!\n"); }

		input = kthread_mutex_unlock(mutex);
  40:	83 ec 0c             	sub    $0xc,%esp
  43:	ff 35 04 0e 00 00    	pushl  0xe04
  49:	e8 4c 05 00 00       	call   59a <kthread_mutex_unlock>

		if(input<0) { printf(1,"Error: mutex didnt unlock!\n"); }
  4e:	83 c4 10             	add    $0x10,%esp
  51:	85 c0                	test   %eax,%eax
  53:	0f 88 ef 00 00 00    	js     148 <main+0x148>

		kthread_join(tid);
  59:	83 ec 0c             	sub    $0xc,%esp
  5c:	53                   	push   %ebx
  5d:	e8 18 05 00 00       	call   57a <kthread_join>

		if(!test) { printf(1,"Error: thread didnt run!\n"); }
  62:	8b 0d 08 0e 00 00    	mov    0xe08,%ecx
  68:	83 c4 10             	add    $0x10,%esp
  6b:	85 c9                	test   %ecx,%ecx
  6d:	0f 84 a5 00 00 00    	je     118 <main+0x118>

		printf(1,"finished join\n");
  73:	83 ec 08             	sub    $0x8,%esp
  76:	68 f4 0a 00 00       	push   $0xaf4
  7b:	6a 01                	push   $0x1
  7d:	e8 ce 05 00 00       	call   650 <printf>

	if(mutex<0) {
		printf(1,"Error: mutex didnt alloc! (%d)\n",mutex);
	}

	for(i = 0; i<15; i++) {
  82:	83 c4 10             	add    $0x10,%esp
  85:	83 ee 01             	sub    $0x1,%esi
  88:	0f 84 f2 00 00 00    	je     180 <main+0x180>
  8e:	a1 04 0e 00 00       	mov    0xe04,%eax
		test=0;
		input = kthread_mutex_lock(mutex);
  93:	83 ec 0c             	sub    $0xc,%esp
	if(mutex<0) {
		printf(1,"Error: mutex didnt alloc! (%d)\n",mutex);
	}

	for(i = 0; i<15; i++) {
		test=0;
  96:	c7 05 08 0e 00 00 00 	movl   $0x0,0xe08
  9d:	00 00 00 
		input = kthread_mutex_lock(mutex);
  a0:	50                   	push   %eax
  a1:	e8 ec 04 00 00       	call   592 <kthread_mutex_lock>

		if(input<0) {
  a6:	83 c4 10             	add    $0x10,%esp
  a9:	85 c0                	test   %eax,%eax
  ab:	0f 88 af 00 00 00    	js     160 <main+0x160>
			printf(1,"Error: mutex didnt lock! (%d)\n",input);
		}

		char* stack = malloc(1024);
  b1:	83 ec 0c             	sub    $0xc,%esp
  b4:	68 00 04 00 00       	push   $0x400
  b9:	e8 c2 07 00 00       	call   880 <malloc>
		int tid = kthread_create((void*)printer, stack, 1024);
  be:	83 c4 0c             	add    $0xc,%esp
  c1:	68 00 04 00 00       	push   $0x400
  c6:	50                   	push   %eax
  c7:	68 e0 01 00 00       	push   $0x1e0
  cc:	e8 91 04 00 00       	call   562 <kthread_create>

		if(tid<0) { printf(1,"Thread wasnt created correctly! (%d)\n",tid); }
  d1:	83 c4 10             	add    $0x10,%esp
  d4:	85 c0                	test   %eax,%eax
		if(input<0) {
			printf(1,"Error: mutex didnt lock! (%d)\n",input);
		}

		char* stack = malloc(1024);
		int tid = kthread_create((void*)printer, stack, 1024);
  d6:	89 c3                	mov    %eax,%ebx

		if(tid<0) { printf(1,"Thread wasnt created correctly! (%d)\n",tid); }
  d8:	78 56                	js     130 <main+0x130>

		printf(1,"joining on thread %d\n",tid);
  da:	83 ec 04             	sub    $0x4,%esp
  dd:	53                   	push   %ebx
  de:	68 a8 0a 00 00       	push   $0xaa8
  e3:	6a 01                	push   $0x1
  e5:	e8 66 05 00 00       	call   650 <printf>

		if(test) { printf(1,"Error: mutex didnt prevent writing!\n"); }
  ea:	a1 08 0e 00 00       	mov    0xe08,%eax
  ef:	83 c4 10             	add    $0x10,%esp
  f2:	85 c0                	test   %eax,%eax
  f4:	0f 84 46 ff ff ff    	je     40 <main+0x40>
  fa:	83 ec 08             	sub    $0x8,%esp
  fd:	68 50 0a 00 00       	push   $0xa50
 102:	6a 01                	push   $0x1
 104:	e8 47 05 00 00       	call   650 <printf>
 109:	83 c4 10             	add    $0x10,%esp
 10c:	e9 2f ff ff ff       	jmp    40 <main+0x40>
 111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

		if(input<0) { printf(1,"Error: mutex didnt unlock!\n"); }

		kthread_join(tid);

		if(!test) { printf(1,"Error: thread didnt run!\n"); }
 118:	83 ec 08             	sub    $0x8,%esp
 11b:	68 da 0a 00 00       	push   $0xada
 120:	6a 01                	push   $0x1
 122:	e8 29 05 00 00       	call   650 <printf>
 127:	83 c4 10             	add    $0x10,%esp
 12a:	e9 44 ff ff ff       	jmp    73 <main+0x73>
 12f:	90                   	nop
		}

		char* stack = malloc(1024);
		int tid = kthread_create((void*)printer, stack, 1024);

		if(tid<0) { printf(1,"Thread wasnt created correctly! (%d)\n",tid); }
 130:	83 ec 04             	sub    $0x4,%esp
 133:	50                   	push   %eax
 134:	68 28 0a 00 00       	push   $0xa28
 139:	6a 01                	push   $0x1
 13b:	e8 10 05 00 00       	call   650 <printf>
 140:	83 c4 10             	add    $0x10,%esp
 143:	eb 95                	jmp    da <main+0xda>
 145:	8d 76 00             	lea    0x0(%esi),%esi

		if(test) { printf(1,"Error: mutex didnt prevent writing!\n"); }

		input = kthread_mutex_unlock(mutex);

		if(input<0) { printf(1,"Error: mutex didnt unlock!\n"); }
 148:	83 ec 08             	sub    $0x8,%esp
 14b:	68 be 0a 00 00       	push   $0xabe
 150:	6a 01                	push   $0x1
 152:	e8 f9 04 00 00       	call   650 <printf>
 157:	83 c4 10             	add    $0x10,%esp
 15a:	e9 fa fe ff ff       	jmp    59 <main+0x59>
 15f:	90                   	nop
	for(i = 0; i<15; i++) {
		test=0;
		input = kthread_mutex_lock(mutex);

		if(input<0) {
			printf(1,"Error: mutex didnt lock! (%d)\n",input);
 160:	83 ec 04             	sub    $0x4,%esp
 163:	50                   	push   %eax
 164:	68 08 0a 00 00       	push   $0xa08
 169:	6a 01                	push   $0x1
 16b:	e8 e0 04 00 00       	call   650 <printf>
 170:	83 c4 10             	add    $0x10,%esp
 173:	e9 39 ff ff ff       	jmp    b1 <main+0xb1>
 178:	90                   	nop
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		if(!test) { printf(1,"Error: thread didnt run!\n"); }

		printf(1,"finished join\n");
	}

	printf(1,"Finished.\n");
 180:	83 ec 08             	sub    $0x8,%esp
 183:	68 03 0b 00 00       	push   $0xb03
 188:	6a 01                	push   $0x1
 18a:	e8 c1 04 00 00       	call   650 <printf>

	input = kthread_mutex_dealloc(mutex);
 18f:	5a                   	pop    %edx
 190:	ff 35 04 0e 00 00    	pushl  0xe04
 196:	e8 ef 03 00 00       	call   58a <kthread_mutex_dealloc>

	if(input<0) {
 19b:	83 c4 10             	add    $0x10,%esp
 19e:	85 c0                	test   %eax,%eax
 1a0:	78 20                	js     1c2 <main+0x1c2>
		printf(1,"Error: mutex didnt dealloc!\n");
	}

	exit();
 1a2:	e8 1b 03 00 00       	call   4c2 <exit>
	printf(1,"~~~~~~~~~~~~~~~~~~ mutex test 1 ~~~~~~~~~~~~~~~~~~\n");
	int input,i;
	mutex = kthread_mutex_alloc();

	if(mutex<0) {
		printf(1,"Error: mutex didnt alloc! (%d)\n",mutex);
 1a7:	52                   	push   %edx
 1a8:	50                   	push   %eax
 1a9:	68 e8 09 00 00       	push   $0x9e8
 1ae:	6a 01                	push   $0x1
 1b0:	e8 9b 04 00 00       	call   650 <printf>
 1b5:	a1 04 0e 00 00       	mov    0xe04,%eax
 1ba:	83 c4 10             	add    $0x10,%esp
 1bd:	e9 72 fe ff ff       	jmp    34 <main+0x34>
	printf(1,"Finished.\n");

	input = kthread_mutex_dealloc(mutex);

	if(input<0) {
		printf(1,"Error: mutex didnt dealloc!\n");
 1c2:	50                   	push   %eax
 1c3:	50                   	push   %eax
 1c4:	68 0e 0b 00 00       	push   $0xb0e
 1c9:	6a 01                	push   $0x1
 1cb:	e8 80 04 00 00       	call   650 <printf>
 1d0:	83 c4 10             	add    $0x10,%esp
 1d3:	eb cd                	jmp    1a2 <main+0x1a2>
 1d5:	66 90                	xchg   %ax,%ax
 1d7:	66 90                	xchg   %ax,%ax
 1d9:	66 90                	xchg   %ax,%ax
 1db:	66 90                	xchg   %ax,%ax
 1dd:	66 90                	xchg   %ax,%ax
 1df:	90                   	nop

000001e0 <printer>:

int mutex;
int test;

void printer()
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	83 ec 14             	sub    $0x14,%esp
	int input;
	input = kthread_mutex_lock(mutex);
 1e6:	ff 35 04 0e 00 00    	pushl  0xe04
 1ec:	e8 a1 03 00 00       	call   592 <kthread_mutex_lock>

	if(input<0) {
 1f1:	83 c4 10             	add    $0x10,%esp
 1f4:	85 c0                	test   %eax,%eax
 1f6:	78 68                	js     260 <printer+0x80>
		printf(1,"Error: thread mutex didnt lock!");
	}

	printf(1,"thread %d said hi\n",kthread_id());
 1f8:	e8 6d 03 00 00       	call   56a <kthread_id>
 1fd:	83 ec 04             	sub    $0x4,%esp
 200:	50                   	push   %eax
 201:	68 78 0a 00 00       	push   $0xa78
 206:	6a 01                	push   $0x1
 208:	e8 43 04 00 00       	call   650 <printf>
	test=1;
	input = kthread_mutex_unlock(mutex);
 20d:	58                   	pop    %eax
 20e:	ff 35 04 0e 00 00    	pushl  0xe04
	if(input<0) {
		printf(1,"Error: thread mutex didnt lock!");
	}

	printf(1,"thread %d said hi\n",kthread_id());
	test=1;
 214:	c7 05 08 0e 00 00 01 	movl   $0x1,0xe08
 21b:	00 00 00 
	input = kthread_mutex_unlock(mutex);
 21e:	e8 77 03 00 00       	call   59a <kthread_mutex_unlock>

	if(input<0) {
 223:	83 c4 10             	add    $0x10,%esp
 226:	85 c0                	test   %eax,%eax
 228:	78 1e                	js     248 <printer+0x68>
		printf(1,"Error: thread mutex didnt unlock!");
	}

	kthread_exit();
 22a:	e8 43 03 00 00       	call   572 <kthread_exit>
	printf(1,"Error: returned from exit !!");
 22f:	83 ec 08             	sub    $0x8,%esp
 232:	68 8b 0a 00 00       	push   $0xa8b
 237:	6a 01                	push   $0x1
 239:	e8 12 04 00 00       	call   650 <printf>
}
 23e:	83 c4 10             	add    $0x10,%esp
 241:	c9                   	leave  
 242:	c3                   	ret    
 243:	90                   	nop
 244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	printf(1,"thread %d said hi\n",kthread_id());
	test=1;
	input = kthread_mutex_unlock(mutex);

	if(input<0) {
		printf(1,"Error: thread mutex didnt unlock!");
 248:	83 ec 08             	sub    $0x8,%esp
 24b:	68 90 09 00 00       	push   $0x990
 250:	6a 01                	push   $0x1
 252:	e8 f9 03 00 00       	call   650 <printf>
 257:	83 c4 10             	add    $0x10,%esp
 25a:	eb ce                	jmp    22a <printer+0x4a>
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
	int input;
	input = kthread_mutex_lock(mutex);

	if(input<0) {
		printf(1,"Error: thread mutex didnt lock!");
 260:	83 ec 08             	sub    $0x8,%esp
 263:	68 70 09 00 00       	push   $0x970
 268:	6a 01                	push   $0x1
 26a:	e8 e1 03 00 00       	call   650 <printf>
 26f:	83 c4 10             	add    $0x10,%esp
 272:	eb 84                	jmp    1f8 <printer+0x18>
 274:	66 90                	xchg   %ax,%ax
 276:	66 90                	xchg   %ax,%ax
 278:	66 90                	xchg   %ax,%ax
 27a:	66 90                	xchg   %ax,%ax
 27c:	66 90                	xchg   %ax,%ax
 27e:	66 90                	xchg   %ax,%ax

00000280 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	53                   	push   %ebx
 284:	8b 45 08             	mov    0x8(%ebp),%eax
 287:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 28a:	89 c2                	mov    %eax,%edx
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 290:	83 c1 01             	add    $0x1,%ecx
 293:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 297:	83 c2 01             	add    $0x1,%edx
 29a:	84 db                	test   %bl,%bl
 29c:	88 5a ff             	mov    %bl,-0x1(%edx)
 29f:	75 ef                	jne    290 <strcpy+0x10>
    ;
  return os;
}
 2a1:	5b                   	pop    %ebx
 2a2:	5d                   	pop    %ebp
 2a3:	c3                   	ret    
 2a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	53                   	push   %ebx
 2b5:	8b 55 08             	mov    0x8(%ebp),%edx
 2b8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2bb:	0f b6 02             	movzbl (%edx),%eax
 2be:	0f b6 19             	movzbl (%ecx),%ebx
 2c1:	84 c0                	test   %al,%al
 2c3:	75 1e                	jne    2e3 <strcmp+0x33>
 2c5:	eb 29                	jmp    2f0 <strcmp+0x40>
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 2d0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 2d6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2d9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 2dd:	84 c0                	test   %al,%al
 2df:	74 0f                	je     2f0 <strcmp+0x40>
 2e1:	89 f1                	mov    %esi,%ecx
 2e3:	38 d8                	cmp    %bl,%al
 2e5:	74 e9                	je     2d0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2e7:	29 d8                	sub    %ebx,%eax
}
 2e9:	5b                   	pop    %ebx
 2ea:	5e                   	pop    %esi
 2eb:	5d                   	pop    %ebp
 2ec:	c3                   	ret    
 2ed:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2f0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2f2:	29 d8                	sub    %ebx,%eax
}
 2f4:	5b                   	pop    %ebx
 2f5:	5e                   	pop    %esi
 2f6:	5d                   	pop    %ebp
 2f7:	c3                   	ret    
 2f8:	90                   	nop
 2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000300 <strlen>:

uint
strlen(char *s)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 306:	80 39 00             	cmpb   $0x0,(%ecx)
 309:	74 12                	je     31d <strlen+0x1d>
 30b:	31 d2                	xor    %edx,%edx
 30d:	8d 76 00             	lea    0x0(%esi),%esi
 310:	83 c2 01             	add    $0x1,%edx
 313:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 317:	89 d0                	mov    %edx,%eax
 319:	75 f5                	jne    310 <strlen+0x10>
    ;
  return n;
}
 31b:	5d                   	pop    %ebp
 31c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 31d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 31f:	5d                   	pop    %ebp
 320:	c3                   	ret    
 321:	eb 0d                	jmp    330 <memset>
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

00000330 <memset>:

void*
memset(void *dst, int c, uint n)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 337:	8b 4d 10             	mov    0x10(%ebp),%ecx
 33a:	8b 45 0c             	mov    0xc(%ebp),%eax
 33d:	89 d7                	mov    %edx,%edi
 33f:	fc                   	cld    
 340:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 342:	89 d0                	mov    %edx,%eax
 344:	5f                   	pop    %edi
 345:	5d                   	pop    %ebp
 346:	c3                   	ret    
 347:	89 f6                	mov    %esi,%esi
 349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000350 <strchr>:

char*
strchr(const char *s, char c)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	53                   	push   %ebx
 354:	8b 45 08             	mov    0x8(%ebp),%eax
 357:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 35a:	0f b6 10             	movzbl (%eax),%edx
 35d:	84 d2                	test   %dl,%dl
 35f:	74 1d                	je     37e <strchr+0x2e>
    if(*s == c)
 361:	38 d3                	cmp    %dl,%bl
 363:	89 d9                	mov    %ebx,%ecx
 365:	75 0d                	jne    374 <strchr+0x24>
 367:	eb 17                	jmp    380 <strchr+0x30>
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 370:	38 ca                	cmp    %cl,%dl
 372:	74 0c                	je     380 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 374:	83 c0 01             	add    $0x1,%eax
 377:	0f b6 10             	movzbl (%eax),%edx
 37a:	84 d2                	test   %dl,%dl
 37c:	75 f2                	jne    370 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 37e:	31 c0                	xor    %eax,%eax
}
 380:	5b                   	pop    %ebx
 381:	5d                   	pop    %ebp
 382:	c3                   	ret    
 383:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 389:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000390 <gets>:

char*
gets(char *buf, int max)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	57                   	push   %edi
 394:	56                   	push   %esi
 395:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 396:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 398:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 39b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 39e:	eb 29                	jmp    3c9 <gets+0x39>
    cc = read(0, &c, 1);
 3a0:	83 ec 04             	sub    $0x4,%esp
 3a3:	6a 01                	push   $0x1
 3a5:	57                   	push   %edi
 3a6:	6a 00                	push   $0x0
 3a8:	e8 2d 01 00 00       	call   4da <read>
    if(cc < 1)
 3ad:	83 c4 10             	add    $0x10,%esp
 3b0:	85 c0                	test   %eax,%eax
 3b2:	7e 1d                	jle    3d1 <gets+0x41>
      break;
    buf[i++] = c;
 3b4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3b8:	8b 55 08             	mov    0x8(%ebp),%edx
 3bb:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 3bd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 3bf:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 3c3:	74 1b                	je     3e0 <gets+0x50>
 3c5:	3c 0d                	cmp    $0xd,%al
 3c7:	74 17                	je     3e0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3c9:	8d 5e 01             	lea    0x1(%esi),%ebx
 3cc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3cf:	7c cf                	jl     3a0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3d1:	8b 45 08             	mov    0x8(%ebp),%eax
 3d4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3db:	5b                   	pop    %ebx
 3dc:	5e                   	pop    %esi
 3dd:	5f                   	pop    %edi
 3de:	5d                   	pop    %ebp
 3df:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3e0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3e3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3e5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ec:	5b                   	pop    %ebx
 3ed:	5e                   	pop    %esi
 3ee:	5f                   	pop    %edi
 3ef:	5d                   	pop    %ebp
 3f0:	c3                   	ret    
 3f1:	eb 0d                	jmp    400 <stat>
 3f3:	90                   	nop
 3f4:	90                   	nop
 3f5:	90                   	nop
 3f6:	90                   	nop
 3f7:	90                   	nop
 3f8:	90                   	nop
 3f9:	90                   	nop
 3fa:	90                   	nop
 3fb:	90                   	nop
 3fc:	90                   	nop
 3fd:	90                   	nop
 3fe:	90                   	nop
 3ff:	90                   	nop

00000400 <stat>:

int
stat(char *n, struct stat *st)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	56                   	push   %esi
 404:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 405:	83 ec 08             	sub    $0x8,%esp
 408:	6a 00                	push   $0x0
 40a:	ff 75 08             	pushl  0x8(%ebp)
 40d:	e8 f0 00 00 00       	call   502 <open>
  if(fd < 0)
 412:	83 c4 10             	add    $0x10,%esp
 415:	85 c0                	test   %eax,%eax
 417:	78 27                	js     440 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 419:	83 ec 08             	sub    $0x8,%esp
 41c:	ff 75 0c             	pushl  0xc(%ebp)
 41f:	89 c3                	mov    %eax,%ebx
 421:	50                   	push   %eax
 422:	e8 f3 00 00 00       	call   51a <fstat>
 427:	89 c6                	mov    %eax,%esi
  close(fd);
 429:	89 1c 24             	mov    %ebx,(%esp)
 42c:	e8 b9 00 00 00       	call   4ea <close>
  return r;
 431:	83 c4 10             	add    $0x10,%esp
 434:	89 f0                	mov    %esi,%eax
}
 436:	8d 65 f8             	lea    -0x8(%ebp),%esp
 439:	5b                   	pop    %ebx
 43a:	5e                   	pop    %esi
 43b:	5d                   	pop    %ebp
 43c:	c3                   	ret    
 43d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 440:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 445:	eb ef                	jmp    436 <stat+0x36>
 447:	89 f6                	mov    %esi,%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000450 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	53                   	push   %ebx
 454:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 457:	0f be 11             	movsbl (%ecx),%edx
 45a:	8d 42 d0             	lea    -0x30(%edx),%eax
 45d:	3c 09                	cmp    $0x9,%al
 45f:	b8 00 00 00 00       	mov    $0x0,%eax
 464:	77 1f                	ja     485 <atoi+0x35>
 466:	8d 76 00             	lea    0x0(%esi),%esi
 469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 470:	8d 04 80             	lea    (%eax,%eax,4),%eax
 473:	83 c1 01             	add    $0x1,%ecx
 476:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 47a:	0f be 11             	movsbl (%ecx),%edx
 47d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 480:	80 fb 09             	cmp    $0x9,%bl
 483:	76 eb                	jbe    470 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 485:	5b                   	pop    %ebx
 486:	5d                   	pop    %ebp
 487:	c3                   	ret    
 488:	90                   	nop
 489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000490 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	56                   	push   %esi
 494:	53                   	push   %ebx
 495:	8b 5d 10             	mov    0x10(%ebp),%ebx
 498:	8b 45 08             	mov    0x8(%ebp),%eax
 49b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 49e:	85 db                	test   %ebx,%ebx
 4a0:	7e 14                	jle    4b6 <memmove+0x26>
 4a2:	31 d2                	xor    %edx,%edx
 4a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 4a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4af:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4b2:	39 da                	cmp    %ebx,%edx
 4b4:	75 f2                	jne    4a8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 4b6:	5b                   	pop    %ebx
 4b7:	5e                   	pop    %esi
 4b8:	5d                   	pop    %ebp
 4b9:	c3                   	ret    

000004ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4ba:	b8 01 00 00 00       	mov    $0x1,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <exit>:
SYSCALL(exit)
 4c2:	b8 02 00 00 00       	mov    $0x2,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <wait>:
SYSCALL(wait)
 4ca:	b8 03 00 00 00       	mov    $0x3,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <pipe>:
SYSCALL(pipe)
 4d2:	b8 04 00 00 00       	mov    $0x4,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <read>:
SYSCALL(read)
 4da:	b8 05 00 00 00       	mov    $0x5,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <write>:
SYSCALL(write)
 4e2:	b8 10 00 00 00       	mov    $0x10,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <close>:
SYSCALL(close)
 4ea:	b8 15 00 00 00       	mov    $0x15,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <kill>:
SYSCALL(kill)
 4f2:	b8 06 00 00 00       	mov    $0x6,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <exec>:
SYSCALL(exec)
 4fa:	b8 07 00 00 00       	mov    $0x7,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <open>:
SYSCALL(open)
 502:	b8 0f 00 00 00       	mov    $0xf,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <mknod>:
SYSCALL(mknod)
 50a:	b8 11 00 00 00       	mov    $0x11,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <unlink>:
SYSCALL(unlink)
 512:	b8 12 00 00 00       	mov    $0x12,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <fstat>:
SYSCALL(fstat)
 51a:	b8 08 00 00 00       	mov    $0x8,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <link>:
SYSCALL(link)
 522:	b8 13 00 00 00       	mov    $0x13,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <mkdir>:
SYSCALL(mkdir)
 52a:	b8 14 00 00 00       	mov    $0x14,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <chdir>:
SYSCALL(chdir)
 532:	b8 09 00 00 00       	mov    $0x9,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <dup>:
SYSCALL(dup)
 53a:	b8 0a 00 00 00       	mov    $0xa,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <getpid>:
SYSCALL(getpid)
 542:	b8 0b 00 00 00       	mov    $0xb,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <sbrk>:
SYSCALL(sbrk)
 54a:	b8 0c 00 00 00       	mov    $0xc,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <sleep>:
SYSCALL(sleep)
 552:	b8 0d 00 00 00       	mov    $0xd,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <uptime>:
SYSCALL(uptime)
 55a:	b8 0e 00 00 00       	mov    $0xe,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <kthread_create>:
SYSCALL(kthread_create)
 562:	b8 16 00 00 00       	mov    $0x16,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <kthread_id>:
SYSCALL(kthread_id)
 56a:	b8 17 00 00 00       	mov    $0x17,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <kthread_exit>:
SYSCALL(kthread_exit)
 572:	b8 18 00 00 00       	mov    $0x18,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <kthread_join>:
SYSCALL(kthread_join)
 57a:	b8 19 00 00 00       	mov    $0x19,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <kthread_mutex_alloc>:
SYSCALL(kthread_mutex_alloc)
 582:	b8 1a 00 00 00       	mov    $0x1a,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <kthread_mutex_dealloc>:
SYSCALL(kthread_mutex_dealloc)
 58a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    

00000592 <kthread_mutex_lock>:
SYSCALL(kthread_mutex_lock)
 592:	b8 1c 00 00 00       	mov    $0x1c,%eax
 597:	cd 40                	int    $0x40
 599:	c3                   	ret    

0000059a <kthread_mutex_unlock>:
SYSCALL(kthread_mutex_unlock)
 59a:	b8 1d 00 00 00       	mov    $0x1d,%eax
 59f:	cd 40                	int    $0x40
 5a1:	c3                   	ret    

000005a2 <procdump>:
 5a2:	b8 1e 00 00 00       	mov    $0x1e,%eax
 5a7:	cd 40                	int    $0x40
 5a9:	c3                   	ret    
 5aa:	66 90                	xchg   %ax,%ax
 5ac:	66 90                	xchg   %ax,%ax
 5ae:	66 90                	xchg   %ax,%ax

000005b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5b0:	55                   	push   %ebp
 5b1:	89 e5                	mov    %esp,%ebp
 5b3:	57                   	push   %edi
 5b4:	56                   	push   %esi
 5b5:	53                   	push   %ebx
 5b6:	89 c6                	mov    %eax,%esi
 5b8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5be:	85 db                	test   %ebx,%ebx
 5c0:	74 7e                	je     640 <printint+0x90>
 5c2:	89 d0                	mov    %edx,%eax
 5c4:	c1 e8 1f             	shr    $0x1f,%eax
 5c7:	84 c0                	test   %al,%al
 5c9:	74 75                	je     640 <printint+0x90>
    neg = 1;
    x = -xx;
 5cb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 5cd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 5d4:	f7 d8                	neg    %eax
 5d6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 5d9:	31 ff                	xor    %edi,%edi
 5db:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 5de:	89 ce                	mov    %ecx,%esi
 5e0:	eb 08                	jmp    5ea <printint+0x3a>
 5e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 5e8:	89 cf                	mov    %ecx,%edi
 5ea:	31 d2                	xor    %edx,%edx
 5ec:	8d 4f 01             	lea    0x1(%edi),%ecx
 5ef:	f7 f6                	div    %esi
 5f1:	0f b6 92 34 0b 00 00 	movzbl 0xb34(%edx),%edx
  }while((x /= base) != 0);
 5f8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 5fa:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 5fd:	75 e9                	jne    5e8 <printint+0x38>
  if(neg)
 5ff:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 602:	8b 75 c0             	mov    -0x40(%ebp),%esi
 605:	85 c0                	test   %eax,%eax
 607:	74 08                	je     611 <printint+0x61>
    buf[i++] = '-';
 609:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 60e:	8d 4f 02             	lea    0x2(%edi),%ecx
 611:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 615:	8d 76 00             	lea    0x0(%esi),%esi
 618:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 61b:	83 ec 04             	sub    $0x4,%esp
 61e:	83 ef 01             	sub    $0x1,%edi
 621:	6a 01                	push   $0x1
 623:	53                   	push   %ebx
 624:	56                   	push   %esi
 625:	88 45 d7             	mov    %al,-0x29(%ebp)
 628:	e8 b5 fe ff ff       	call   4e2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 62d:	83 c4 10             	add    $0x10,%esp
 630:	39 df                	cmp    %ebx,%edi
 632:	75 e4                	jne    618 <printint+0x68>
    putc(fd, buf[i]);
}
 634:	8d 65 f4             	lea    -0xc(%ebp),%esp
 637:	5b                   	pop    %ebx
 638:	5e                   	pop    %esi
 639:	5f                   	pop    %edi
 63a:	5d                   	pop    %ebp
 63b:	c3                   	ret    
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 640:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 642:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 649:	eb 8b                	jmp    5d6 <printint+0x26>
 64b:	90                   	nop
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000650 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	57                   	push   %edi
 654:	56                   	push   %esi
 655:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 656:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 659:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 65c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 65f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 662:	89 45 d0             	mov    %eax,-0x30(%ebp)
 665:	0f b6 1e             	movzbl (%esi),%ebx
 668:	83 c6 01             	add    $0x1,%esi
 66b:	84 db                	test   %bl,%bl
 66d:	0f 84 b0 00 00 00    	je     723 <printf+0xd3>
 673:	31 d2                	xor    %edx,%edx
 675:	eb 39                	jmp    6b0 <printf+0x60>
 677:	89 f6                	mov    %esi,%esi
 679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 680:	83 f8 25             	cmp    $0x25,%eax
 683:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 686:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 68b:	74 18                	je     6a5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 68d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 690:	83 ec 04             	sub    $0x4,%esp
 693:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 696:	6a 01                	push   $0x1
 698:	50                   	push   %eax
 699:	57                   	push   %edi
 69a:	e8 43 fe ff ff       	call   4e2 <write>
 69f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 6a2:	83 c4 10             	add    $0x10,%esp
 6a5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6a8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 6ac:	84 db                	test   %bl,%bl
 6ae:	74 73                	je     723 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 6b0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 6b2:	0f be cb             	movsbl %bl,%ecx
 6b5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 6b8:	74 c6                	je     680 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6ba:	83 fa 25             	cmp    $0x25,%edx
 6bd:	75 e6                	jne    6a5 <printf+0x55>
      if(c == 'd'){
 6bf:	83 f8 64             	cmp    $0x64,%eax
 6c2:	0f 84 f8 00 00 00    	je     7c0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6c8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6ce:	83 f9 70             	cmp    $0x70,%ecx
 6d1:	74 5d                	je     730 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6d3:	83 f8 73             	cmp    $0x73,%eax
 6d6:	0f 84 84 00 00 00    	je     760 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6dc:	83 f8 63             	cmp    $0x63,%eax
 6df:	0f 84 ea 00 00 00    	je     7cf <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6e5:	83 f8 25             	cmp    $0x25,%eax
 6e8:	0f 84 c2 00 00 00    	je     7b0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ee:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6f1:	83 ec 04             	sub    $0x4,%esp
 6f4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6f8:	6a 01                	push   $0x1
 6fa:	50                   	push   %eax
 6fb:	57                   	push   %edi
 6fc:	e8 e1 fd ff ff       	call   4e2 <write>
 701:	83 c4 0c             	add    $0xc,%esp
 704:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 707:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 70a:	6a 01                	push   $0x1
 70c:	50                   	push   %eax
 70d:	57                   	push   %edi
 70e:	83 c6 01             	add    $0x1,%esi
 711:	e8 cc fd ff ff       	call   4e2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 716:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 71a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 71d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 71f:	84 db                	test   %bl,%bl
 721:	75 8d                	jne    6b0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 723:	8d 65 f4             	lea    -0xc(%ebp),%esp
 726:	5b                   	pop    %ebx
 727:	5e                   	pop    %esi
 728:	5f                   	pop    %edi
 729:	5d                   	pop    %ebp
 72a:	c3                   	ret    
 72b:	90                   	nop
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 730:	83 ec 0c             	sub    $0xc,%esp
 733:	b9 10 00 00 00       	mov    $0x10,%ecx
 738:	6a 00                	push   $0x0
 73a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 73d:	89 f8                	mov    %edi,%eax
 73f:	8b 13                	mov    (%ebx),%edx
 741:	e8 6a fe ff ff       	call   5b0 <printint>
        ap++;
 746:	89 d8                	mov    %ebx,%eax
 748:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 74b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 74d:	83 c0 04             	add    $0x4,%eax
 750:	89 45 d0             	mov    %eax,-0x30(%ebp)
 753:	e9 4d ff ff ff       	jmp    6a5 <printf+0x55>
 758:	90                   	nop
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 760:	8b 45 d0             	mov    -0x30(%ebp),%eax
 763:	8b 18                	mov    (%eax),%ebx
        ap++;
 765:	83 c0 04             	add    $0x4,%eax
 768:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 76b:	b8 2b 0b 00 00       	mov    $0xb2b,%eax
 770:	85 db                	test   %ebx,%ebx
 772:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 775:	0f b6 03             	movzbl (%ebx),%eax
 778:	84 c0                	test   %al,%al
 77a:	74 23                	je     79f <printf+0x14f>
 77c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 780:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 783:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 786:	83 ec 04             	sub    $0x4,%esp
 789:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 78b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 78e:	50                   	push   %eax
 78f:	57                   	push   %edi
 790:	e8 4d fd ff ff       	call   4e2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 795:	0f b6 03             	movzbl (%ebx),%eax
 798:	83 c4 10             	add    $0x10,%esp
 79b:	84 c0                	test   %al,%al
 79d:	75 e1                	jne    780 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 79f:	31 d2                	xor    %edx,%edx
 7a1:	e9 ff fe ff ff       	jmp    6a5 <printf+0x55>
 7a6:	8d 76 00             	lea    0x0(%esi),%esi
 7a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7b0:	83 ec 04             	sub    $0x4,%esp
 7b3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 7b6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 7b9:	6a 01                	push   $0x1
 7bb:	e9 4c ff ff ff       	jmp    70c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7c0:	83 ec 0c             	sub    $0xc,%esp
 7c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7c8:	6a 01                	push   $0x1
 7ca:	e9 6b ff ff ff       	jmp    73a <printf+0xea>
 7cf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7d2:	83 ec 04             	sub    $0x4,%esp
 7d5:	8b 03                	mov    (%ebx),%eax
 7d7:	6a 01                	push   $0x1
 7d9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 7dc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 7df:	50                   	push   %eax
 7e0:	57                   	push   %edi
 7e1:	e8 fc fc ff ff       	call   4e2 <write>
 7e6:	e9 5b ff ff ff       	jmp    746 <printf+0xf6>
 7eb:	66 90                	xchg   %ax,%ax
 7ed:	66 90                	xchg   %ax,%ax
 7ef:	90                   	nop

000007f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f1:	a1 f8 0d 00 00       	mov    0xdf8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 7f6:	89 e5                	mov    %esp,%ebp
 7f8:	57                   	push   %edi
 7f9:	56                   	push   %esi
 7fa:	53                   	push   %ebx
 7fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fe:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 800:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 803:	39 c8                	cmp    %ecx,%eax
 805:	73 19                	jae    820 <free+0x30>
 807:	89 f6                	mov    %esi,%esi
 809:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 810:	39 d1                	cmp    %edx,%ecx
 812:	72 1c                	jb     830 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 814:	39 d0                	cmp    %edx,%eax
 816:	73 18                	jae    830 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 818:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 81a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 81c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 81e:	72 f0                	jb     810 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 820:	39 d0                	cmp    %edx,%eax
 822:	72 f4                	jb     818 <free+0x28>
 824:	39 d1                	cmp    %edx,%ecx
 826:	73 f0                	jae    818 <free+0x28>
 828:	90                   	nop
 829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 830:	8b 73 fc             	mov    -0x4(%ebx),%esi
 833:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 836:	39 d7                	cmp    %edx,%edi
 838:	74 19                	je     853 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 83a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 83d:	8b 50 04             	mov    0x4(%eax),%edx
 840:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 843:	39 f1                	cmp    %esi,%ecx
 845:	74 23                	je     86a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 847:	89 08                	mov    %ecx,(%eax)
  freep = p;
 849:	a3 f8 0d 00 00       	mov    %eax,0xdf8
}
 84e:	5b                   	pop    %ebx
 84f:	5e                   	pop    %esi
 850:	5f                   	pop    %edi
 851:	5d                   	pop    %ebp
 852:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 853:	03 72 04             	add    0x4(%edx),%esi
 856:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 859:	8b 10                	mov    (%eax),%edx
 85b:	8b 12                	mov    (%edx),%edx
 85d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 860:	8b 50 04             	mov    0x4(%eax),%edx
 863:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 866:	39 f1                	cmp    %esi,%ecx
 868:	75 dd                	jne    847 <free+0x57>
    p->s.size += bp->s.size;
 86a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 86d:	a3 f8 0d 00 00       	mov    %eax,0xdf8
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 872:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 875:	8b 53 f8             	mov    -0x8(%ebx),%edx
 878:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 87a:	5b                   	pop    %ebx
 87b:	5e                   	pop    %esi
 87c:	5f                   	pop    %edi
 87d:	5d                   	pop    %ebp
 87e:	c3                   	ret    
 87f:	90                   	nop

00000880 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	57                   	push   %edi
 884:	56                   	push   %esi
 885:	53                   	push   %ebx
 886:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 889:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 88c:	8b 15 f8 0d 00 00    	mov    0xdf8,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 892:	8d 78 07             	lea    0x7(%eax),%edi
 895:	c1 ef 03             	shr    $0x3,%edi
 898:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 89b:	85 d2                	test   %edx,%edx
 89d:	0f 84 a3 00 00 00    	je     946 <malloc+0xc6>
 8a3:	8b 02                	mov    (%edx),%eax
 8a5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8a8:	39 cf                	cmp    %ecx,%edi
 8aa:	76 74                	jbe    920 <malloc+0xa0>
 8ac:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 8b2:	be 00 10 00 00       	mov    $0x1000,%esi
 8b7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 8be:	0f 43 f7             	cmovae %edi,%esi
 8c1:	ba 00 80 00 00       	mov    $0x8000,%edx
 8c6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 8cc:	0f 46 da             	cmovbe %edx,%ebx
 8cf:	eb 10                	jmp    8e1 <malloc+0x61>
 8d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8da:	8b 48 04             	mov    0x4(%eax),%ecx
 8dd:	39 cf                	cmp    %ecx,%edi
 8df:	76 3f                	jbe    920 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8e1:	39 05 f8 0d 00 00    	cmp    %eax,0xdf8
 8e7:	89 c2                	mov    %eax,%edx
 8e9:	75 ed                	jne    8d8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 8eb:	83 ec 0c             	sub    $0xc,%esp
 8ee:	53                   	push   %ebx
 8ef:	e8 56 fc ff ff       	call   54a <sbrk>
  if(p == (char*)-1)
 8f4:	83 c4 10             	add    $0x10,%esp
 8f7:	83 f8 ff             	cmp    $0xffffffff,%eax
 8fa:	74 1c                	je     918 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 8fc:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 8ff:	83 ec 0c             	sub    $0xc,%esp
 902:	83 c0 08             	add    $0x8,%eax
 905:	50                   	push   %eax
 906:	e8 e5 fe ff ff       	call   7f0 <free>
  return freep;
 90b:	8b 15 f8 0d 00 00    	mov    0xdf8,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 911:	83 c4 10             	add    $0x10,%esp
 914:	85 d2                	test   %edx,%edx
 916:	75 c0                	jne    8d8 <malloc+0x58>
        return 0;
 918:	31 c0                	xor    %eax,%eax
 91a:	eb 1c                	jmp    938 <malloc+0xb8>
 91c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 920:	39 cf                	cmp    %ecx,%edi
 922:	74 1c                	je     940 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 924:	29 f9                	sub    %edi,%ecx
 926:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 929:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 92c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 92f:	89 15 f8 0d 00 00    	mov    %edx,0xdf8
      return (void*)(p + 1);
 935:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 938:	8d 65 f4             	lea    -0xc(%ebp),%esp
 93b:	5b                   	pop    %ebx
 93c:	5e                   	pop    %esi
 93d:	5f                   	pop    %edi
 93e:	5d                   	pop    %ebp
 93f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 940:	8b 08                	mov    (%eax),%ecx
 942:	89 0a                	mov    %ecx,(%edx)
 944:	eb e9                	jmp    92f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 946:	c7 05 f8 0d 00 00 fc 	movl   $0xdfc,0xdf8
 94d:	0d 00 00 
 950:	c7 05 fc 0d 00 00 fc 	movl   $0xdfc,0xdfc
 957:	0d 00 00 
    base.s.size = 0;
 95a:	b8 fc 0d 00 00       	mov    $0xdfc,%eax
 95f:	c7 05 00 0e 00 00 00 	movl   $0x0,0xe00
 966:	00 00 00 
 969:	e9 3e ff ff ff       	jmp    8ac <malloc+0x2c>
