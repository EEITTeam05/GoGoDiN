package com.favorite.Model;

import java.util.List;


public interface FavoriteDAO_interface {
	public void insert(FavoriteVO favoriteVO);
	public void update(FavoriteVO favoriteVO);
	public void delete(Integer favoriteId);
	public void delete(Integer restId,Integer MemId);
	public FavoriteVO findByPrimaryKey(Integer favoriteId);
	public List<FavoriteVO> getAll();	
	public List<FavoriteVO> findByMidFavorite(Integer MemberId);
	
//	public List<FavoriteVO[]> findByShopId(Integer shopId);	
//	public List<FavoriteVO> findByRestId(Integer restId);
}
