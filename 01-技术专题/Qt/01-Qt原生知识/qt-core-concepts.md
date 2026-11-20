# Qt 原生核心机制

> 记录 Qt 框架底层基础、元对象系统、信号与槽机制及事件循环。

---

## 1. 元对象系统 (Meta-Object System)

Qt 的元对象系统是其强大特性的基石，提供了：
1. 信号与槽（Signals & Slots）机制；
2. 运行时类型信息（RTTI）；
3. 动态属性系统（Dynamic Properties）。

### 核心三要素
* **`QObject` 基类**：所有需要使用元对象特性的类的根基类。
* **`Q_OBJECT` 宏**：在类定义私有区声明，启用元对象编译器（moc）代码生成。
* **MOC (Meta-Object Compiler)**：读取 C++ 头文件，生成对应的 `moc_xxx.cpp` 代码。

---

## 2. 信号与槽 (Signals and Slots)

### 2.1 现代连接语法 (C++11 风格)
```cpp
// 推荐语法：编译期类型检查，支持 Lambda 表达式
connect(sender, &SenderClass::signalName, 
        receiver, &ReceiverClass::slotName);

// Lambda 形式
connect(button, &QPushButton::clicked, this, [this]() {
    qDebug() << "Button clicked!";
});
```

### 2.2 连接类型 (`Qt::ConnectionType`)
* `Qt::AutoConnection`（默认）：如果发送者和接收者在同一线程，等同于 DirectConnection；不在同一线程则等同于 QueuedConnection。
* `Qt::DirectConnection`：同步调用，槽函数在发送者线程立即执行。
* `Qt::QueuedConnection`：异步调用，信号作为事件投递到接收者线程的事件循环中排队执行。
* `Qt::BlockingQueuedConnection`：跨线程阻塞等待，直到槽函数执行完毕（注意：同线程使用会导致死锁！）。

---

## 3. 对象树与内存回收 (Object Trees)
* Qt 依靠父子对象关系（`parent-child`）实现半自动内存管理。
* 当一个 `QObject` 析构时，其析构函数会自动析构其所有的子对象（`children()`）。
* **规范**：堆上创建的窗口和控件，务必传入合理的 `parent` 指针。
