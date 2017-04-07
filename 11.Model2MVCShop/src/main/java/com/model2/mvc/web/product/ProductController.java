package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

//==> ȸ������ Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
	
	
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml ���� �Ұ�
	//==> �Ʒ��� �ΰ��� �ּ��� Ǯ�� �ǹ̸� Ȯ�� �Ұ�
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping(value="addProductView", method=RequestMethod.GET)
	public String addProductView() throws Exception {

		System.out.println("/product/addProductView : GET");
		
		return "redirect:/product/addProductView.jsp";
	}
	
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product ) throws Exception {

		System.out.println("/product/addProduct : POST");
		product.setManuDate(product.getManuDate().replace("-", ""));
		MultipartFile uploadfile = product.getUploadfile();
        if (uploadfile != null) {
            String fileName = uploadfile.getOriginalFilename();
            product.setFileName(fileName);
            try {
                File file = new File("C:/Users/���ؿ�/git/11Mini/11.Model2MVCShop/WebContent/images/uploadFiles" + fileName);
                uploadfile.transferTo(file);
            } catch (IOException e) {
                e.printStackTrace();
                
            } 
        }
		productService.addProduct(product);
		
		return "redirect:/product/listProduct?menu=search";
	}
	
	@RequestMapping(value="getProduct", method={RequestMethod.GET, RequestMethod.POST})
	public String getProduct( @RequestParam("prodNo") int prodNo , @RequestParam("menu") String menu, Model model, HttpSession session ) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);
		
		if(menu.equals("manage")){
			System.out.println("GetProductAction��1");
			return "forward:/product/updateProduct.jsp";
		}
		System.out.println("GetProductAction��2");
		return "forward:/product/getProduct.jsp";
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	@RequestMapping(value="getJsonProduct/{prodNo}", method={RequestMethod.GET, RequestMethod.POST})
	public void getJsonProduct( @PathVariable int prodNo, Model model, HttpSession session ) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		Product product = productService.getProduct(prodNo);
		model.addAttribute("product", product);
		
	}
	
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	@RequestMapping(value="updateProductView", method=RequestMethod.GET)
	public String updateProductView( @RequestParam("userId") int prodNo , Model model ) throws Exception{

		System.out.println("/product/updateUserView : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model �� View ����
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product , Model model , HttpSession session) throws Exception{

		System.out.println("/product/updateProduct : POST");
		//Business Logic
		
		MultipartFile uploadfile = product.getUploadfile();
        if (uploadfile != null) {
            String fileName = uploadfile.getOriginalFilename();
            product.setFileName(fileName);
            try {
                File file = new File("C:/Users/���ؿ�/git/09Mini/09.Model2MVCShop(jQuery)/WebContent/images/uploadFiles" + fileName);
                uploadfile.transferTo(file);
            } catch (IOException e) {
                e.printStackTrace();
            } 
        }
		
		productService.updateProduct(product);
		
		model.addAttribute("product", product);
		
		
		return "redirect:/product/listProduct?menu=manage";
	}
	
	@RequestMapping(value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/listProduct");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic ����
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model �� View ����
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}
}