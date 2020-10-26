package com.pr.project.dao;

import com.pr.project.model.LoginIp;

public interface LoginIpDao {

	LoginIp select_ip(String i_id);

	int insert_ip(LoginIp loginip);

}
