
_test1:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
	}
	printf(1, "pi = %d \n", s);
}

// This test is made to prove working Priority
int main(void) {
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx

	int forkedRet = fork();
   f:	e8 26 03 00 00       	call   33a <fork>
	
	
	if (forkedRet > 0) {
  14:	85 c0                	test   %eax,%eax
  16:	7e 56                	jle    6e <main+0x6e>
  18:	31 db                	xor    %ebx,%ebx
  1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		// I/O intensive job for parent
		for (int i = 0; i <= 50; i++) {
			printf(1, "line %d, pid = %d.", i, getpid());
  20:	e8 9d 03 00 00       	call   3c2 <getpid>
  25:	50                   	push   %eax
  26:	53                   	push   %ebx
	int forkedRet = fork();
	
	
	if (forkedRet > 0) {
		// I/O intensive job for parent
		for (int i = 0; i <= 50; i++) {
  27:	83 c3 01             	add    $0x1,%ebx
			printf(1, "line %d, pid = %d.", i, getpid());
  2a:	68 ba 07 00 00       	push   $0x7ba
  2f:	6a 01                	push   $0x1
  31:	e8 5a 04 00 00       	call   490 <printf>
	int forkedRet = fork();
	
	
	if (forkedRet > 0) {
		// I/O intensive job for parent
		for (int i = 0; i <= 50; i++) {
  36:	83 c4 10             	add    $0x10,%esp
  39:	83 fb 33             	cmp    $0x33,%ebx
  3c:	75 e2                	jne    20 <main+0x20>
			printf(1, "line %d, pid = %d.", i, getpid());
		}

		// output
		getpinfo(getpid());
  3e:	e8 7f 03 00 00       	call   3c2 <getpid>
  43:	83 ec 0c             	sub    $0xc,%esp
  46:	50                   	push   %eax
  47:	e8 96 03 00 00       	call   3e2 <getpinfo>
		printf(1, "parent pid = %d getinfo ended\n", getpid());
  4c:	e8 71 03 00 00       	call   3c2 <getpid>
  51:	83 c4 0c             	add    $0xc,%esp
  54:	50                   	push   %eax
  55:	68 ec 07 00 00       	push   $0x7ec
  5a:	6a 01                	push   $0x1
  5c:	e8 2f 04 00 00       	call   490 <printf>
  61:	83 c4 10             	add    $0x10,%esp
		// output
		getpinfo(getpid());
		printf(1, "child pid = %d getinfo ended\n", getpid());
	}
	
	wait();	// wait for child
  64:	e8 e1 02 00 00       	call   34a <wait>

	exit();
  69:	e8 d4 02 00 00       	call   342 <exit>
		// output
		getpinfo(getpid());
		printf(1, "parent pid = %d getinfo ended\n", getpid());
	}else{
		// cpu intensive job for Child
		cpuIntensive();
  6e:	e8 2d 00 00 00       	call   a0 <cpuIntensive>

		// output
		getpinfo(getpid());
  73:	e8 4a 03 00 00       	call   3c2 <getpid>
  78:	83 ec 0c             	sub    $0xc,%esp
  7b:	50                   	push   %eax
  7c:	e8 61 03 00 00       	call   3e2 <getpinfo>
		printf(1, "child pid = %d getinfo ended\n", getpid());
  81:	e8 3c 03 00 00       	call   3c2 <getpid>
  86:	83 c4 0c             	add    $0xc,%esp
  89:	50                   	push   %eax
  8a:	68 cd 07 00 00       	push   $0x7cd
  8f:	6a 01                	push   $0x1
  91:	e8 fa 03 00 00       	call   490 <printf>
  96:	83 c4 10             	add    $0x10,%esp
  99:	eb c9                	jmp    64 <main+0x64>
  9b:	66 90                	xchg   %ax,%ax
  9d:	66 90                	xchg   %ax,%ax
  9f:	90                   	nop

000000a0 <cpuIntensive>:
void cpuIntensive() {
	//Initilize denominator
	double k = 1;
	  
	// Initilize sum
	double s = 0;
  a0:	d9 ee                	fldz   
	  
	for(int i = 0; i <= 1000000; i++){
  a2:	31 c0                	xor    %eax,%eax
#include "stat.h"
#include "types.h"

void cpuIntensive() {
	//Initilize denominator
	double k = 1;
  a4:	d9 e8                	fld1   
	        // odd index elements are negative
	        s -= 4/k;
	  	}

	    // denominator is odd
	    k += 2;
  a6:	d9 05 10 08 00 00    	flds   0x810
  ac:	eb 10                	jmp    be <cpuIntensive+0x1e>
  ae:	66 90                	xchg   %ax,%ax
	  
	for(int i = 0; i <= 1000000; i++){
	  
	    // even index elements are positive
	    if (i % 2 == 0){
	        s += 4/k;
  b0:	de c3                	faddp  %st,%st(3)
	double k = 1;
	  
	// Initilize sum
	double s = 0;
	  
	for(int i = 0; i <= 1000000; i++){
  b2:	83 c0 01             	add    $0x1,%eax
  b5:	3d 41 42 0f 00       	cmp    $0xf4241,%eax
	        // odd index elements are negative
	        s -= 4/k;
	  	}

	    // denominator is odd
	    k += 2;
  ba:	dc c1                	fadd   %st,%st(1)
	double k = 1;
	  
	// Initilize sum
	double s = 0;
	  
	for(int i = 0; i <= 1000000; i++){
  bc:	74 20                	je     de <cpuIntensive+0x3e>
	  
	    // even index elements are positive
	    if (i % 2 == 0){
	        s += 4/k;
  be:	d9 c1                	fld    %st(1)
	double s = 0;
	  
	for(int i = 0; i <= 1000000; i++){
	  
	    // even index elements are positive
	    if (i % 2 == 0){
  c0:	a8 01                	test   $0x1,%al
	        s += 4/k;
  c2:	d8 3d 0c 08 00 00    	fdivrs 0x80c
	double s = 0;
	  
	for(int i = 0; i <= 1000000; i++){
	  
	    // even index elements are positive
	    if (i % 2 == 0){
  c8:	74 e6                	je     b0 <cpuIntensive+0x10>
	        s += 4/k;
	    } else {
	  
	        // odd index elements are negative
	        s -= 4/k;
  ca:	de eb                	fsubrp %st,%st(3)
	double k = 1;
	  
	// Initilize sum
	double s = 0;
	  
	for(int i = 0; i <= 1000000; i++){
  cc:	83 c0 01             	add    $0x1,%eax
  cf:	3d 41 42 0f 00       	cmp    $0xf4241,%eax
	        // odd index elements are negative
	        s -= 4/k;
	  	}

	    // denominator is odd
	    k += 2;
  d4:	dc c1                	fadd   %st,%st(1)
	double k = 1;
	  
	// Initilize sum
	double s = 0;
	  
	for(int i = 0; i <= 1000000; i++){
  d6:	75 e6                	jne    be <cpuIntensive+0x1e>
  d8:	dd d8                	fstp   %st(0)
  da:	dd d8                	fstp   %st(0)
  dc:	eb 04                	jmp    e2 <cpuIntensive+0x42>
  de:	dd d8                	fstp   %st(0)
  e0:	dd d8                	fstp   %st(0)
// include header files
#include "user.h"
#include "stat.h"
#include "types.h"

void cpuIntensive() {
  e2:	55                   	push   %ebp
  e3:	89 e5                	mov    %esp,%ebp
  e5:	83 ec 10             	sub    $0x10,%esp
	  	}

	    // denominator is odd
	    k += 2;
	}
	printf(1, "pi = %d \n", s);
  e8:	dd 1c 24             	fstpl  (%esp)
  eb:	68 b0 07 00 00       	push   $0x7b0
  f0:	6a 01                	push   $0x1
  f2:	e8 99 03 00 00       	call   490 <printf>
}
  f7:	83 c4 10             	add    $0x10,%esp
  fa:	c9                   	leave  
  fb:	c3                   	ret    
  fc:	66 90                	xchg   %ax,%ax
  fe:	66 90                	xchg   %ax,%ax

00000100 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 10a:	89 c2                	mov    %eax,%edx
 10c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 110:	83 c1 01             	add    $0x1,%ecx
 113:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 117:	83 c2 01             	add    $0x1,%edx
 11a:	84 db                	test   %bl,%bl
 11c:	88 5a ff             	mov    %bl,-0x1(%edx)
 11f:	75 ef                	jne    110 <strcpy+0x10>
    ;
  return os;
}
 121:	5b                   	pop    %ebx
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
 124:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 12a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	56                   	push   %esi
 134:	53                   	push   %ebx
 135:	8b 55 08             	mov    0x8(%ebp),%edx
 138:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 13b:	0f b6 02             	movzbl (%edx),%eax
 13e:	0f b6 19             	movzbl (%ecx),%ebx
 141:	84 c0                	test   %al,%al
 143:	75 1e                	jne    163 <strcmp+0x33>
 145:	eb 29                	jmp    170 <strcmp+0x40>
 147:	89 f6                	mov    %esi,%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 150:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 153:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 156:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 159:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 15d:	84 c0                	test   %al,%al
 15f:	74 0f                	je     170 <strcmp+0x40>
 161:	89 f1                	mov    %esi,%ecx
 163:	38 d8                	cmp    %bl,%al
 165:	74 e9                	je     150 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 167:	29 d8                	sub    %ebx,%eax
}
 169:	5b                   	pop    %ebx
 16a:	5e                   	pop    %esi
 16b:	5d                   	pop    %ebp
 16c:	c3                   	ret    
 16d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 170:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 172:	29 d8                	sub    %ebx,%eax
}
 174:	5b                   	pop    %ebx
 175:	5e                   	pop    %esi
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    
 178:	90                   	nop
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000180 <strlen>:

uint
strlen(const char *s)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 186:	80 39 00             	cmpb   $0x0,(%ecx)
 189:	74 12                	je     19d <strlen+0x1d>
 18b:	31 d2                	xor    %edx,%edx
 18d:	8d 76 00             	lea    0x0(%esi),%esi
 190:	83 c2 01             	add    $0x1,%edx
 193:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 197:	89 d0                	mov    %edx,%eax
 199:	75 f5                	jne    190 <strlen+0x10>
    ;
  return n;
}
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret    
uint
strlen(const char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 19d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 19f:	5d                   	pop    %ebp
 1a0:	c3                   	ret    
 1a1:	eb 0d                	jmp    1b0 <memset>
 1a3:	90                   	nop
 1a4:	90                   	nop
 1a5:	90                   	nop
 1a6:	90                   	nop
 1a7:	90                   	nop
 1a8:	90                   	nop
 1a9:	90                   	nop
 1aa:	90                   	nop
 1ab:	90                   	nop
 1ac:	90                   	nop
 1ad:	90                   	nop
 1ae:	90                   	nop
 1af:	90                   	nop

000001b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	57                   	push   %edi
 1b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 1bd:	89 d7                	mov    %edx,%edi
 1bf:	fc                   	cld    
 1c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1c2:	89 d0                	mov    %edx,%eax
 1c4:	5f                   	pop    %edi
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001d0 <strchr>:

char*
strchr(const char *s, char c)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	8b 45 08             	mov    0x8(%ebp),%eax
 1d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1da:	0f b6 10             	movzbl (%eax),%edx
 1dd:	84 d2                	test   %dl,%dl
 1df:	74 1d                	je     1fe <strchr+0x2e>
    if(*s == c)
 1e1:	38 d3                	cmp    %dl,%bl
 1e3:	89 d9                	mov    %ebx,%ecx
 1e5:	75 0d                	jne    1f4 <strchr+0x24>
 1e7:	eb 17                	jmp    200 <strchr+0x30>
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1f0:	38 ca                	cmp    %cl,%dl
 1f2:	74 0c                	je     200 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1f4:	83 c0 01             	add    $0x1,%eax
 1f7:	0f b6 10             	movzbl (%eax),%edx
 1fa:	84 d2                	test   %dl,%dl
 1fc:	75 f2                	jne    1f0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 1fe:	31 c0                	xor    %eax,%eax
}
 200:	5b                   	pop    %ebx
 201:	5d                   	pop    %ebp
 202:	c3                   	ret    
 203:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <gets>:

char*
gets(char *buf, int max)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	57                   	push   %edi
 214:	56                   	push   %esi
 215:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 216:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 218:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 21b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21e:	eb 29                	jmp    249 <gets+0x39>
    cc = read(0, &c, 1);
 220:	83 ec 04             	sub    $0x4,%esp
 223:	6a 01                	push   $0x1
 225:	57                   	push   %edi
 226:	6a 00                	push   $0x0
 228:	e8 2d 01 00 00       	call   35a <read>
    if(cc < 1)
 22d:	83 c4 10             	add    $0x10,%esp
 230:	85 c0                	test   %eax,%eax
 232:	7e 1d                	jle    251 <gets+0x41>
      break;
    buf[i++] = c;
 234:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 238:	8b 55 08             	mov    0x8(%ebp),%edx
 23b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 23d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 23f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 243:	74 1b                	je     260 <gets+0x50>
 245:	3c 0d                	cmp    $0xd,%al
 247:	74 17                	je     260 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 249:	8d 5e 01             	lea    0x1(%esi),%ebx
 24c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 24f:	7c cf                	jl     220 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 251:	8b 45 08             	mov    0x8(%ebp),%eax
 254:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 258:	8d 65 f4             	lea    -0xc(%ebp),%esp
 25b:	5b                   	pop    %ebx
 25c:	5e                   	pop    %esi
 25d:	5f                   	pop    %edi
 25e:	5d                   	pop    %ebp
 25f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 260:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 263:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 265:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 269:	8d 65 f4             	lea    -0xc(%ebp),%esp
 26c:	5b                   	pop    %ebx
 26d:	5e                   	pop    %esi
 26e:	5f                   	pop    %edi
 26f:	5d                   	pop    %ebp
 270:	c3                   	ret    
 271:	eb 0d                	jmp    280 <stat>
 273:	90                   	nop
 274:	90                   	nop
 275:	90                   	nop
 276:	90                   	nop
 277:	90                   	nop
 278:	90                   	nop
 279:	90                   	nop
 27a:	90                   	nop
 27b:	90                   	nop
 27c:	90                   	nop
 27d:	90                   	nop
 27e:	90                   	nop
 27f:	90                   	nop

00000280 <stat>:

int
stat(const char *n, struct stat *st)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 285:	83 ec 08             	sub    $0x8,%esp
 288:	6a 00                	push   $0x0
 28a:	ff 75 08             	pushl  0x8(%ebp)
 28d:	e8 f0 00 00 00       	call   382 <open>
  if(fd < 0)
 292:	83 c4 10             	add    $0x10,%esp
 295:	85 c0                	test   %eax,%eax
 297:	78 27                	js     2c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 299:	83 ec 08             	sub    $0x8,%esp
 29c:	ff 75 0c             	pushl  0xc(%ebp)
 29f:	89 c3                	mov    %eax,%ebx
 2a1:	50                   	push   %eax
 2a2:	e8 f3 00 00 00       	call   39a <fstat>
 2a7:	89 c6                	mov    %eax,%esi
  close(fd);
 2a9:	89 1c 24             	mov    %ebx,(%esp)
 2ac:	e8 b9 00 00 00       	call   36a <close>
  return r;
 2b1:	83 c4 10             	add    $0x10,%esp
 2b4:	89 f0                	mov    %esi,%eax
}
 2b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2b9:	5b                   	pop    %ebx
 2ba:	5e                   	pop    %esi
 2bb:	5d                   	pop    %ebp
 2bc:	c3                   	ret    
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 2c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2c5:	eb ef                	jmp    2b6 <stat+0x36>
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d7:	0f be 11             	movsbl (%ecx),%edx
 2da:	8d 42 d0             	lea    -0x30(%edx),%eax
 2dd:	3c 09                	cmp    $0x9,%al
 2df:	b8 00 00 00 00       	mov    $0x0,%eax
 2e4:	77 1f                	ja     305 <atoi+0x35>
 2e6:	8d 76 00             	lea    0x0(%esi),%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 2f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2f3:	83 c1 01             	add    $0x1,%ecx
 2f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2fa:	0f be 11             	movsbl (%ecx),%edx
 2fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 300:	80 fb 09             	cmp    $0x9,%bl
 303:	76 eb                	jbe    2f0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 305:	5b                   	pop    %ebx
 306:	5d                   	pop    %ebp
 307:	c3                   	ret    
 308:	90                   	nop
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000310 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	53                   	push   %ebx
 315:	8b 5d 10             	mov    0x10(%ebp),%ebx
 318:	8b 45 08             	mov    0x8(%ebp),%eax
 31b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 31e:	85 db                	test   %ebx,%ebx
 320:	7e 14                	jle    336 <memmove+0x26>
 322:	31 d2                	xor    %edx,%edx
 324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 328:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 32c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 32f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 332:	39 da                	cmp    %ebx,%edx
 334:	75 f2                	jne    328 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 336:	5b                   	pop    %ebx
 337:	5e                   	pop    %esi
 338:	5d                   	pop    %ebp
 339:	c3                   	ret    

0000033a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 33a:	b8 01 00 00 00       	mov    $0x1,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <exit>:
SYSCALL(exit)
 342:	b8 02 00 00 00       	mov    $0x2,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <wait>:
SYSCALL(wait)
 34a:	b8 03 00 00 00       	mov    $0x3,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <pipe>:
SYSCALL(pipe)
 352:	b8 04 00 00 00       	mov    $0x4,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <read>:
SYSCALL(read)
 35a:	b8 05 00 00 00       	mov    $0x5,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <write>:
SYSCALL(write)
 362:	b8 10 00 00 00       	mov    $0x10,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <close>:
SYSCALL(close)
 36a:	b8 15 00 00 00       	mov    $0x15,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <kill>:
SYSCALL(kill)
 372:	b8 06 00 00 00       	mov    $0x6,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <exec>:
SYSCALL(exec)
 37a:	b8 07 00 00 00       	mov    $0x7,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <open>:
SYSCALL(open)
 382:	b8 0f 00 00 00       	mov    $0xf,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <mknod>:
SYSCALL(mknod)
 38a:	b8 11 00 00 00       	mov    $0x11,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <unlink>:
SYSCALL(unlink)
 392:	b8 12 00 00 00       	mov    $0x12,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <fstat>:
SYSCALL(fstat)
 39a:	b8 08 00 00 00       	mov    $0x8,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <link>:
SYSCALL(link)
 3a2:	b8 13 00 00 00       	mov    $0x13,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <mkdir>:
SYSCALL(mkdir)
 3aa:	b8 14 00 00 00       	mov    $0x14,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <chdir>:
SYSCALL(chdir)
 3b2:	b8 09 00 00 00       	mov    $0x9,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <dup>:
SYSCALL(dup)
 3ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <getpid>:
SYSCALL(getpid)
 3c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <sbrk>:
SYSCALL(sbrk)
 3ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <sleep>:
SYSCALL(sleep)
 3d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <uptime>:
SYSCALL(uptime)
 3da:	b8 0e 00 00 00       	mov    $0xe,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <getpinfo>:
 3e2:	b8 16 00 00 00       	mov    $0x16,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    
 3ea:	66 90                	xchg   %ax,%ax
 3ec:	66 90                	xchg   %ax,%ax
 3ee:	66 90                	xchg   %ax,%ax

000003f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	56                   	push   %esi
 3f5:	53                   	push   %ebx
 3f6:	89 c6                	mov    %eax,%esi
 3f8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3fe:	85 db                	test   %ebx,%ebx
 400:	74 7e                	je     480 <printint+0x90>
 402:	89 d0                	mov    %edx,%eax
 404:	c1 e8 1f             	shr    $0x1f,%eax
 407:	84 c0                	test   %al,%al
 409:	74 75                	je     480 <printint+0x90>
    neg = 1;
    x = -xx;
 40b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 40d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 414:	f7 d8                	neg    %eax
 416:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 419:	31 ff                	xor    %edi,%edi
 41b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 41e:	89 ce                	mov    %ecx,%esi
 420:	eb 08                	jmp    42a <printint+0x3a>
 422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 428:	89 cf                	mov    %ecx,%edi
 42a:	31 d2                	xor    %edx,%edx
 42c:	8d 4f 01             	lea    0x1(%edi),%ecx
 42f:	f7 f6                	div    %esi
 431:	0f b6 92 1c 08 00 00 	movzbl 0x81c(%edx),%edx
  }while((x /= base) != 0);
 438:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 43a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 43d:	75 e9                	jne    428 <printint+0x38>
  if(neg)
 43f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 442:	8b 75 c0             	mov    -0x40(%ebp),%esi
 445:	85 c0                	test   %eax,%eax
 447:	74 08                	je     451 <printint+0x61>
    buf[i++] = '-';
 449:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 44e:	8d 4f 02             	lea    0x2(%edi),%ecx
 451:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 455:	8d 76 00             	lea    0x0(%esi),%esi
 458:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 45b:	83 ec 04             	sub    $0x4,%esp
 45e:	83 ef 01             	sub    $0x1,%edi
 461:	6a 01                	push   $0x1
 463:	53                   	push   %ebx
 464:	56                   	push   %esi
 465:	88 45 d7             	mov    %al,-0x29(%ebp)
 468:	e8 f5 fe ff ff       	call   362 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 46d:	83 c4 10             	add    $0x10,%esp
 470:	39 df                	cmp    %ebx,%edi
 472:	75 e4                	jne    458 <printint+0x68>
    putc(fd, buf[i]);
}
 474:	8d 65 f4             	lea    -0xc(%ebp),%esp
 477:	5b                   	pop    %ebx
 478:	5e                   	pop    %esi
 479:	5f                   	pop    %edi
 47a:	5d                   	pop    %ebp
 47b:	c3                   	ret    
 47c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 480:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 482:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 489:	eb 8b                	jmp    416 <printint+0x26>
 48b:	90                   	nop
 48c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000490 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 496:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 499:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 49c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 49f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4a2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4a5:	0f b6 1e             	movzbl (%esi),%ebx
 4a8:	83 c6 01             	add    $0x1,%esi
 4ab:	84 db                	test   %bl,%bl
 4ad:	0f 84 b0 00 00 00    	je     563 <printf+0xd3>
 4b3:	31 d2                	xor    %edx,%edx
 4b5:	eb 39                	jmp    4f0 <printf+0x60>
 4b7:	89 f6                	mov    %esi,%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4c0:	83 f8 25             	cmp    $0x25,%eax
 4c3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 4c6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4cb:	74 18                	je     4e5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4cd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 4d0:	83 ec 04             	sub    $0x4,%esp
 4d3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 4d6:	6a 01                	push   $0x1
 4d8:	50                   	push   %eax
 4d9:	57                   	push   %edi
 4da:	e8 83 fe ff ff       	call   362 <write>
 4df:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4e2:	83 c4 10             	add    $0x10,%esp
 4e5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4e8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4ec:	84 db                	test   %bl,%bl
 4ee:	74 73                	je     563 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 4f0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 4f2:	0f be cb             	movsbl %bl,%ecx
 4f5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4f8:	74 c6                	je     4c0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4fa:	83 fa 25             	cmp    $0x25,%edx
 4fd:	75 e6                	jne    4e5 <printf+0x55>
      if(c == 'd'){
 4ff:	83 f8 64             	cmp    $0x64,%eax
 502:	0f 84 f8 00 00 00    	je     600 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 508:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 50e:	83 f9 70             	cmp    $0x70,%ecx
 511:	74 5d                	je     570 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 513:	83 f8 73             	cmp    $0x73,%eax
 516:	0f 84 84 00 00 00    	je     5a0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 51c:	83 f8 63             	cmp    $0x63,%eax
 51f:	0f 84 ea 00 00 00    	je     60f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 525:	83 f8 25             	cmp    $0x25,%eax
 528:	0f 84 c2 00 00 00    	je     5f0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 52e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 531:	83 ec 04             	sub    $0x4,%esp
 534:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 538:	6a 01                	push   $0x1
 53a:	50                   	push   %eax
 53b:	57                   	push   %edi
 53c:	e8 21 fe ff ff       	call   362 <write>
 541:	83 c4 0c             	add    $0xc,%esp
 544:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 547:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 54a:	6a 01                	push   $0x1
 54c:	50                   	push   %eax
 54d:	57                   	push   %edi
 54e:	83 c6 01             	add    $0x1,%esi
 551:	e8 0c fe ff ff       	call   362 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 556:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 55a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 55d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 55f:	84 db                	test   %bl,%bl
 561:	75 8d                	jne    4f0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 563:	8d 65 f4             	lea    -0xc(%ebp),%esp
 566:	5b                   	pop    %ebx
 567:	5e                   	pop    %esi
 568:	5f                   	pop    %edi
 569:	5d                   	pop    %ebp
 56a:	c3                   	ret    
 56b:	90                   	nop
 56c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 570:	83 ec 0c             	sub    $0xc,%esp
 573:	b9 10 00 00 00       	mov    $0x10,%ecx
 578:	6a 00                	push   $0x0
 57a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 57d:	89 f8                	mov    %edi,%eax
 57f:	8b 13                	mov    (%ebx),%edx
 581:	e8 6a fe ff ff       	call   3f0 <printint>
        ap++;
 586:	89 d8                	mov    %ebx,%eax
 588:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 58b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 58d:	83 c0 04             	add    $0x4,%eax
 590:	89 45 d0             	mov    %eax,-0x30(%ebp)
 593:	e9 4d ff ff ff       	jmp    4e5 <printf+0x55>
 598:	90                   	nop
 599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 5a0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5a3:	8b 18                	mov    (%eax),%ebx
        ap++;
 5a5:	83 c0 04             	add    $0x4,%eax
 5a8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 5ab:	b8 14 08 00 00       	mov    $0x814,%eax
 5b0:	85 db                	test   %ebx,%ebx
 5b2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 5b5:	0f b6 03             	movzbl (%ebx),%eax
 5b8:	84 c0                	test   %al,%al
 5ba:	74 23                	je     5df <printf+0x14f>
 5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5c0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5c3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 5c6:	83 ec 04             	sub    $0x4,%esp
 5c9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 5cb:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5ce:	50                   	push   %eax
 5cf:	57                   	push   %edi
 5d0:	e8 8d fd ff ff       	call   362 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5d5:	0f b6 03             	movzbl (%ebx),%eax
 5d8:	83 c4 10             	add    $0x10,%esp
 5db:	84 c0                	test   %al,%al
 5dd:	75 e1                	jne    5c0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5df:	31 d2                	xor    %edx,%edx
 5e1:	e9 ff fe ff ff       	jmp    4e5 <printf+0x55>
 5e6:	8d 76 00             	lea    0x0(%esi),%esi
 5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5f0:	83 ec 04             	sub    $0x4,%esp
 5f3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5f6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5f9:	6a 01                	push   $0x1
 5fb:	e9 4c ff ff ff       	jmp    54c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 600:	83 ec 0c             	sub    $0xc,%esp
 603:	b9 0a 00 00 00       	mov    $0xa,%ecx
 608:	6a 01                	push   $0x1
 60a:	e9 6b ff ff ff       	jmp    57a <printf+0xea>
 60f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 612:	83 ec 04             	sub    $0x4,%esp
 615:	8b 03                	mov    (%ebx),%eax
 617:	6a 01                	push   $0x1
 619:	88 45 e4             	mov    %al,-0x1c(%ebp)
 61c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 61f:	50                   	push   %eax
 620:	57                   	push   %edi
 621:	e8 3c fd ff ff       	call   362 <write>
 626:	e9 5b ff ff ff       	jmp    586 <printf+0xf6>
 62b:	66 90                	xchg   %ax,%ax
 62d:	66 90                	xchg   %ax,%ax
 62f:	90                   	nop

00000630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 630:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	a1 d8 0a 00 00       	mov    0xad8,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 636:	89 e5                	mov    %esp,%ebp
 638:	57                   	push   %edi
 639:	56                   	push   %esi
 63a:	53                   	push   %ebx
 63b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 63e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 640:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 643:	39 c8                	cmp    %ecx,%eax
 645:	73 19                	jae    660 <free+0x30>
 647:	89 f6                	mov    %esi,%esi
 649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 650:	39 d1                	cmp    %edx,%ecx
 652:	72 1c                	jb     670 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 654:	39 d0                	cmp    %edx,%eax
 656:	73 18                	jae    670 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 658:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 65c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65e:	72 f0                	jb     650 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 660:	39 d0                	cmp    %edx,%eax
 662:	72 f4                	jb     658 <free+0x28>
 664:	39 d1                	cmp    %edx,%ecx
 666:	73 f0                	jae    658 <free+0x28>
 668:	90                   	nop
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 670:	8b 73 fc             	mov    -0x4(%ebx),%esi
 673:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 676:	39 d7                	cmp    %edx,%edi
 678:	74 19                	je     693 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 67a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 67d:	8b 50 04             	mov    0x4(%eax),%edx
 680:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 683:	39 f1                	cmp    %esi,%ecx
 685:	74 23                	je     6aa <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 687:	89 08                	mov    %ecx,(%eax)
  freep = p;
 689:	a3 d8 0a 00 00       	mov    %eax,0xad8
}
 68e:	5b                   	pop    %ebx
 68f:	5e                   	pop    %esi
 690:	5f                   	pop    %edi
 691:	5d                   	pop    %ebp
 692:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 693:	03 72 04             	add    0x4(%edx),%esi
 696:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 699:	8b 10                	mov    (%eax),%edx
 69b:	8b 12                	mov    (%edx),%edx
 69d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6a0:	8b 50 04             	mov    0x4(%eax),%edx
 6a3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6a6:	39 f1                	cmp    %esi,%ecx
 6a8:	75 dd                	jne    687 <free+0x57>
    p->s.size += bp->s.size;
 6aa:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 6ad:	a3 d8 0a 00 00       	mov    %eax,0xad8
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6b2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6b5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6b8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 6ba:	5b                   	pop    %ebx
 6bb:	5e                   	pop    %esi
 6bc:	5f                   	pop    %edi
 6bd:	5d                   	pop    %ebp
 6be:	c3                   	ret    
 6bf:	90                   	nop

000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6cc:	8b 15 d8 0a 00 00    	mov    0xad8,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d2:	8d 78 07             	lea    0x7(%eax),%edi
 6d5:	c1 ef 03             	shr    $0x3,%edi
 6d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 6db:	85 d2                	test   %edx,%edx
 6dd:	0f 84 a3 00 00 00    	je     786 <malloc+0xc6>
 6e3:	8b 02                	mov    (%edx),%eax
 6e5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6e8:	39 cf                	cmp    %ecx,%edi
 6ea:	76 74                	jbe    760 <malloc+0xa0>
 6ec:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6f2:	be 00 10 00 00       	mov    $0x1000,%esi
 6f7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 6fe:	0f 43 f7             	cmovae %edi,%esi
 701:	ba 00 80 00 00       	mov    $0x8000,%edx
 706:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 70c:	0f 46 da             	cmovbe %edx,%ebx
 70f:	eb 10                	jmp    721 <malloc+0x61>
 711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 718:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 71a:	8b 48 04             	mov    0x4(%eax),%ecx
 71d:	39 cf                	cmp    %ecx,%edi
 71f:	76 3f                	jbe    760 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 721:	39 05 d8 0a 00 00    	cmp    %eax,0xad8
 727:	89 c2                	mov    %eax,%edx
 729:	75 ed                	jne    718 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 72b:	83 ec 0c             	sub    $0xc,%esp
 72e:	53                   	push   %ebx
 72f:	e8 96 fc ff ff       	call   3ca <sbrk>
  if(p == (char*)-1)
 734:	83 c4 10             	add    $0x10,%esp
 737:	83 f8 ff             	cmp    $0xffffffff,%eax
 73a:	74 1c                	je     758 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 73c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 73f:	83 ec 0c             	sub    $0xc,%esp
 742:	83 c0 08             	add    $0x8,%eax
 745:	50                   	push   %eax
 746:	e8 e5 fe ff ff       	call   630 <free>
  return freep;
 74b:	8b 15 d8 0a 00 00    	mov    0xad8,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 751:	83 c4 10             	add    $0x10,%esp
 754:	85 d2                	test   %edx,%edx
 756:	75 c0                	jne    718 <malloc+0x58>
        return 0;
 758:	31 c0                	xor    %eax,%eax
 75a:	eb 1c                	jmp    778 <malloc+0xb8>
 75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 760:	39 cf                	cmp    %ecx,%edi
 762:	74 1c                	je     780 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 764:	29 f9                	sub    %edi,%ecx
 766:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 769:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 76c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 76f:	89 15 d8 0a 00 00    	mov    %edx,0xad8
      return (void*)(p + 1);
 775:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 778:	8d 65 f4             	lea    -0xc(%ebp),%esp
 77b:	5b                   	pop    %ebx
 77c:	5e                   	pop    %esi
 77d:	5f                   	pop    %edi
 77e:	5d                   	pop    %ebp
 77f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 780:	8b 08                	mov    (%eax),%ecx
 782:	89 0a                	mov    %ecx,(%edx)
 784:	eb e9                	jmp    76f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 786:	c7 05 d8 0a 00 00 dc 	movl   $0xadc,0xad8
 78d:	0a 00 00 
 790:	c7 05 dc 0a 00 00 dc 	movl   $0xadc,0xadc
 797:	0a 00 00 
    base.s.size = 0;
 79a:	b8 dc 0a 00 00       	mov    $0xadc,%eax
 79f:	c7 05 e0 0a 00 00 00 	movl   $0x0,0xae0
 7a6:	00 00 00 
 7a9:	e9 3e ff ff ff       	jmp    6ec <malloc+0x2c>
