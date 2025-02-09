olist_customers_dataset.csv
此数据集包含有关客户及其位置的信息。 使用它来识别订单数据集中的唯一客户并查找订单交货地点。
在我们的系统中，每个订单都分配给一个唯一的customer_id。 这意味着同一个客户将获得不同订单的不同ID。 在数据集上拥有customer_unique_id的目的是允许您识别在商店进行回购的客户。 否则，您会发现每个订单都有不同的客户关联。

olist_geolocation_dataset.csv
此数据集包含巴西邮政编码及其纬度/经度坐标信息。 用它来绘制地图并找出卖家和顾客之间的距离。

olist_Order Items Dataset.csv
此数据集包括有关每个订单中购买的商品的数据。

olist_Payments Dataset.csv
此数据集包含有关订单付款选项的数据。

olist_Order Reviews Dataset.csv
该数据集包括有关客户所做评论的数据。

olist_Order Dataset.csv
这是核心数据集。 您可以从每个订单中找到所有其他信息。

olist_Products Dataset.csv
该数据集包括有关Olist销售的产品的数据

olist_Sellers Dataset.csv
该数据集包括有关在Olist完成订单的卖家的数据。 使用它来查找卖家位置并确定哪个卖家完成了每个产品的出售。

product_Category Name Translation.csv
将商品名从葡萄牙语翻译为英语

理解“巴西电商Olist Store数据集”
https://zhuanlan.zhihu.com/p/493044694

Olist巴西电商数据分析（Python+Tableau）
https://zhuanlan.zhihu.com/p/219956642
数据清洗
1.缺失值：
  分成两部分，将有缺失值的类别分出来进行相应分析：比如异常集中时间等
	另一大部分dropna后进行后续处理（数据没有重复值）
2.异常值：
freight_value最小值是0, 尽量不删除

Preliminary data analysis
github项目Notebooks >> Preliminary data analysis.ipynb
	1.世界地图（订单，卖家，买家，不同颜色（可选），不同类型） （dgs）

	2.Top 10 cities with highest number of customers X Cities' population distribution(Other dataset)X Sellers'  distribution   (lpz)

	3.价格分布先可视化，再决定三档（cheap , moderate , expensive）; 运费 和 商品价格可视化（猜想：货源，卖家，买家，商品属性）  -----》 freight prediction   （lyy）

        4.Trend (monthly) 可视化   (vincent)

Big mission:
    	1:Freight value prediction  (Vincent)
	2.Product analysis (lyy)
	3.Association rule mining (dgs)
	4.Reviews sentiment analysis(lpz)



