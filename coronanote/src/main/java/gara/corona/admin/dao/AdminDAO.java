package gara.corona.admin.dao;

import java.util.Map;

import org.springframework.stereotype.Repository;
import gara.corona.common.dao.AbstractDAO;

@Repository("adminDAO")
public class AdminDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception{
		return (Map<String, Object>)selectOne("adminrDAO.selectFileInfo", map);
	}
}
