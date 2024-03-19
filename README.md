Title: 下拉放大效果  
Category: [iOS][L1]  
Labels: [UITableView][L2]  

## 前言  
美術總是想要酷炫的 UI, 記錄之前美術所提的需求, TableView 下拉時, 上方圖片要放大

![](Resources/screenshot.gif)

## 實作  
基本上就是監聽 UITableView 的 UIScrollViewDelegate, 然後改變 Header 的 layer.transform.

> 詳細的 transform 公式忘了怎麼來的, google uitableview parallax 就有一堆公式了

[L1]: https://github.com/shinrenpan/Note/discussions/categories/ios
[L2]: https://github.com/shinrenpan/Note/discussions?discussions_q=label:UITableView
