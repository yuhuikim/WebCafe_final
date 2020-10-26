package com.pr.project.service;

import com.pr.project.model.LoginIp;

public interface LoginIpService {
	
	LoginIp select_ip(String i_id);

	int insert_ip(LoginIp loginip);

}
