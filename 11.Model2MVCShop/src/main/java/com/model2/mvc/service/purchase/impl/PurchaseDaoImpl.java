package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseDao;


//==> 회원관리 DAO CRUD 구현
@Repository("purchaseDaoImpl")
public class PurchaseDaoImpl implements PurchaseDao{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public PurchaseDaoImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addPurchase(Purchase purchase) throws Exception {
		sqlSession.insert("PurchaseMapper.addPurchase", purchase);
		System.out.println("PurchaseMapper"+purchase);
	}

	public Purchase getPurchase(int tranNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getPurchase", tranNo);
	}
	
	public Purchase getPurchase2(int prodNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getPurchase2", prodNo);
	}
	
	public void updatePurchase(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);
	}

	public void updateTranCode(Purchase purchase) throws Exception{
		sqlSession.update("PurchaseMapper.updateTranCode", purchase);
	}
	
	public Map<String , Object> getPurchaseList(Search search, String buyerId) throws Exception {
		
		Map<String , Object>  map = new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("buyerId", buyerId);
	
		System.out.println("#"+map);
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getPurchaseList", map); 
		
		
		System.out.println();
//		
//		System.out.println("두두두두ㅜㄷ두ㅜ두 : "+list.size());
//		System.out.println("두두두두ㅜㄷ두ㅜ두다다다ㅏ다다다ㅏ : "+ list.get(0).getBuyer().getUserId());
//		System.out.println("두두두두ㅜㄷ두ㅜ두다다다ㅏ다다다ㅏ : "+ list.get(0).getPurchaseProd().getProdNo());
//		
//		
		
		
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setBuyer((User)sqlSession.selectOne("UserMapper.getUser", list.get(i).getBuyer().getUserId()));
			list.get(i).setPurchaseProd((Product)sqlSession.selectOne("ProductMapper.getProduct", list.get(i).getPurchaseProd().getProdNo()));
		}
		
		map.put("totalCount", sqlSession.selectOne("PurchaseMapper.getTotalCount", buyerId));

		map.put("list", list);
		
		System.out.println("#"+list);
		System.out.println("search"+search);
		System.out.println("buyerId"+buyerId);
		
		System.out.println("리턴값 뭐냐 시부럴="+map);
		return map;
	}
	
	public  Map<String , Object> getSaleList(Search search) throws Exception {
		
		Map<String , Object>  map = new HashMap<String, Object>();
		
		map.put("search", search);
			
		
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getSaleList", map); 
		System.out.println("liasldkfjsdkl;sadf.,dsmfksdam"+list);
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setBuyer((User)sqlSession.selectOne("UserMapper.getUser", list.get(i).getBuyer().getUserId()));
			list.get(i).setPurchaseProd((Product)sqlSession.selectOne("ProductMapper.getProduct", list.get(i).getPurchaseProd().getProdNo()));
		}
		
		map.put("totalCount", sqlSession.selectOne("PurchaseMapper.getSaleTotalCount", search));

		map.put("list", list);
		System.out.println("asfasdfadsf"+map.toString());
		return map;
//		return sqlSession.selectList("PurchaseMapper.getSaleList", search); 
	}
	
//	public List<Purchase> getSaleList(Search search) throws Exception {
//		
//		return sqlSession.selectList("PurchaseMapper.getSaleList", search); 
//	}

	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	
	
}