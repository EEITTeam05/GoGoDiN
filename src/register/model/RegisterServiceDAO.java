package register.model;

import java.io.IOException;
import java.sql.SQLException;

import com.login_Model.loginService;

public class RegisterServiceDAO implements RegisterService_interface {

	@Override
	synchronized public boolean idExists(String id) throws IOException, SQLException {
		loginService ls = new loginService();
		if (ls.getMemberList().containsKey(id.trim().toLowerCase())
				|| ls.getShopList().containsKey(id.trim().toLowerCase())
				   || ls.getAdminList().containsKey(id.trim().toLowerCase())) {
			return true;
		}
		return false;
	}
}
