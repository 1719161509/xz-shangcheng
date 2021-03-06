SET NAMES UTF8;
DROP DATABASE IF EXISTS hd;
CREATE DATABASE hd CHARSET=UTF8;
USE hd;


/**哈根达斯家族**/
CREATE TABLE hd_Dessert_family(
  fid INT PRIMARY KEY AUTO_INCREMENT,
  fname VARCHAR(32)
);




/**哈根达斯甜品详情**/
CREATE TABLE hd_Dessert(
  lid INT PRIMARY KEY AUTO_INCREMENT,
  family_id INT,              #所属型号编号
  title VARCHAR(128),         #主标题
  subtitle VARCHAR(128),      #副标题
  price DECIMAL(10,2),        #价格
  promise VARCHAR(64),        #服务承诺
  spec VARCHAR(64),           #规格/颜色			
  lname VARCHAR(32),          #商品名称
  details VARCHAR(1024),      #产品详细说明
  sold_count INT,
  is_onsale BOOLEAN
);

/**哈根达斯甜品图片**/
CREATE TABLE hd_Dessert_pic(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  Dessert_id INT,              #哈根达斯编号
  sm VARCHAR(128),            #小图片路径
  md VARCHAR(128),            #中图片路径
  lg VARCHAR(128)             #大图片路径
);

/**用户信息**/
CREATE TABLE hd_user(
  uid INT PRIMARY KEY AUTO_INCREMENT,
  uname VARCHAR(32),
  upwd VARCHAR(32),
  email VARCHAR(64),
  phone VARCHAR(16),

  avatar VARCHAR(128),        #头像图片路径
  user_name VARCHAR(32),      #用户名，如王小二
  gender INT                  #性别  0-女  1-男
);

/**收货地址信息**/
CREATE TABLE hd_receiver_address(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,                #用户编号
  receiver VARCHAR(16),       #接收人姓名
  province VARCHAR(16),       #省
  city VARCHAR(16),           #市
  county VARCHAR(16),         #县
  address VARCHAR(128),       #详细地址
  cellphone VARCHAR(16),      #手机
  fixedphone VARCHAR(16),     #固定电话
  postcode CHAR(6),           #邮编
  tag VARCHAR(16),            #标签名

  is_default BOOLEAN          #是否为当前用户的默认收货地址
);

/**购物车条目**/
CREATE TABLE hd_shoppingcart_item(
  iid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,      #用户编号
  product_id INT,   #商品编号
  count INT,        #购买数量
  is_checked BOOLEAN #是否已勾选，确定购买
);

/**用户订单**/
CREATE TABLE hd_order(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  address_id INT,
  status INT,             #订单状态  1-等待付款  2-等待发货  3-运输中  4-已签收  5-已取消
  order_time BIGINT,      #下单时间
  pay_time BIGINT,        #付款时间
  deliver_time BIGINT,    #发货时间
  received_time BIGINT    #签收时间
)AUTO_INCREMENT=10000000;

/**用户订单**/
CREATE TABLE hd_order_detail(
  did INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,           #订单编号
  product_id INT,         #产品编号
  count INT               #购买数量
);

/****首页轮播广告商品****/
CREATE TABLE hd_index_carousel(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  img VARCHAR(128),
  title VARCHAR(64),
  href VARCHAR(128)
);

/****首页商品****/
CREATE TABLE hd_index_product(
  pid INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(64),
  details VARCHAR(128),
  pic VARCHAR(128),
  price DECIMAL(10,2),
  href VARCHAR(128),
  seq_recommended TINYINT,
  seq_new_arrival TINYINT,
  seq_top_sale TINYINT
);

/*******************/
/******数据导入******/
/*******************/
/**哈根达斯家族**/
INSERT INTO hd_Dessert_family VALUES
(NULL,'蛋糕冰淇淋'),
(NULL,'创意冰淇淋'),
(NULL,'原装冰淇淋'),
(NULL,'手装冰淇淋'),
(NULL,'饮品');

