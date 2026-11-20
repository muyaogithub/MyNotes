# C++ 核心与进阶笔记

> 记录现代 C++ 特性、内存管理、面向对象及常用 STL 实践。

---

## 1. 现代 C++ 实用特性 (C++11/14/17/20)

### 1.1 自动类型推导 (`auto` & `decltype`)
* `auto`：让编译器推导变量类型，简化复杂迭代器或模板返回值的编写。
* `decltype`：获取表达式的类型而不实际计算表达式。

### 1.2 智能指针 (Smart Pointers)
现代 C++ 提倡 RAII（资源获取即初始化），避免裸指针导致的内存泄漏与悬挂指针：

* `std::unique_ptr`：独占所有权，不可拷贝，支持 `std::move` 转移。
* `std::shared_ptr`：共享所有权，内部通过引用计数管理资源。
* `std::weak_ptr`：弱引用，配合 `shared_ptr` 解决循环引用（Circular Dependency）问题。

```cpp
#include <memory>
#include <iostream>

struct Resource {
    Resource() { std::cout << "Resource Acquired\n"; }
    ~Resource() { std::cout << "Resource Released\n"; }
};

int main() {
    auto ptr = std::make_unique<Resource>(); // 离开作用域自动释放
    return 0;
}
```

---

## 2. 内存模型与对象生命周期
* **栈内存 (Stack)**：编译器自动管理，分配速度极快，适合生命周期确定的局部变量。
* **堆内存 (Heap)**：程序员或智能指针手动管理，生命周期灵活但存在碎片和分配开销。
* **常量区 / 静态区**：存放全局变量、静态变量和字符串常量。

---

## 3. 后续拓展规划
- [ ] Lambda 表达式与仿函数实战
- [ ] 多线程并发与 `std::mutex` / `std::atomic`
- [ ] 移动语义与完美转发 (`std::forward`)
