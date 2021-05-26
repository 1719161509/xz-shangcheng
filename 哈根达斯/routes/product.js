//用户路由器，包含很多用户相关的路由
const express = require('express');
//引入连接池模块
const pool = require('../pool.js');

//创建路由器对象，
let router = express.Router();
//挂载路由
//1.商品列表
//url: /list  method:get
router.get('/list',(req,res)=>{
    //获取数据
    var obj=req.query;
    var $pno=obj.pno;
    var $pageSize=obj.pageSize; 
    //验证页码
    if(!$pno) 
      $pno=1;
    else
      $pno=parseInt($pno);
    //验证每页大小
    if(!$pageSize)
      $pageSize=9;
    else
      $pageSize=parseInt($pageSize);
    var output={
      recordCount:0,
      pageSize:$pageSize,
      pageCount:0,
      pno:$pno, 
      data:[]
    };
    var sql1='SELECT COUNT(lid) AS a FROM hd_Dessert';  
    //计算开始查询的值
    var start=($pno-1)*output.pageSize;  
    var count=output.pageSize;  
    var sql2 = 'SELECT lid,title,price,sold_count,is_onsale FROM hd_Dessert  ORDER BY sold_count DESC LIMIT ?,?';
    //执行SQL语句，响应查询到的数据
    pool.query(sql1,(err,result)=>{
      if(err) throw err;
      console.log(result);
      output.recordCount=result[0].a;
      //计算总页数
      output.pageCount=Math.ceil(output.recordCount/output.pageSize);
  
    });
  
    pool.query(sql2,[start,count],(err,result)=>{
      if(err) throw err;
      console.log(result);   
      output.data=result;
      for(var i=0;i<output.data.length;i++){
        var lid=output.data[i].lid;
        (function(lid,i){
          pool.query('SELECT md FROM hd_Dessert_pic WHERE Dessert_id=? LIMIT 0,1',[lid],(err,result)=>{
              console.log(result);
            output.data[i].pic=result[0].md;
          });
        })(lid,i);
      }
      setTimeout(() => {
        res.send(output);
      }, 100);
    });
  });
//商品详情
router.get('/detail',(req,res)=>{
    var output={
      details:{},
      family:{}
    };
    //获取数据，
    var obj=req.query;
    var $lid=obj.lid;
    if(!$lid){
      res.send({code:401,msg:'lid required'});
        return;
    }
    //执行SQL语句，把查询的数据响应给浏览器
    pool.query('SELECT * FROM hd_Dessert WHERE lid=?',[$lid],(err,result)=>{
      if(err) throw err;
      //判断数据是否为空
      if(result.length==0){
        res.send({code:301,msg:'detail err'});
      }else{
        output.details=result[0];
        var lid=result[0].lid;
        var fid=result[0].family_id;
        var sql=`
        SELECT * FROM hd_Dessert_pic WHERE Dessert_id=? ORDER BY pid;
        SELECT * FROM hd_Dessert_family WHERE fid=?;
        SELECT lid,spec FROM hd_Dessert WHERE family_id=?;
        `;
        pool.query(sql,[lid,fid,fid],(err,result)=>{
          output.details.picList=result[0];
          output.family=result[1][0];
          output.family.DessertList=result[2];
        });  
  
        setTimeout(() => {
          res.send(output);
        }, 100);
        
      }
    });
  });
// 删除商品 get /delete
router.get('/delete', (req, res) => {
    //获取数据
    let obj = req.query;
    //验证是否为空
    if (!obj.lid) {
        res.send({ code: 401, msg: '编号为空' });
        return;
    }
    //执行sql语句
    pool.query('DELETE FROM hd_Dessert WHERE lid=?', [obj.lid], (err, result) => {
        if (err) throw err;
        console.log(result);
        if (result.affectedRows > 0) {
            res.send({
                code: 200,
                msg: '”delete suc'
            });
        } else {
            res.send({ code: 301, msg: '删除失败' });
        }
    });
});
//添加商品， post    /reg
router.post('/add', (req, res) => {
    //获取表单数据
    let obj = req.body;
    //验证各项数据是否为空
    if (!obj.family_id) {
        res.send({ code: 401, msg: '所属型号家族编号为空' });
        //阻止往下执行
        return;
    }
    if (!obj.title) {
        res.send({ code: 402, msg: '主标题为空' });
        //阻止往下执行
        return;
    }
    if (!obj.subtitle) {
        res.send({ code: 403, msg: '邮箱为空' });
        //阻止往下执行
        return;
    }
    if (!obj.price) {
        res.send({ code: 404, msg: '价格为空' });
        //阻止往下执行
        return;
    }
    if (!obj.promise) {
        res.send({ code: 405, msg: '服务承诺为空' });
        //阻止往下执行
        return;
    }
    if (!obj.spec) {
        res.send({ code: 406, msg: '规格/颜色为空' });
        //阻止往下执行
        return;
    }
    if (!obj.lname) {
        res.send({ code: 407, msg: '商品名称为空' });
        //阻止往下执行
        return;
    }
    
    
    
    
    
    
    if (!obj.details) {
        res.send({ code: 415, msg: '产品详细说明为空' });
        //阻止往下执行
        return;
    }
    
    pool.query('INSERT INTO hd_Dessert SET ?', [obj], (err, result) => {
        if (err) throw err;
        console.log(result);
        if (result.affectedRows > 0) {
            res.send({ code: 200, msg: 'add suc' });
        } else {
            res.send({ code: 301, msg: '注册失败' });
        }
    });

});


















//导出路由器对象
module.exports = router;