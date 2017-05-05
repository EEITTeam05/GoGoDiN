package message.Model;

import java.util.List;

public interface Message_interface {
	public void insert(MessageVO VO);
	public void update(MessageVO VO);
	public void delete(Integer MesId);	
	public MessageVO findByPrimaryKey(Integer restId);
	public void updateIsRead(Integer MesId);
	public List<MessageVO> selectAll();
	public Long getIsNotReadCount(String Account);
	public List<MessageVO> findByReceived(String Account);
}
