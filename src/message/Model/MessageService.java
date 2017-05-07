package message.Model;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.List;

public class MessageService {
	private Message_interface dao;

	public MessageService() {
		dao = new MessageDAO();
	}

	public MessageVO addMessage(String ReceivedAccount, String SendAccount,String title, String Message,boolean isRead,Integer mailType,Timestamp sendtime)
			throws IOException {

		MessageVO mesVO = new MessageVO();
		mesVO.setReceivedAccount(ReceivedAccount);
		mesVO.setSendAccount(SendAccount);
		mesVO.setTitle(title);
		mesVO.setMessage(Message);
		mesVO.setIsRead(isRead);
		mesVO.setMailType(mailType);
		mesVO.setSendtime(sendtime);
		dao.insert(mesVO);
		return mesVO;
	}

	public MessageVO update(Integer MesId, String ReceivedAccount,String title, String SendAccount, String Message,boolean isRead,Integer mailType, Timestamp sendtime) {

		MessageVO mesVO = new MessageVO();
		mesVO.setReceivedAccount(ReceivedAccount);
		mesVO.setSendAccount(SendAccount);
		mesVO.setTitle(title);
		mesVO.setMessage(Message);
		mesVO.setIsRead(isRead);
		mesVO.setMailType(mailType);
		mesVO.setSendtime(sendtime);
		dao.update(mesVO);

		return dao.findByPrimaryKey(MesId);
	}
	
	public void updateIsRead(Integer MesId){
		dao.updateIsRead(MesId);
	}

	public void delete(Integer MesId) {
		dao.delete(MesId);
	}

	public MessageVO getOneRest(Integer MesId) {
		return dao.findByPrimaryKey(MesId);
	}
	
	public List<MessageVO> getReceive(String Account){
		return dao.findByReceived(Account);
	}
	
	public List<MessageVO> getAllMes() {
		return dao.selectAll();
	}
	
	public Long getIsNotReadCount(String ReceivedAccount){
		return dao.getIsNotReadCount(ReceivedAccount);
	}
	
}
