package message.Model;

import java.io.Serializable;
import java.sql.Timestamp;

public class MessageVO implements Serializable {
	private Integer MesId;
	private String ReceivedAccount;
	private String SendAccount;
	private String Title;
	private String Message;
	private Boolean isRead;
	private Timestamp sendtime;
	private Integer MailType;
	
	public Integer getMailType() {
		return MailType;
	}
	public void setMailType(Integer mailType) {
		MailType = mailType;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public Timestamp getSendtime() {
		return sendtime;
	}
	public void setSendtime(Timestamp sendtime) {
		this.sendtime = sendtime;
	}
	public Integer getMesId() {
		return MesId;
	}
	public void setMesId(Integer mesId) {
		MesId = mesId;
	}
	public String getReceivedAccount() {
		return ReceivedAccount;
	}
	public void setReceivedAccount(String receivedAccount) {
		ReceivedAccount = receivedAccount;
	}
	public String getSendAccount() {
		return SendAccount;
	}
	public void setSendAccount(String sendAccount) {
		SendAccount = sendAccount;
	}
	public String getMessage() {
		return Message;
	}
	public void setMessage(String message) {
		Message = message;
	}
	public Boolean getIsRead() {
		return isRead;
	}
	public void setIsRead(Boolean isRead) {
		this.isRead = isRead;
	}
	

}