/**哈根达斯**/
INSERT INTO hd_Dessert VALUES
(1,1,'蛋糕冰淇淋','香草冰淇淋与草莓冰淇淋，抒写小小甜蜜童话','328','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','650克 2-4人左右/1.15千克 5-8人左右/1.9千克 8人以上','小公主','香草口味冰淇淋、草莓冰淇淋','100','1'),
(2,1,'蛋糕冰淇淋','曲奇奶香冰淇淋加上香草冰淇淋，勾画童心意趣','328','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','650克 2-4人左右/1.15千克 5-8人左右/1.9千克 8人以上','小王子','香草口味冰淇淋、曲奇奶香冰淇淋','100','1'),
(3,1,'蛋糕冰淇淋','草莓冰淇淋与原味酸奶冰淇淋，浓情献礼感恩馈赠','328','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','650克 2-4人左右/1.15千克 5-8人左右/1.9千克 8人以上','玫瑰心语','原味酸奶冰淇淋、草莓冰淇淋','100','1'),
(4,1,'蛋糕冰淇淋','酸奶醇厚、白桃甜美、茉莉淡雅、玫瑰浓郁，四种人气口味，与所爱一起分享这藏在甜蜜中的花语花愿吧！','428','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','650克 2-4人左右/1.15千克 5-8人左右/1.9千克 8人以上','花语花愿','茉莉口味冰淇淋、玫瑰荔枝冰淇淋、白桃冰淇淋、原味冰淇淋','100','1'),
(5,2,'创意冰淇淋','闪电冰淇淋','58','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','闪电冰淇淋-草莓口味','闪电冰淇淋-草莓口味','草莓口味','100','1'),
(6,2,'创意冰淇淋','闪电冰淇淋','58','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','闪电冰淇淋-覆盆子白桃口味','闪电冰淇淋-覆盆子白桃口味','覆盆子白桃口味','100','1'),
(7,2,'创意冰淇淋','闪电冰淇淋','58','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','闪电冰淇淋-咖啡口味','闪电冰淇淋-咖啡口味','咖啡口味','100','1'),
(8,2,'创意冰淇淋','闪电冰淇淋','58','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','闪电冰淇淋-比利时巧克力口味','闪电冰淇淋-比利时巧克力口味','比利时巧克力口味','100','1'),
(9,3,'原装冰淇淋','香草口味,草莓,抹茶,比利时巧克力,葡萄兰姆酒','39','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','香草口味','小纸杯单个装','香草口味','100','1'),
(10,3,'原装冰淇淋','香草口味,草莓,抹茶,比利时巧克力,葡萄兰姆酒等','99','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','芒果口味','品脱单个装','芒果口味','100','1'),
(11,3,'原装冰淇淋','香草口味,草莓,抹茶,比利时巧克力,葡萄兰姆酒等','39','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','草莓口味','脆皮条单个装','草莓口味','100','1'),
(12,3,'原装冰淇淋','香草口味,草莓,抹茶,比利时巧克力,葡萄兰姆酒等','39','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','抹茶口味','三明治单个装','抹茶口味','100','1'),
(13,4,'手装冰淇淋','产品以实物为准，收到请尽快食用','99','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','自选二种口味','手装二合一口味品脱冰淇淋B','香草口味','100','1'),
(14,4,'手装冰淇淋','产品以实物为准，收到请尽快食用','39','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','口味自选','手装单球小纸杯冰淇淋B','芒果口味','100','1'),
(15,4,'手装冰淇淋','产品以实物为准，收到请尽快食用','69','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','自选二种口味','手装双球小纸杯冰淇淋B','草莓口味','100','1'),
(16,4,'手装冰淇淋','产品以实物为准，收到请尽快食用','99','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','口味自选','手装单口味品脱冰淇淋C','抹茶口味','100','1'),
(17,5,'饮品','图片仅供参考，产品以实物为准','49','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','330ml','花花宇宙 莓果优格奶昔','原味风味酸奶、覆盆子雪芭','100','1'),
(18,5,'饮品','图片仅供参考，产品以实物为准','39','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','330ml','魔“莉“16 茉莉石榴奶绿','冰淇淋（茉莉花覆盆子石榴风味）','100','1'),
(19,5,'饮品','图片仅供参考，产品以实物为准','39','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','330ml','“荔“志玫瑰 覆盆子玫瑰风味拿铁咖啡 冷','冰淇淋（玫瑰荔枝覆盆子风味、覆盆子雪芭） 缤纷糕点（青稞爆爆珠）','100','1'),
(20,5,'饮品','图片仅供参考，产品以实物为准','39','*退货补运费 *7天无忧退货 *48小时快速退款 *24小时发货','330ml','“荔“志玫瑰 覆盆子玫瑰风味拿铁咖啡 热','冰淇淋（玫瑰荔枝覆盆子风味、覆盆子雪芭） 缤纷糕点（青稞爆爆珠）','100','1');

