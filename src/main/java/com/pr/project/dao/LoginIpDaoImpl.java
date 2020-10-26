package com.pr.project.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pr.project.model.LoginIp;

@Repository
public class LoginIpDaoImpl implements LoginIpDao {
	
	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public LoginIp select_ip(String i_id) {
		return sst.selectOne("loginipns.select_ip", i_id);
	}

	@Override
	public int insert_ip(LoginIp loginip) {
		System.out.println("dao에서  id 받음"+loginip.getI_id());
		System.out.println("dao에서 ip 받음"+ loginip.getI_ip());
		return sst.insert("loginipns.insert_ip",loginip);
	}
}
