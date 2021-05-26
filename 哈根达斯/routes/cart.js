const express=require('express');
const pool=require('../pool.js');
var router=express.Router();
//1.添加购物车
router.get('/add',(req,res)=>{
    var obj=req.query;
    var $lid=obj.lid;
    var $buyCount=obj.buyCount;
    if(!obj.lid){
        res.send({code:401,msg:'lid required'});
        return;
    }
    if(!obj.buyCount){
        res.send({code:402,msg:'buyCount required'});
        return;
    }
    if(!req.session.loginUid){
        req.session.pageToJump='cart.html';
        req.session.toBuyLid=obj.lid;
        req.session.toBuyCount=obj.buyCount;
        res.send({code:300,msg:'login required'});
        return;
    }
    var sql=`SELECT iid FROM hd_shoppingcart_item WHERE user_id=? AND product_id=?`;
    pool.query(sql,[req.session.loginUid,$lid],(err,result)=>{
        if(err) throw err;
        var sql2;
        if(result.length>0){
            sql2=`UPDATE hd_shoppingcart_item SET count=count+1 WHERE user_id=${req.session.loginUid} AND product_id=${$lid}`;

        }else{
            sql2=`INSERT INTO hd_shoppingcart_item VALUES(NULL, ${req.session.loginUid}, ${$lid}, ${$buyCount}, false)`;
        }
        pool.query(sql2,(err,result2)=>{
            if(err) throw err;
            if(result2.affectedRows>0){
                res.send({code:200,msg:'add suc'});
            }else{
                res.send({code:500,msg:'add err'});
            }
        });
    });
});
//2.购物车列表
router.get('/list',(req,res)=>{
    var output={};
    if(!req.session.loginUid){
        req.session.pageToJump='cart.html';
        res.send({code:300,msg:'login required'});
        return;
    }
    var sql='SELECT iid,lid,title,spec,price,count FROM hd_laptop l, hd_shoppingcart_item s WHERE l.lid=s.product_id AND user_id=?';
    pool.query(sql,[req.session.loginUid],(err,result)=>{
        if(err) throw err;
        output.code=200;
        output.data=result;
        for(var i=0;i<output.data.length;i++){
            var lid=output.data[i].lid;
            (function(lid,i){
              pool.query('SELECT sm FROM hd_laptop_pic WHERE laptop_id=? LIMIT 1',[lid],(err,result)=>{
                output.data[i].pic=result[0].sm;
              });
            })(lid,i);
        }
        setTimeout(() => {
            res.send(output);
        }, 100);
    });
});
//3.删除购物车
router.get('/del',(req,res)=>{
    var obj=req.query;
    if(!obj.iid){
        res.send({code:401,msg:'iid required'});
        return;
    }
    if(!req.session.loginUid){
        res.send({code:300,msg:'login required'});
        return;
    }
    pool.query('DELETE FROM hd_shoppingcart_item WHERE iid=?',[obj.iid],(err,result)=>{
        if(err) throw err;
        if(result.affectedRows>0){
            res.send({code:200,msg:'delete succ'});
        }else{
            res.send({code:500,msg:'delete err'});
        }
    });
});


module.exports=router;