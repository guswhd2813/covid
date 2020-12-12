package gara.corona.admin.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import gara.corona.admin.dao.AdminDAO;

@Service("adminService")
public class AdminServiceImpl implements AdminService{
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="adminDAO")
	private AdminDAO adminDAO;

	
}
