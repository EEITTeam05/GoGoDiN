package com.favorite.Model;

import java.sql.Timestamp;
import com.member.Model.MemberListVO;
import com.rest.Model.RestVO;

public class FavoriteVO {

	private Integer FavoriteId;
	private MemberListVO memVO;
	private RestVO restVO;
	private Timestamp AddTime;
	
	public Integer getFavoriteId() {
		return FavoriteId;
	}
	public void setFavoriteId(Integer favoriteId) {
		FavoriteId = favoriteId;
	}
	public MemberListVO getMemVO() {
		return memVO;
	}
	public void setMemVO(MemberListVO memVO) {
		this.memVO = memVO;
	}
	public RestVO getRestVO() {
		return restVO;
	}
	public void setRestVO(RestVO restVO) {
		this.restVO = restVO;
	}
	public Timestamp getAddTime() {
		return AddTime;
	}
	public void setAddTime(Timestamp addTime) {
		AddTime = addTime;
	}
	
	
	
}