/**哈根达斯甜品图片**/
INSERT INTO hd_Dessert_pic VALUES
(NULL, 1, 'img/product/sm/57b12a31N8f4f75a3.jpg','img/product/md/57b12a31N8f4f75a3.jpg','img/product/lg/57b12a31N8f4f75a3.jpg'),
(NULL, 2, 'img/product/sm/57ad359dNd4a6f130.jpg','img/product/md/57ad359dNd4a6f130.jpg','img/product/lg/57ad359dNd4a6f130.jpg'),
(NULL, 3, 'img/product/sm/57ad8846N64ac3c79.jpg','img/product/md/57ad8846N64ac3c79.jpg','img/product/lg/57ad8846N64ac3c79.jpg'),
(NULL, 4, 'img/product/sm/57b12a31N8f4f75a3.jpg','img/product/md/57b12a31N8f4f75a3.jpg','img/product/lg/57b12a31N8f4f75a3.jpg'),
(NULL, 5, 'img/product/sm/57ad359dNd4a6f130.jpg','img/product/md/57ad359dNd4a6f130.jpg','img/product/lg/57ad359dNd4a6f130.jpg'),
(NULL, 6, 'img/product/sm/57ad8846N64ac3c79.jpg','img/product/md/57ad8846N64ac3c79.jpg','img/product/lg/57ad8846N64ac3c79.jpg'),
(NULL, 7, 'img/product/sm/57b12a31N8f4f75a3.jpg','img/product/md/57b12a31N8f4f75a3.jpg','img/product/lg/57b12a31N8f4f75a3.jpg'),
(NULL, 8, 'img/product/sm/57ad359dNd4a6f130.jpg','img/product/md/57ad359dNd4a6f130.jpg','img/product/lg/57ad359dNd4a6f130.jpg'),
(NULL, 9, 'img/product/sm/57ad8846N64ac3c79.jpg','img/product/md/57ad8846N64ac3c79.jpg','img/product/lg/57ad8846N64ac3c79.jpg'),
(NULL, 10, 'img/product/sm/57b12a31N8f4f75a3.jpg','img/product/md/57b12a31N8f4f75a3.jpg','img/product/lg/57b12a31N8f4f75a3.jpg'),
(NULL, 11, 'img/product/sm/57ad359dNd4a6f130.jpg','img/product/md/57ad359dNd4a6f130.jpg','img/product/lg/57ad359dNd4a6f130.jpg'),
(NULL, 12, 'img/product/sm/57ad8846N64ac3c79.jpg','img/product/md/57ad8846N64ac3c79.jpg','img/product/lg/57ad8846N64ac3c79.jpg'),
(NULL, 13, 'img/product/sm/57e3b072N661cd00d.jpg','img/product/md/57e3b072N661cd00d.jpg','img/product/lg/57e3b072N661cd00d.jpg'),
(NULL, 14, 'img/product/sm/57e1ff09Nf610fea3.jpg','img/product/md/57e1ff09Nf610fea3.jpg','img/product/lg/57e1ff09Nf610fea3.jpg'),
(NULL, 15, 'img/product/sm/57e1ff17N286390a9.jpg','img/product/md/57e1ff17N286390a9.jpg','img/product/lg/57e1ff17N286390a9.jpg'),
(NULL, 16, 'img/product/sm/57e1ff2fN8a36d0fe.jpg','img/product/md/57e1ff2fN8a36d0fe.jpg','img/product/lg/57e1ff2fN8a36d0fe.jpg'),
(NULL, 17, 'img/product/sm/57e52dffNa4d8ce2c.jpg','img/product/md/57e52dffNa4d8ce2c.jpg','img/product/lg/57e52dffNa4d8ce2c.jpg'),
(NULL, 18, 'img/product/sm/57e52e03N4ec367dd.jpg','img/product/md/57e52e03N4ec367dd.jpg','img/product/lg/57e52e03N4ec367dd.jpg'),
(NULL, 19, 'img/product/sm/57e52e06N116974f7.jpg','img/product/md/57e52e06N116974f7.jpg','img/product/lg/57e52e06N116974f7.jpg'),
(NULL, 20, 'img/product/sm/57e52dffNa4d8ce2c.jpg','img/product/md/57e52dffNa4d8ce2c.jpg','img/product/lg/57e52dffNa4d8ce2c.jpg');


/**用户信息**/
INSERT INTO hd_user VALUES
(NULL, 'benbikeke', '123456', 'benbikeke@qq.com', '13501234567', 'img/avatar/default.png', '笨比科科', '1'),
(NULL, 'laogui', '123456', 'laogui@qq.com', '13501234568', 'img/avatar/default.png', '老鬼', '1'),
(NULL, 'zhanghao', '123456', 'zhanghao@qq.com', '13501234569', 'img/avatar/default.png', '张浩', '1'),
(NULL, 'jiegou', '123456', 'jiegou@qq.com', '13501234560', 'img/avatar/default.png', '杰狗', '0');

/****首页轮播广告商品****/
INSERT INTO hd_index_carousel VALUES
(NULL, 'img/index/banner1.png','轮播广告商品1','product_details.html?lid=28'),
(NULL, 'img/index/banner2.png','轮播广告商品2','product_details.html?lid=19'),
(NULL, 'img/index/banner3.png','轮播广告商品3','lookforward.html'),
(NULL, 'img/index/banner4.png','轮播广告商品4','lookforward.html');

/****首页商品****/
INSERT INTO hd_index_product VALUES
(NULL, '蛋糕冰淇淋', '香草冰淇淋与草莓冰淇淋，抒写小小甜蜜童话', 'img/index/study_computer_img1.png', 6988, 'product_details.html?lid=1', 1, 1, 1),
(NULL, '创意冰淇淋', '闪电冰淇淋', 'img/index/study_computer_img2.png', 3488, 'product_details.html?lid=5', 2, 2, 2),
(NULL, '原装冰淇淋', '香草口味,草莓,抹茶,比利时巧克力,葡萄兰姆酒', 'img/index/study_computer_img3.png', 5399, 'product_details.html?lid=9', 3, 3, 3),
(NULL, '手装冰淇淋', '产品以实物为准，收到请尽快食用', 'img/index/study_computer_img4.png', 4966, 'product_details.html?lid=13', 4, 4, 4),
(NULL, '饮品', '图片仅供参考，产品以实物为准', 'img/index/study_computer_img5.png', 6299, 'product_details.html?lid=17', 5, 5, 5);
