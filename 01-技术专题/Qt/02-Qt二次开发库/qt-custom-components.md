# Qt 二次开发与扩展库

> 记录基于 Qt 的第三方库、自研二次开发控件及图表/通信扩展。

---

## 1. 常用开源扩展库概览

| 库名称 | 用途分类 | 特点与适用场景 |
| :--- | :--- | :--- |
| **QCustomPlot** | 数据图表可视化 | 轻量级单一头文件/源码引入，绘制实时曲线性能极高 |
| **Qt-Advanced-Docking-System** | 多窗口与停靠布局 | 类似 Visual Studio 的专业级可拆分、浮动 Dock 窗口系统 |
| **QtXlsxWriter** | Excel 文档处理 | 无需本地安装 Office/WPS 即可读写 `.xlsx` 格式文件 |
| **spdlog / QsLog** | 高性能日志系统 | 提供异步、多 Sink 的轻量级日志记录方案 |

---

## 2. QCustomPlot 集成要点

### 2.1 项目引入
在 `.pro` 文件中加入：
```qmake
QT += printsupport
SOURCES += qcustomplot.cpp
HEADERS += qcustomplot.h
```

### 2.2 性能优化建议
* 实时波形绘制时，开启 OpenGL 加速：
  ```cpp
  customPlot->setOpenGl(true);
  ```
* 避免高频全量刷新，使用 `replot(QCustomPlot::rpQueuedReplot)` 避免界面掉帧。

---

## 3. 自定义控件封装规范
* 继承 `QWidget` 或对应子类并重写 `paintEvent(QPaintEvent *)`。
* 样式尽量支持 QSS（Qt Style Sheets），使用 `Q_PROPERTY` 暴露自定义状态属性。
