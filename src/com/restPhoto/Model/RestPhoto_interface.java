package com.restPhoto.Model;

import java.util.List;

public interface RestPhoto_interface {
	public void insert(RestPhotoVO restPhotoVO);
	public void update(RestPhotoVO restPhotoVO);
	public void delete(Integer rePhotoId);
	public RestPhotoVO findByPrimaryKey(Integer rePhotoId);
	public RestPhotoVO findByRestId(Integer RestId);
	public List<RestPhotoVO> selectAll();
	public long PhotoCount();
}
