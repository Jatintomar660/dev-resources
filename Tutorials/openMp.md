### OpenMP Tutorial
Tutorial on OpenMP:

---

### **1. Setup and Compilation**

To use OpenMP, you need a compiler that supports it, such as GCC, Clang, or Intel compilers.

- **Compiling OpenMP Code** (for C/C++):
  - With GCC: `gcc -fopenmp -o program program.c`
  - With Clang: `clang -fopenmp -o program program.c`

---

### **2. OpenMP Basics**

OpenMP is enabled using compiler directives or pragmas. The most basic directive is `#pragma omp parallel`, which creates parallel threads.

#### **Parallel Directive**
```c
#include <omp.h>
#include <stdio.h>

int main() {
    #pragma omp parallel
    {
        printf("Hello from thread %d\n", omp_get_thread_num());
    }
    return 0;
}
```
- **Explanation**: 
  - `omp_get_thread_num()` returns the ID of the thread executing the current task.
  - `#pragma omp parallel` creates a team of threads.

---

### **3. Work Sharing Constructs**

#### **3.1 `#pragma omp for`: Loop Parallelism**
Distribute loop iterations across threads.
```c
#include <omp.h>
#include <stdio.h>

int main() {
    int i;
    #pragma omp parallel for
    for (i = 0; i < 10; i++) {
        printf("Iteration %d by thread %d\n", i, omp_get_thread_num());
    }
    return 0;
}
```
- **Explanation**: Each iteration of the loop is divided among the threads created by OpenMP.

---

#### **3.2 `#pragma omp sections`: Dividing Code Blocks**
Run different blocks of code in parallel.
```c
#include <omp.h>
#include <stdio.h>

int main() {
    #pragma omp parallel sections
    {
        #pragma omp section
        {
            printf("Section 1 executed by thread %d\n", omp_get_thread_num());
        }
        #pragma omp section
        {
            printf("Section 2 executed by thread %d\n", omp_get_thread_num());
        }
    }
    return 0;
}
```
- **Explanation**: Each `#pragma omp section` is executed in parallel by different threads.

---

### **4. Synchronization**

#### **4.1 Critical Sections**
Ensure that only one thread executes a particular section of code at a time.
```c
#include <omp.h>
#include <stdio.h>

int main() {
    int sum = 0;

    #pragma omp parallel for
    for (int i = 0; i < 10; i++) {
        #pragma omp critical
        {
            sum += i;
        }
    }

    printf("Sum is %d\n", sum);
    return 0;
}
```
- **Explanation**: The `#pragma omp critical` directive ensures that only one thread updates `sum` at a time to prevent race conditions.

---

#### **4.2 Barrier**
Ensure all threads reach a specific point before continuing.
```c
#include <omp.h>
#include <stdio.h>

int main() {
    #pragma omp parallel
    {
        printf("Before barrier, thread %d\n", omp_get_thread_num());

        #pragma omp barrier

        printf("After barrier, thread %d\n", omp_get_thread_num());
    }
    return 0;
}
```
- **Explanation**: Threads wait at the barrier until all have reached it, ensuring synchronization at a particular point.

---

### **5. Data Sharing Clauses**

#### **5.1 Shared vs Private Data**

- **Shared Data**: A variable is shared among all threads.
- **Private Data**: Each thread gets its own copy of a variable.

```c
#include <omp.h>
#include <stdio.h>

int main() {
    int i, n = 10, sum = 0;

    #pragma omp parallel for shared(sum) private(i)
    for (i = 0; i < n; i++) {
        sum += i;  // Incorrect without critical or atomic
    }

    printf("Final sum = %d\n", sum);
    return 0;
}
```
- **Explanation**:
  - `shared(sum)`: The variable `sum` is shared by all threads.
  - `private(i)`: Each thread gets its own copy of the loop counter `i`.

---

#### **5.2 Firstprivate**
Initialize a private variable with the value of the original variable.
```c
#include <omp.h>
#include <stdio.h>

int main() {
    int x = 5;
    
    #pragma omp parallel firstprivate(x)
    {
        x += omp_get_thread_num();
        printf("Thread %d, x = %d\n", omp_get_thread_num(), x);
    }

    return 0;
}
```
- **Explanation**: The `x` variable is private for each thread, but it is initialized with the value `5`.

---

### **6. Reduction Clause**

Combines results from multiple threads using a reduction operator like `+`, `*`, etc.
```c
#include <omp.h>
#include <stdio.h>

int main() {
    int sum = 0;

    #pragma omp parallel for reduction(+:sum)
    for (int i = 0; i < 10; i++) {
        sum += i;
    }

    printf("Sum is %d\n", sum);
    return 0;
}
```
- **Explanation**: The reduction operator `+` combines the partial sums calculated by different threads.

---

### **7. Environment Variables**

- **Set the number of threads**:
  - `export OMP_NUM_THREADS=4`
  
- **Control dynamic thread adjustment**:
  - `export OMP_DYNAMIC=TRUE` or `FALSE`

- **Check the number of threads in the program**:
  ```c
  int num_threads = omp_get_num_threads();
  ```

---

### **8. Nested Parallelism**

OpenMP allows for nested parallel regions, where parallel regions are created inside another parallel region.

```c
#include <omp.h>
#include <stdio.h>

int main() {
    omp_set_nested(1);  // Enable nested parallelism

    #pragma omp parallel
    {
        printf("Outer thread %d\n", omp_get_thread_num());

        #pragma omp parallel
        {
            printf("Inner thread %d\n", omp_get_thread_num());
        }
    }
    return 0;
}
```
- **Explanation**: By default, nested parallelism is disabled. You must explicitly enable it using `omp_set_nested(1)`.

---

### **9. Miscellaneous OpenMP Functions**

- **omp_get_num_threads()**: Returns the number of threads in the team.
- **omp_get_max_threads()**: Returns the maximum number of threads.
- **omp_get_thread_num()**: Returns the thread number.
- **omp_in_parallel()**: Returns `true` if inside a parallel region.

---
