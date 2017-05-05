package com.restPhoto.Model;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import com.img.Io.ImagesIo;


public class RestPhotoService {
	private RestPhoto_interface dao;
	
	public RestPhotoService(){
		dao = new RestPhotoDAO();
	}
	
	public RestPhotoVO addRestPhoto(Integer RestId,byte[] RestImage1,String fileName1,
			byte[] RestImage2,String fileName2,byte[] RestImage3,String fileName3) throws IOException{
		
		RestPhotoVO repohtoVO = new RestPhotoVO();
		
		repohtoVO.setRestId(RestId);
		repohtoVO.setRestImage1(RestImage1);
		repohtoVO.setFileName1(fileName1);
		repohtoVO.setRestImage2(RestImage2);
		repohtoVO.setFileName2(fileName2);
		repohtoVO.setRestImage3(RestImage3);
		repohtoVO.setFileName3(fileName3);	
		
		dao.insert(repohtoVO);
		return repohtoVO;
	}
	
	public RestPhotoVO update(Integer RePhotoId,Integer RestId,byte[] RestImage1,String fileName1,
			byte[] RestImage2,String fileName2,byte[] RestImage3,String fileName3){
		
		RestPhotoVO repohtoVO = new RestPhotoVO();
		
		repohtoVO.setRePhotoId(RePhotoId);
		repohtoVO.setRestId(RestId);
		repohtoVO.setRestImage1(RestImage1);
		repohtoVO.setFileName1(fileName1);
		repohtoVO.setRestImage2(RestImage2);
		repohtoVO.setFileName2(fileName2);
		repohtoVO.setRestImage3(RestImage3);
		repohtoVO.setFileName3(fileName3);
		
		
		dao.update(repohtoVO);
		
		return dao.findByPrimaryKey(RePhotoId);
	}
	
	public void delete(Integer RePhotoId){
		dao.delete(RePhotoId);
	}
	
	public RestPhotoVO getoneRePohto(Integer RePhotoId){
		return dao.findByPrimaryKey(RePhotoId);
	}
	
	public List<RestPhotoVO> getAllRest(){
		return dao.selectAll();
	}
	
	public RestPhotoVO getRePohtos(Integer RestId){
		return dao.findByRestId(RestId);
	}
	
	public long getPhotoCount(){
		return dao.PhotoCount();
	}
	
}

